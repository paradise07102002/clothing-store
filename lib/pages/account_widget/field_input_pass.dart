import 'package:flutter/material.dart';

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