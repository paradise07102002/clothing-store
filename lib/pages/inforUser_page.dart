import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/app_localizations.dart'; // Thay đổi đường dẫn nếu cần

class InforUserPage extends StatefulWidget {
  const InforUserPage({Key? key}) : super(key: key);

  @override
  _InforUserPageState createState() => _InforUserPageState();
}

class _InforUserPageState extends State<InforUserPage> {
  String username = '';
  String fullname = '';
  String email = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      setState(() {
        username = user['userName'];
        fullname = user['fullName'];
        email = user['email'];
        phoneNumber = user['phoneNumber'];
      });
    }
  }

  void _showUserInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('Infor') ?? ''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Username: $username'),
                SizedBox(height: 8.0),
                Text('Full Name: $fullname'),
                SizedBox(height: 8.0),
                Text('Email: $email'),
                SizedBox(height: 8.0),
                Text('Phone Number: $phoneNumber'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showUserInfoDialog();
          },
          child: Text('Show User Info'),
        ),
      ),
    );
  }
}
