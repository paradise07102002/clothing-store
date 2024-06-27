import 'dart:ui';

class SizeProduct {
  final String size;

  SizeProduct({required this.size});
}
Color hexColor (String code) {
  // if (code.length != 6 && code.length != 8) {
  //   print('Invalid color format: $code');
  //   return Colors.transparent;
  // }
  return Color(int.parse(code, radix: 16) + 0xFF000000);
}