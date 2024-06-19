import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clothing_store/sanpham.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5144/api/Product'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}