import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clothing_store/view/widget_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/main.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/testdiglog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}
class _AccountPage extends State<AccountPage> {
  bool isLoggedIn = false;
  late String userName = '';
  String fullname = 'FullName';

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _loadUserInfo();
  }

  // Check if user is logged in based on token presence
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? user = prefs.getString('user');
    setState(() {
      isLoggedIn = token != null;
      // if(isLoggedIn) {
      //   userName = user ?? '';// Update login state
      // }
      // isLoggedIn = true;
    });
  }
  // Logout action
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    setState(() {
      isLoggedIn = false;
      userName = '';// Update login state after logout
    });
  }
  // Show logout confirmation dialog
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
                _logout(); // Perform logout
                Navigator.of(context).pop(); // Close dialog
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
        return RegisterDialog();
      }
    );
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      return user;
    }
    return {};
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
    _loadUserInfo();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 45.0),
          isLoggedIn
            ? _buildLogged()
            : _buildLoginButton(),
        ],
      ),
    );
  }
  Widget _buildLogged() {
    return Column(
      children: [
        const SizedBox(height: 45.0),
        const Row(
          children: [
            SizedBox(width: 15.0),
            Text('Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black))
          ],
        ),
        const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xFFF9EAEA)
          ),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 96.0,
                height: 96.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(
                      color: Colors.black,
                      width: 1.0
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://www.vietnamworks.com/hrinsider/wp-content/uploads/2023/12/anh-den-ngau-012.jpg',
                    fit: BoxFit.contain,),
                ),
              ),
              const SizedBox(width: 7.0),
              Expanded(child: Text(userName, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)),
              const Icon(
                Icons.edit,
                color: Colors.black,
                size: 32.0,
              )
            ],
          ),
        ),
        const SizedBox(height: 35.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     color: Color(0xFFF9EAEA)
          // ),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(
                      color: Colors.black,
                      width: 3.0
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/dark_mode.png',
                    fit: BoxFit.contain,),
                ),
              ),
              const SizedBox(width: 7.0),
              const Expanded(child: Text('Dark mode', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)),
              SwitchScreen(),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 35.0),
            Expanded(child: Text('Profile', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)),
          ],
        ),
        SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     color: const Color(0xFFF9EAEA)
          // ),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(
                      color: Colors.black,
                      width: 1.0
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/edit_profile.png',
                    fit: BoxFit.contain,),
                ),
              ),
              const SizedBox(width: 7.0),
              const Expanded(child: Text('Edit profile', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
              const Icon(
                Icons.chevron_right,
                color: Colors.black,
                size: 48.0,
              )
            ],
          ),

        ),
        SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     color: const Color(0xFFF9EAEA)
          // ),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(
                      color: Colors.black,
                      width: 1.0
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/reset_password.png',
                    fit: BoxFit.contain,),
                ),
              ),
              const SizedBox(width: 7.0),
              const Expanded(child: Text('Change password', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
              const Icon(
                Icons.chevron_right,
                color: Colors.black,
                size: 48.0,
              )
            ],
          ),
        ),
        SizedBox(height: 35.0),
        Row(
          children: [
            SizedBox(width: 35.0),
            Expanded(child: Text('Regional', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     color: const Color(0xFFF9EAEA)
          // ),
          child: Row(
            children: [
              const SizedBox(width: 15.0),
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55.0),
                  border: Border.all(
                      color: Colors.black,
                      width: 1.0
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/language.png',
                    fit: BoxFit.contain,),
                ),
              ),
              const SizedBox(width: 7.0),
              const Expanded(child: Text('Languge', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
              const Icon(
                Icons.chevron_right,
                color: Colors.black,
                size: 48.0,
              )
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.0),
          //     color: const Color(0xFFF9EAEA)
          // ),
          child: GestureDetector(
            onTap: () {
              _showLogoutDialog();
            },
            child: Row(
              children: [
                const SizedBox(width: 15.0),
                Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55.0),
                    border: Border.all(
                        color: Colors.black,
                        width: 1.0
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logout.png',
                      fit: BoxFit.contain,),
                  ),
                ),
                const SizedBox(width: 7.0),
                const Expanded(child: Text('Logout', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 48.0,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildLoginButton() {
    //success
    String _lableUsername = 'Nhập username';
    String _lablePassword = 'Nhập mật khẩu';


    Color _lbColorUser = Colors.black;
    Color _lbColorPassword = Colors.black;


    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _login() async {
      final String username = _userNameController.text;
      final String password = _passwordController.text;

      try {
        await loginUser(username, password);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng nhập ok'))
        );
        setState(() {
          isLoggedIn = true;
          userName = '';// Update login state after logout
        });
        // //Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => AccountPage()),
        // );
      } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng nhập thất bại: $e'))
        );
      }
    }
    return Column(
      children: [
        const SizedBox(height: 35.0,),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: const Text('Login', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),),
            )
          ],
        ),
        const SizedBox(height: 25.0,),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: const Text('Tên đăng nhập', style: TextStyle(fontSize: 18.0, color: Colors.black),),
            )
          ],
        ),
        const SizedBox(height: 5.0),
        FieldInput(textEditingController: _userNameController, title: _lableUsername, lableColor: _lbColorUser,),
        const SizedBox(height: 15.0),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: const Text('Mật khẩu', style: TextStyle(fontSize: 18.0, color: Colors.black),),
            )
          ],
        ),
        const SizedBox(height: 5.0),
        FieldInputPass(textEditingController: _passwordController, title: _lablePassword, lableColor: _lbColorPassword,),
        SizedBox(height: 25),
        Row(
          children: [
            Container(
              width: 375.0,
              height: 65.0,
              margin: const EdgeInsets.only(left: 15.0),
              child: TextButton(
                onPressed: () async {
                  // _login();
                  final String apiUrl = 'http://10.0.2.2:5117/api/User/login';

                  try {
                    final response = await http.post(
                      Uri.parse(apiUrl),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'username': _userNameController.text,
                        'password': _passwordController.text,
                      }),
                    );
                    if(response.statusCode == 200) {
                      final Map<String, dynamic> responseData =jsonDecode(response.body);
                      final String token = responseData['result']['token'];
                      final Map<String, dynamic> user = responseData['result']['user'];

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('token', token);
                      await prefs.setString('user', jsonEncode(user));

                      setState(() {
                        isLoggedIn = true;
                      });

                      print("Login successful");
                    } else {
                      print('Failed to login. Status code: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      throw Exception('Failed to login');
                    }
                  } catch(e) {
                    print('Error: $e');
                    throw Exception('Failed to login');
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                child: const Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
        SizedBox(height: 25.0),
        Row(
          children: [
            SizedBox(width: 35.0),
            Text('Bạn chưa có tài khoản', style: TextStyle(fontSize: 20.0, color: Colors.blue),),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  _testdiglog();
                },
                // style: TextButton.styleFrom(
                //   textStyle: TextStyle(fontSize: 28.0)
                // ),
                child: Text('Đăng ký ngay', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20.0),),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ToggleSwitch extends StatefulWidget {
  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}


class FieldInput extends StatefulWidget {
  const FieldInput({super.key, required this.textEditingController, required this.title, required this.lableColor});
  final TextEditingController textEditingController;
  final String title;
  final Color lableColor;
  @override
  State<FieldInput> createState() => _FieldInput();
}
class _FieldInput extends State<FieldInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0),
          width: 375,
          child: TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0), // Set border radius for rounded corners
                    borderSide: const BorderSide(color: Colors.blue) // Set border color
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0), // Set content padding
                prefixIcon: Icon(Icons.people),
                labelText: widget.title,
                labelStyle: TextStyle(color: widget.lableColor)// Set hint text
            ),
            style: const TextStyle(fontSize: 16.0), // Set text style
          ),
        )
      ],
    );
  }
}
class FieldInputPass extends StatefulWidget {
  const FieldInputPass({super.key, required this.textEditingController, required this.title, required this.lableColor});
  final TextEditingController textEditingController;
  final String title;
  final Color lableColor;
  @override
  State<FieldInputPass> createState() => _FieldInputPass();
}
class _FieldInputPass extends State<FieldInputPass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0),
          width: 375,
          child: TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0), // Set border radius for rounded corners
                  borderSide: const BorderSide(color: Colors.blue) // Set border color
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0), // Set content padding
              prefixIcon: Icon(Icons.lock),
              labelText: widget.title,
              labelStyle: TextStyle(color: widget.lableColor),
            ),
            style: const TextStyle(fontSize: 16.0), // Set
            obscureText: true,// text style
          ),
        )
      ],
    );
  }
}