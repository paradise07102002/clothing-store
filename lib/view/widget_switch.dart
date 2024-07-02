import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  @override
  State<SwitchScreen> createState() => _SwitchScreen();
}

class _SwitchScreen extends State<SwitchScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
      ),
    );
  }
}