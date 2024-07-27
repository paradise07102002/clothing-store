import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentWebView extends StatelessWidget {
  final String url;

  PaymentWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PayPal Payment'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          if (url.contains('UpdateOrderPaymentStatus')) {
            // Extract parameters from URL
            Uri uri = Uri.parse(url);
            String paymentId = uri.queryParameters['paymentId']!;
            String token = uri.queryParameters['token']!;
            String payerId = uri.queryParameters['PayerID']!;

            // Call function to update payment status
            _updatePaymentStatus(context, paymentId, token, payerId);
          }
        },
      ),
    );
  }

  Future<void> _updatePaymentStatus(
      BuildContext context, String paymentId, String token, String payerId) async {
    final String apiUrl =
        'http://10.0.2.2:5117/api/Order/UpdateOrderPaymentStatus?paymentId=$paymentId&token=$token&PayerID=$payerId';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // Handle success response, e.g., show a success message or navigate to another screen
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Payment successful!',
      );
    } else {
      // Handle error response, e.g., show an error message
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Payment status update failed. Please try again.',
      );
    }
  }
}
