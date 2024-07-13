import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothing_store/dark_mode/theme_notifier.dart';

// class SwitchScreen extends StatefulWidget {
//   @override
//   State<SwitchScreen> createState() => _SwitchScreen();
// }
//
// class _SwitchScreen extends State<SwitchScreen> {
//   bool isSwitched = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Switch(
//         value: isSwitched,
//         onChanged: (value) {
//           setState(() {
//             isSwitched = value;
//           });
//         },
//       ),
//     );
//   }
// }
class SwitchScreen extends StatefulWidget {
  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return Switch(
          value: themeNotifier.isDarkMode,
          onChanged: (value) {
            themeNotifier.toggleTheme();
          },
        );
      },
    );
  }
}