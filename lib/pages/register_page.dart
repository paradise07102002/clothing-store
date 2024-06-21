import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/signup.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}
class _RegisterPage extends State<RegisterPage> {
  //success
  String _lableUsername = 'Nhập username';
  String _lableFullName = 'Nhập họ và tên';
  String _lablePhone = 'Nhập số điện thoại';
  String _lableEmail = 'Nhập email';
  String _lablePassword = 'Nhập mật khẩu';
  String _lableRePassword = 'Nhập lại mật khẩu';


  Color _lbColorUser = Colors.black;
  Color _lbColorFullName = Colors.black;
  Color _lbColorPhone = Colors.black;
  Color _lbColorEmail = Colors.black;
  Color _lbColorPassword = Colors.black;
  Color _lbColorRePassword = Colors.black;


  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  //Check email
  bool _validateEmail(TextEditingController email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$',
    );
    return emailRegExp.hasMatch(email.text);
  }
  //Check phone
  bool _isValidPhoneNumber(TextEditingController phoneNumber) {
    final RegExp phoneRegExp = RegExp(
      r'^\+?[0-9]{10,15}$',
    );
    return phoneRegExp.hasMatch(phoneNumber.text);
  }
  //check password and re-password
  bool _arePasswordsMatching(TextEditingController password, TextEditingController rePassword) {
    return password.text == rePassword.text;
  }

  //Udapte lable
  void _updateLabelEmail(String newLabel, Color newLabelColor) {
    setState(() {
      _lableEmail = newLabel;
      _lbColorEmail = newLabelColor;
    });
  }
  void _updateLabelPhone(String newLabel, Color newLabelColor) {
    setState(() {
      _lablePhone = newLabel;
      _lbColorPhone = newLabelColor;
    });
  }
  void _updateLabelRePassword(String newLabel, Color newLabelColor) {
    setState(() {
      _lableRePassword = newLabel;
      _lbColorRePassword = newLabelColor;
    });
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
                    child: const Text('Create Account', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 25.0,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: const Text('Tên đăng nhập', style: TextStyle(fontSize: 24.0, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              FieldInput(textEditingController: _userNameController, title: _lableUsername, lableColor: _lbColorUser,),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: const Text('Họ và tên', style: TextStyle(fontSize: 24.0, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              FieldInput(textEditingController: _fullNameController, title: _lableFullName, lableColor: _lbColorFullName,),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: const Text('Email', style: TextStyle(fontSize: 24.0, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              FieldInput(textEditingController: _emailController, title: _lableEmail, lableColor: _lbColorEmail,),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: const Text('Số điện thoại', style: TextStyle(fontSize: 24.0, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              FieldInput(textEditingController: _phoneNumberController, title: _lablePhone, lableColor: _lbColorPhone,),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: const Text('Mật khẩu', style: TextStyle(fontSize: 24.0, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              FieldInputPass(textEditingController: _passwordController, title: _lablePassword, lableColor: _lbColorPassword,),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15.0),
                    child: const Text('Xác nhận mật khẩu', style: TextStyle(fontSize: 24.0, color: Colors.black),),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              FieldInputPass(textEditingController: _rePasswordController, title: _lableRePassword, lableColor: _lbColorRePassword,),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Container(
                    width: 375.0,
                    height: 65.0,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: TextButton(
                      onPressed: () async {
                        if (_validateEmail(_emailController) == false) {
                          setState(() {
                            _updateLabelEmail('Email không hợp lệ', Colors.red);
                            return;
                          });
                        }
                        else if (_isValidPhoneNumber(_phoneNumberController) == false) {
                          _updateLabelPhone('Số điện thoại không hợp lệ', Colors.red);
                          return;
                        }
                        else if (_arePasswordsMatching(_passwordController, _rePasswordController) == false) {
                          _updateLabelRePassword('Mật khẩu mới không trùng khớp', Colors.red);
                          return;
                        } else {
                          _updateLabelEmail('Nhập email', Colors.black);
                          _updateLabelPhone('Nhập số điện thoại', Colors.black);
                          _updateLabelRePassword('Nhập lại mật khẩu', Colors.black);

                          SignUp newUser = SignUp(
                            userName: _userNameController.text,
                            fullName: _fullNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          try {
                            await registerUser(newUser);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User register successfully')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failedto register user')),
                            );
                          }
                        }
                    },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 18.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                      ),
                      child: const Text('Đăng ký', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Set content padding
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Set content padding
                labelText: widget.title,
                labelStyle: TextStyle(color: widget.lableColor)// Set hint text
            ),
            style: const TextStyle(fontSize: 16.0), // Set
            obscureText: true,// text style
          ),
        )
      ],
    );
  }
}

