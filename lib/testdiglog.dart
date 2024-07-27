import 'package:clothing_store/provider/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/signup.dart';
import 'package:quickalert/quickalert.dart';

class RegisterDialog extends StatefulWidget {
  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  //success
  String _lableUsername = 'Nhập username';
  String _lableFullName = 'Nhập họ và tên';
  String _lablePhone = 'Nhập phone';
  String _lableEmail = 'Nhập email';
  String _lablePassword = 'Nhập mật khẩu';
  String _lableRePassword = 'Nhập lại mật khẩu';


  Color _lbColorUser = Colors.red;
  Color _lbColorFullName = Colors.red;
  Color _lbColorPhone = Colors.red;
  Color _lbColorEmail = Colors.red;
  Color _lbColorPassword = Colors.red;
  Color _lbColorRePassword = Colors.red;


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
    return AlertDialog(
      title: Text(AppLocalizations.of(context)?.translate('register') ?? ''),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15.0,),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(AppLocalizations.of(context)?.translate('username') ?? '', style: TextStyle(fontSize: 18.0,),),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInput(textEditingController: _userNameController, title: AppLocalizations.of(context)?.translate('enterUsername') ?? '', lableColor: _lbColorUser,),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(AppLocalizations.of(context)?.translate('fullName') ?? '', style: TextStyle(fontSize: 18.0,),),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInput(textEditingController: _fullNameController, title: AppLocalizations.of(context)?.translate('enterFullname') ?? '', lableColor: _lbColorFullName,),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: const Text('Email', style: TextStyle(fontSize: 18.0,),),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInput(textEditingController: _emailController, title: _lableEmail, lableColor: _lbColorEmail,),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(AppLocalizations.of(context)?.translate('phone') ?? '', style: TextStyle(fontSize: 18.0,),),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInput(textEditingController: _phoneNumberController, title: _lablePhone, lableColor: _lbColorPhone,),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(AppLocalizations.of(context)?.translate('password') ?? '', style: TextStyle(fontSize: 18.0,),),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInputPass(textEditingController: _passwordController, title: _lablePassword, lableColor: _lbColorPassword,),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(AppLocalizations.of(context)?.translate('confirmPassword') ?? '', style: TextStyle(fontSize: 18.0,),),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInputPass(textEditingController: _rePasswordController, title: _lableRePassword, lableColor: _lbColorRePassword,),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(AppLocalizations.of(context)?.translate('cancel') ?? ''),
        ),
        TextButton(
          onPressed: () async{
            // Perform registration logic here
            {
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
                  QuickAlert.show(context: context, type: QuickAlertType.success, text: 'Đăng ký thành công');
                } catch (e) {
                  QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Đăng ký thất bại');
                }
              }
            }
            // Close the dialog
            // Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)?.translate('register') ?? ''),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
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
          margin: const EdgeInsets.only(left: 5.0),
          width: 260.0,
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
          margin: const EdgeInsets.only(left: 5.0),
          width: 260.0,
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