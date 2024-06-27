import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  List<Product> products = [
    Product(
      id: "1",
      imageURL: "assets/products/product1.png",
      name: "Sản phẩm 1sfdddddddđsssssssssssssssssssssssssssss",
      price: "100.000đ 777777777777777777777777777777777777777777",
    ),
    Product(
      id: "2",
      imageURL: "assets/products/product2.png",
      name: "Sản phẩm 2",
      price: "100.000 đ",
    ),
    Product(
      id: "3",
      imageURL: "assets/products/product3.png",
      name: "Sản phẩm 3",
      price: "100.000 đ",
    ),
    Product(
      id: "4",
      imageURL: "assets/products/product4.png",
      name: "Sản phẩm 4",
      price: "100.000 đ",
    ),
    Product(
      id: "5",
      imageURL: "assets/products/product5.png",
      name: "Sản phẩm 5",
      price: "100.000 đ",
    ),
    Product(
      id: "6",
      imageURL: "assets/products/product6.png",
      name: "Sản phẩm 6",
      price: "100.000 đ",
    ),
    Product(
      id: "7",
      imageURL: "assets/products/product7.png",
      name: "Sản phẩm 7",
      price: "100.000 đ",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   height: 120.0,
        //   decoration: BoxDecoration(
        //     color: Color(0xFF486EFF),
        //     borderRadius: BorderRadius.only(
        //         bottomRight: Radius.circular(30.0),
        //         bottomLeft: Radius.circular(30.0)),
        //   ),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       SizedBox(width: 15.0,),
        //       SizedBox(
        //         width: 48.0,
        //         height: 48.0,
        //         child: IconButton(
        //           icon: Icon(
        //             Icons.arrow_back, color: Colors.white, size: 48.0,),
        //           onPressed: () {},
        //           style: ButtonStyle(
        //               padding: MaterialStateProperty.all(EdgeInsets.zero)
        //           ),
        //         ),
        //       ),
        //       const SizedBox(width: 120.0,),
        //       Text('Cart', style: TextStyle(color: Colors.white,
        //           fontSize: 24.0,
        //           fontWeight: FontWeight.bold),)
        //     ],
        //   ),
        // ),
        SizedBox(height: 35.0,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15.0,),
            SizedBox(
              width: 48.0,
              height: 48.0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back, color: Colors.black, size: 48.0,),
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)
                ),
              ),
            ),
            const SizedBox(width: 120.0,),
            Text('Cart', style: TextStyle(color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),)
          ],
        ),
        SizedBox(height: 15.0,),
        Container(
          height: 1.0,
          width: 350.0,
          color: Colors.black,
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            children: [
              ProductListWidget(products: products),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          height: 1.0,
          color: Colors.black,
        ),
        SizedBox(height: 25.0,),
        Container(
          child: Row(
            children: [
              SizedBox(width: 35.0,),
              Text('Tổng tiền', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
              SizedBox(width: 125.0,),
              Text('100.000 đ', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.red),),
            ],
          ),
        ),
        SizedBox(height: 25.0,),
        SizedBox(
          width: 350.0,
          height: 50.0,
          child: TextButton(onPressed: () {

          },
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange,
              textStyle: TextStyle(fontSize: 18.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            child: Text('Thanh toán', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    );
  }
}
//UI FOR ITEM ITEM PRODUCT IN CART
class ProductItemWidget extends StatefulWidget{
  const ProductItemWidget({super.key, required this.product});

  final Product product;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidget();
}
class _ProductItemWidget extends State<ProductItemWidget> {
  bool _isSelected = false;
  void _toggleSelection(bool? newValue) {
    setState(() {
      _isSelected = newValue ?? false;
    });
  }
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border:Border.all(color: Colors.black, width: 1.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isSelected,
            onChanged: _toggleSelection,
          ),
          SizedBox(width: 10.0,),
          Image.asset(widget.product.imageURL, width: 96.0, height: 96.0,),
          Expanded(child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.product.name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),
              Text(widget.product.price, style: TextStyle(fontSize: 16.0, color: Colors.orange), overflow: TextOverflow.ellipsis,),
              SizedBox(height: 10.0,),
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
                      icon: Icon(
                        Icons.remove, color: Colors.white, size: 18.0,),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text('1', style: TextStyle(fontSize: 18.0),),
                  SizedBox(width: 10.0,),
                  Container(
                    height: 36.0,
                    width: 36.0,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.orange
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add, color: Colors.white, size: 18.0,),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          ),
          SizedBox(width: 45.0,),
        ],
      ),
    );
  }
}
//UI FOR LIST PRODUCT
class ProductListWidget extends StatefulWidget{
  const ProductListWidget({super.key, required this.products});

  final List<Product> products;

  @override
  State<ProductListWidget> createState() => _ProductListWidget();
}
class _ProductListWidget extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 500.0,
      width: double.infinity,
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.9,
          mainAxisSpacing: 25.0,
        ),
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return ProductItemWidget(product: product);
        },
      ),
    );
  }
}


