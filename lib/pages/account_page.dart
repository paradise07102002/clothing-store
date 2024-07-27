import 'dart:convert';

import 'package:clothing_store/pages/detail_product.dart';
import 'package:clothing_store/provider/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store/view/widget_switch.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/testdiglog.dart';
import 'package:clothing_store/main.dart';
import '../provider/language_provider.dart';
import 'package:clothing_store/showResetPass.dart';
import 'package:clothing_store/pages/historyOrder.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}
class _AccountPage extends State<AccountPage> {
  bool isLoggedIn = false;
  late String userName = '';
  late int userId = 0;
  String fullname = 'FullName';
  String email = '';
  String phoneNumber = '';
  // int userId = 0;


  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('changeLanguage') ?? ''),
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

  void _showUserInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('Infor') ?? ''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Username: $userName'),
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

    SharedPreferences isLogin = await SharedPreferences.getInstance();
    await isLogin.setBool('isLogin', false);
    await prefs.remove('token');
    await prefs.remove('user');
    await prefs.remove('userId');
    setState(() async {
      isLoggedIn = isLogin.getBool('isLogin') ?? false;

      userName = '';// Update login state after logout
      checkLoginStatus();
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
  void _testdiglog2() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return RePassDialog();
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
        userId = user['id'];
        email = user['email'];
        phoneNumber = user['phoneNumber'];
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
        Row(
          children: [
            SizedBox(width: 15.0),
            Expanded(
                child: Text(AppLocalizations.of(context)?.translate('account') ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0), overflow: TextOverflow.ellipsis,))
          ],
        ),
        const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // color: const Color(0xFFF9EAEA)
          ),
          child: GestureDetector(
            onTap: () {
              _showUserInfoDialog();
            },
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
                Expanded(child: Text(fullname, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)),
                const Icon(
                  Icons.edit,
                  size: 32.0,
                )
              ],
            ),
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
              Expanded(child: Text(AppLocalizations.of(context)?.translate('darkMode') ?? '', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)),
              SwitchScreen(),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SizedBox(width: 35.0),
            Expanded(child: Text(AppLocalizations.of(context)?.translate('profile') ?? '', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)),
          ],
        ),
        SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPage(userId: userId)));
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
                      'assets/edit_profile.png',
                      fit: BoxFit.contain,),
                  ),
                ),
                const SizedBox(width: 7.0),
                Expanded(child: Text(AppLocalizations.of(context)?.translate('historyPurchase') ?? '', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
                const Icon(
                  Icons.chevron_right,
                  size: 48.0,
                )
              ],
            ),
          ),

        ),
        SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              _testdiglog2();
              //lolo
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
                        'assets/reset_password.png',
                        fit: BoxFit.contain,),
                    ),
                  ),
                  const SizedBox(width: 7.0),
                  Expanded(child: Text(AppLocalizations.of(context)?.translate('resetPassword') ?? '', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
                  const Icon(
                    Icons.chevron_right,
                    size: 48.0,
                  )
                ],
              ),
          ),
        ),
        SizedBox(height: 35.0),
        Row(
          children: [
            SizedBox(width: 35.0),
            Expanded(child: Text(AppLocalizations.of(context)?.translate('regional') ?? '', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)),
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
          child: GestureDetector(
            onTap: () {
              //kkk
              _showLanguageDialog();
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
                      'assets/language.png',
                      fit: BoxFit.contain,),
                  ),
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)?.translate('language') ?? '',
                    style: TextStyle(fontSize: 18.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Expanded(child: Text(AppLocalizations.of(context).translate('language'), style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
                const Icon(
                  Icons.chevron_right,
                  size: 48.0,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(5.0),
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
                Expanded(child: Text(AppLocalizations.of(context)?.translate('logout') ?? '', style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis,)),
                const Icon(
                  Icons.chevron_right,
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




    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Column(
      children: [
        const SizedBox(height: 35.0,),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text(AppLocalizations.of(context)?.translate('login') ?? '', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,),),
            )
          ],
        ),
        const SizedBox(height: 25.0,),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: Text(AppLocalizations.of(context)?.translate('username') ?? '', style: TextStyle(fontSize: 18.0,),),
            )
          ],
        ),
        const SizedBox(height: 5.0),
        FieldInput(textEditingController: _userNameController, title: AppLocalizations.of(context)?.translate('enterUsername') ?? '',),
        const SizedBox(height: 15.0),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: Text(AppLocalizations.of(context)?.translate('password') ?? '', style: TextStyle(fontSize: 18.0,),),
            )
          ],
        ),
        const SizedBox(height: 5.0),
        FieldInputPass(textEditingController: _passwordController, title: AppLocalizations.of(context)?.translate('enterPassword') ?? '', ),
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
                  try {
                    if(response.statusCode == 200) {
                      QuickAlert.show(context: context, type: QuickAlertType.success, text: 'Đăng nhập thành công');
                      final Map<String, dynamic> responseData =jsonDecode(response.body);
                      final String token = responseData['result']['token'];
                      final Map<String, dynamic> user = responseData['result']['user'];

                      int idUser = responseData['result']['user']['id'];

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('token', token);
                      await prefs.setString('user', jsonEncode(user));
                      await prefs.setInt('userId', idUser);

                      SharedPreferences isLogin = await SharedPreferences.getInstance();
                      isLogin.setBool('isLogin', true);


                      setState(() {
                        isLoggedIn = isLogin.getBool('isLogin') ?? false;
                        idNguoiDung = prefs.getInt('userId') ?? 0;
                      });

                      print("Login successful");
                    } else {
                      QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Đăng nhập thất bại');
                      print('Failed to login. Status code: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      throw Exception('Failed to login');
                    }
                  } catch(e) {
                    QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Đăng nhập thất bại');
                    debugPrint('hghg: ${response.body}');
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
                child: Text(AppLocalizations.of(context)?.translate('login') ?? '', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
        SizedBox(height: 25.0),
        Row(
          children: [
            SizedBox(width: 35.0),
            Text(AppLocalizations.of(context)?.translate('noAccount') ?? '', style: TextStyle(fontSize: 20.0, color: Colors.blue),),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  _testdiglog();
                },
                // style: TextButton.styleFrom(
                //   textStyle: TextStyle(fontSize: 28.0)
                // ),
                child: Text(AppLocalizations.of(context)?.translate('registerNow') ?? '', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20.0),),
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
  const FieldInput({super.key, required this.textEditingController, required this.title});
  final TextEditingController textEditingController;
  final String title;
  // final Color lableColor;
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
                labelStyle: TextStyle(color: Colors.red)// Set hint text
            ),
            style: const TextStyle(fontSize: 16.0), // Set text style
          ),
        )
      ],
    );
  }
}
class FieldInputPass extends StatefulWidget {
  const FieldInputPass({super.key, required this.textEditingController, required this.title,});
  final TextEditingController textEditingController;
  final String title;
  // final Color lableColor;
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
              labelStyle: TextStyle(color: Colors.red),
            ),
            style: const TextStyle(fontSize: 16.0), // Set
            obscureText: true,// text style
          ),
        )
      ],
    );
  }
}