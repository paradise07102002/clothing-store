import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clothing_store/model/signup.dart';

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