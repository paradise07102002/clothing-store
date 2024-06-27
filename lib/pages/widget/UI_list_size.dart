import 'package:clothing_store/model/sizeProduct.dart';
import 'package:clothing_store/pages/detail_product.dart';
import 'package:clothing_store/pages/widget/UI_size_list.dart';
import 'package:flutter/material.dart';

class ListSizeWidget extends StatefulWidget {
  const ListSizeWidget({super.key, required this.sizeProducts});

  final List<SizeProduct> sizeProducts;

  State<ListSizeWidget> createState() => _ListSizeWidget();

}
class _ListSizeWidget extends State<ListSizeWidget> {
  int _selectedIndex = -1; //No color selected initially
  void _selectSize(int index) {
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
        itemCount: widget.sizeProducts.length,
        itemBuilder: (context, index) {
          final sizeProduct = widget.sizeProducts[index];
          return SizeWidget(sizeProduct: sizeProduct, isSelected: _selectedIndex == index, onTap: () => _selectSize(index));
        },
      ),
    );
  }
}