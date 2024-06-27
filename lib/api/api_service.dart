import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/model/signup.dart';
import 'package:clothing_store/model/category.dart';

//SignUp
Future<void> registerUser(SignUp signUp) async {
  final String apiUrl = 'http://10.0.2.2:5117/api/User/signUp';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signUp.toJson()),
    );

    if (response.statusCode == 200) {
      print("User registered successfully");
    } else {
      print('Failed to register user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to register user');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to register user');
  }
}

// //Get Category
// Future<List<Category>> fetchCategories() async {
//   final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Category'));
//
//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((json) => Category.fromJson(json)).toList();
//   } else {
//     debugPrint('Failed to load categories: ${response.statusCode}');
//     throw Exception('Failed to load Categories');
//   }
// }

// Future<List<Result>> fetchCategories() async {
//   final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Category'));
//   if (response.statusCode == 200) {
//     // Giải mã phản hồi JSON thành một bản đồ
//     Map<String, dynamic> data = json.decode(response.body);
//
//     // Chuyển đổi bản đồ JSON thành đối tượng Category
//     Category category = Category.fromJson(data);
//
//     // Trả về danh sách các Result từ Category
//     return category.result ?? [];
//
//   } else {
//     debugPrint('Failed to load categories: ${response.statusCode}');
//     throw Exception('Failed to load Categories');
//   }
// }

//Get Category
Future<List<Result>> fetchCategories() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Category'));

  if (response.statusCode == 200) {
    // Giải mã phản hồi JSON thành một bản đồ
    Map<String, dynamic> data = json.decode(response.body);

    // Chuyển đổi bản đồ JSON thành đối tượng Category
    Category category = Category.fromJson(data);

    // Trả về danh sách các Result từ Category
    return category.result ?? [];
  } else {
    debugPrint('Failed to load categories: ${response.statusCode}');
    throw Exception('Failed to load Categories');
  }
}