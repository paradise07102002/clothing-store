import 'package:clothing_store/provider/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/signup.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/resetPassword.dart';


class RePassDialog extends StatefulWidget {
  @override
  _RePassDialogState createState() => _RePassDialogState();
}

class _RePassDialogState extends State<RePassDialog> {
  //success

  String _lableOldPassword = 'Nhập mật khẩu cũ';
  String _lablePassword = 'Nhập mật khẩu mới';
  String _lableRePassword = 'Nhập lại mật khẩu mới';


  Color _lbColorUser = Colors.red;
  Color _lbColorFullName = Colors.red;
  Color _lbColorPhone = Colors.red;
  Color _lbColorEmail = Colors.red;
  Color _lbColorPassword = Colors.red;
  Color _lbColorRePassword = Colors.red;


  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  //check password and re-password
  bool _arePasswordsMatching(TextEditingController password, TextEditingController rePassword) {
    return password.text == rePassword.text;
  }

  //Udapte lable
  void _updateLabelEmail(String newLabel, Color newLabelColor) {
    setState(() {
      _lbColorEmail = newLabelColor;
    });
  }

  void _updateLabelRePassword(String newLabel, Color newLabelColor) {
    setState(() {
      _lableRePassword = newLabel;
      _lbColorRePassword = newLabelColor;
    });
  }
  void _updateLabelPassword(String newLabel, Color newLabelColor) {
    setState(() {
      _lableOldPassword = newLabel;
      _lbColorRePassword = newLabelColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)?.translate('resetPassword') ?? ''),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15.0,),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                )
              ],
            ),
            const SizedBox(height: 5.0),
            FieldInputPass(textEditingController: _oldPasswordController, title: _lableOldPassword, lableColor: _lbColorPassword,),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
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
              if (_oldPasswordController.text.trim() == null) {
                _updateLabelPassword('Mật khẩu cũ không chính xác', Colors.red);
              } else if (_arePasswordsMatching(_passwordController, _rePasswordController) == false) {
                _updateLabelRePassword('Mật khẩu mới không trùng khớp', Colors.red);
                return;
              } else {
                _updateLabelRePassword('Nhập lại mật khẩu', Colors.black);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                int idUser = prefs.getInt('userId') ?? 0;
                ResetPassword resetPass = ResetPassword(
                  id: idUser,
                  oldPassword: _oldPasswordController.text,
                  newPassword: _passwordController.text,
                );
                try {
                  await resetPassword(resetPass);
                  QuickAlert.show(context: context, type: QuickAlertType.success, text: 'Đổi mật khẩu thành công');
                } catch (e) {
                  QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Lỗi');
                }
              }
            }
            // Close the dialog
            // Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)?.translate('change') ?? ''),
        ),
      ],
    );
  }

  @override
  void dispose() {
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