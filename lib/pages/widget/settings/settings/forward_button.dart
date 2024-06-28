import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  const ForwardButton({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 227, 227, 227),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Ionicons.chevron_forward_outline,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
