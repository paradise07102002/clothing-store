import 'package:clothing_store/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import '../account_widget/account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage> {
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
      //Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountPage()),
      );
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập thất bại: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 15.0,),
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FD),
                      borderRadius: BorderRadius.circular(7.0)
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back, color: Colors.blue, size: 48.0,),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)
                    ),
                  ),
                ),
              ],
            ),
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
                      _login();
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
            )
          ],
        ),
      ),
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

