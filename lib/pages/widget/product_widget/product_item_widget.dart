import 'package:clothing_store/model/product.dart';
import 'package:clothing_store/pages/detail_product.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key, required this.product});

  final Product product;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidget();
}
class _ProductItemWidget extends State<ProductItemWidget>{
  bool _isFavorite = false;

  void _tonggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductPage()));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        // width: 128.0,
        // height: 128.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 125.0,),
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: _tonggleFavorite,
                      iconSize: 32.0,
                    ),
                  ],
                ),
              ),
              Image.asset(widget.product.imageURL, width: 64.0, height: 64.0,),
              Expanded(child: Text(widget.product.name, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),),
              Expanded(child: Text(widget.product.price, style: const TextStyle(fontSize: 12.0, color: Colors.red), overflow: TextOverflow.ellipsis,),)
            ],
          ),
      ),
    );
  }
}