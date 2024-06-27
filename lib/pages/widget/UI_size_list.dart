import 'package:clothing_store/model/sizeProduct.dart';
import 'package:flutter/material.dart';
import '../detail_product.dart';

class SizeWidget extends StatefulWidget {
  const SizeWidget({super.key, required this.sizeProduct, required this.isSelected, required this.onTap});

  final SizeProduct sizeProduct;
  final bool isSelected;
  final VoidCallback onTap;

  State<SizeWidget> createState() => _SizeWidget();

}
class _SizeWidget extends State<SizeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: widget.isSelected ? Colors.blue : Colors.grey, width: 3.0),
            shape: BoxShape.rectangle
        ),
        child: Stack(
          children: [
            Center(
              child: Expanded(child: Text(widget.sizeProduct.size, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black), overflow: TextOverflow.ellipsis,),),
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