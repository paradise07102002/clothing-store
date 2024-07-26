import 'package:flutter/material.dart';

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
