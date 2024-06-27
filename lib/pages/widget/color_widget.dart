import 'package:clothing_store/model/colorProduct.dart';
import 'package:clothing_store/model/sizeProduct.dart';
import 'package:clothing_store/pages/detail_product.dart';
import 'package:flutter/material.dart';

class ColorWidget extends StatefulWidget {
  const ColorWidget({super.key, required this.colorProduct, required this.isSelected, required this.onTap});

  final ColorProduct colorProduct;
  final bool isSelected;
  final VoidCallback onTap;

  State<ColorWidget> createState() => _ColorWidget();
}
class _ColorWidget extends State<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: widget.isSelected ? Colors.blue : Colors.grey, width: 3.0)
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Colors.grey, width: 2.0),
                      color: hexColor(widget.colorProduct.color),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: widget.isSelected ? Icon(Icons.check_box, color: Colors.blue, size: 15.0,) : null,
            )
          ],
        ),
      ),
    );
  }
}