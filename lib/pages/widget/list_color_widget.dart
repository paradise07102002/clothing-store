import 'package:clothing_store/model/colorProduct.dart';
import 'package:clothing_store/pages/detail_product.dart';
import 'package:clothing_store/pages/widget/color_widget.dart';
import 'package:flutter/material.dart';

class ListColorWidget extends StatefulWidget {
  const ListColorWidget({super.key, required this.colorProducts});

  final List<ColorProduct> colorProducts;
  State<ListColorWidget> createState() => _ListColorWidget();
}
class _ListColorWidget extends State<ListColorWidget> {
  int _selectedIndex = -1; //No color selected initially
  void _selectColor(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,
        ),
        itemCount: widget.colorProducts.length,
        itemBuilder: (context, index) {
          final colorProduct = widget.colorProducts[index];
          return ColorWidget(colorProduct: colorProduct, isSelected: _selectedIndex == index, onTap: () => _selectColor(index),
          );
        },
      ),
    );
  }
}