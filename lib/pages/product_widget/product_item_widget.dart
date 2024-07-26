import 'package:clothing_store/pages/cart/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatefulWidget{
  const ProductItemWidget({super.key, required this.product});

  final Product product;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidget();
}
class _ProductItemWidget extends State<ProductItemWidget> {
  bool _isSelected = false;
  void _tonggleSelection(bool? newValue) {
    setState(() {
      _isSelected = newValue ?? false;
    });
  }
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border:Border.all(color: Colors.black, width: 1.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isSelected,
            onChanged: _tonggleSelection,
          ),
          const SizedBox(width: 10.0,),
          Image.asset(widget.product.imageURL, width: 96.0, height: 96.0,),
          Expanded(child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.product.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),
              Text(widget.product.price, style: const TextStyle(fontSize: 16.0, color: Colors.orange), overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: 35.0,),
                  Container(
                    height: 36.0,
                    width: 36.0,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.orange
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove, color: Colors.white, size: 18.0,),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  const Text('1', style: TextStyle(fontSize: 18.0),),
                  const SizedBox(width: 10.0,),
                  Container(
                    height: 36.0,
                    width: 36.0,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.orange
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add, color: Colors.white, size: 18.0,),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          ),
          const SizedBox(width: 45.0,),
        ],
      ),
    );
  }
}
