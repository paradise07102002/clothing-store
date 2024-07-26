import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/provider/app_localizations.dart';
import 'package:clothing_store/view/widget_switch.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/pages/cart/cart_page.dart';
import 'package:clothing_store/main.dart';
import 'package:clothing_store/testdiglog.dart' as testdiglog;
import 'package:clothing_store/pages/account_widget/field_input.dart' as field_input;
import 'package:clothing_store/pages/account_widget/field_input_pass.dart' as field_input_pass;
import 'package:clothing_store/provider/language_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  bool isLoggedIn = false;
  late String userName = '';
  String fullname = 'FullName';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('payNow') ?? ''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('English'),
                onTap: () {
                  context.read<LanguageProvider>().changeLanguage('en');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Tiếng Việt'),
                onTap: () {
                  context.read<LanguageProvider>().changeLanguage('vi');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _loadUserInfo();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    setState(() {
      isLoggedIn = token != null;
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    await prefs.remove('userId');
    setState(() {
      isLoggedIn = false;
      userName = '';
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                _logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _testdiglog() {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return testdiglog.RegisterDialog();
      }
    );
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      setState(() {
        userName = user['userName'];
        fullname = user['fullName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 45.0),
          isLoggedIn ? _buildLogged() : _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLogged() {
    return Column(
      children: [
        const SizedBox(height: 45.0),
        Row(
          children: [
            SizedBox(width: 15.0),
            Expanded(
              child: Text(
                AppLocalizations.of(context)?.translate('account') ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                overflow: TextOverflow.ellipsis,
              )
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 96.0,
                height: 96.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://www.vietnamworks.com/hrinsider/wp-content/uploads/2023/12/anh-den-ngau-012.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 7.0),
              Expanded(
                child: Text(
                  fullname,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.edit,
                size: 32.0,
              )
            ],
          ),
        ),
        const SizedBox(height: 35.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(color: Colors.black, width: 3.0),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/dark_mode.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 7.0),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)?.translate('darkMode') ?? '',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SwitchScreen(),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 10.0),
            Expanded(
              child: ElevatedButton(
                onPressed: _showLogoutDialog,
                child: Text(AppLocalizations.of(context)?.translate('logout') ?? ''),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              field_input.FieldInput(
                textEditingController: TextEditingController(),
                title: AppLocalizations.of(context)?.translate('enterUsername') ?? '',
              ),
              const SizedBox(height: 10.0),
              field_input_pass.FieldInputPass(
                textEditingController: TextEditingController(),
                title: AppLocalizations.of(context)?.translate('enterPassword') ?? '',
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)?.translate('login') ?? ''),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
