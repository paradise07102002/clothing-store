import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<PaymentMethod>> fetchPaymentMethods() async {
  final response = await http.get(Uri.parse('http://localhost:5117/api/Cart/getAllPaymentMethod'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return (jsonResponse['result'] as List)
        .map((paymentMethod) => PaymentMethod.fromJson(paymentMethod))
        .toList();
  } else {
    throw Exception('Failed to load payment methods');
  }
}

class PaymentMethod {
  final String title;
  final int id;

  PaymentMethod({required this.title, required this.id});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      title: json['title'],
      id: json['id'],
    );
  }
}
