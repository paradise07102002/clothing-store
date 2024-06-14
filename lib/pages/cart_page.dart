import 'package:flutter/material.dart';

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
      name: "Sản phẩm 1",
      price: "100.000 đ",
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
        Container(
          height: 120.0,
          decoration: BoxDecoration(
            color: Color(0xFF486EFF),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15.0,),
              SizedBox(
                width: 48.0,
                height: 48.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back, color: Colors.white, size: 48.0,),
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                  ),
                ),
              ),
              const SizedBox(width: 120.0,),
              Text('Cart', style: TextStyle(color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),)
            ],
          ),
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
          margin: EdgeInsets.only(left: 35.0, right: 35.0),
          height: 1.0,
          color: Colors.black,
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Row(
            children: [
              SizedBox(width: 35.0,),
              Text('Tổng tiền', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
              SizedBox(width: 125.0,),
              Text('100.000 đ', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.red),),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 400.0,
          height: 65.0,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: Colors.red, width: 1.0,),
            ),
          child: Text('Thanh toán', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),),
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
  void _tonggleSelection(bool? newValue) {
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
            onChanged: _tonggleSelection,
          ),
          Image.asset(widget.product.imageURL, width: 120.0, height: 120.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0,),
              Text(widget.product.name, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
              Text(widget.product.price, style: TextStyle(fontSize: 18.0, color: Colors.orange),),
              Row(
                children: [
                  Container(
                    height: 32.0,
                    width: 32.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.remove, color: Colors.black, size: 16.0,),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text('1', style: TextStyle(fontSize: 18.0),),
                  SizedBox(width: 10.0,),
                  Container(
                    height: 32.0,
                    width: 32.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add, color: Colors.black, size: 16.0,),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
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


class Product {
  final String id;
  final String imageURL;
  final String name;
  final String price;

  Product({required this.id, required this. imageURL, required this.name, required this.price});
}