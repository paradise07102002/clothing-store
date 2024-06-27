import 'package:clothing_store/model/product.dart';
import 'package:clothing_store/pages/widget/product_widget/product_item_widget.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key, required this.title, required this.products,});

  final String title;
  final List<Product> products;

  @override
  State<ProductListWidget> createState() => _ProductListWidget();
}
class _ProductListWidget extends State<ProductListWidget>{
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 15.0, top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
          const SizedBox(height: 5.0,),
          SizedBox(
            height: 180.0,
            width: double.infinity,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 25.0
              ),
              itemBuilder: (context, index) {
                final product = widget.products[index];
                return ProductItemWidget(product: product);
              },
            ),
          )
        ],
      ),
    );
  }
}