import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final bool value;
  final Function(bool value) onTap;
  
  const SettingSwitch({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    required this.value, required Null Function(bool newValue) onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value ? "On" : "Off",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 20),
          CupertinoSwitch(
            value: value,
            onChanged: onTap,
          ),
        ],
      ),
    );
  }
}
