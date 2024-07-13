import 'package:clothing_store/api/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clothing_store/model/cart/getCart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clothing_store/main.dart';
import 'package:clothing_store/model/cart/addCartItem.dart';
import 'package:clothing_store/model/cart/deleteCartItem.dart' as DeleteCartItemModel;

import '../provider/app_localizations.dart';


GetCart? cartData;

Future<void> fetchData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  idNguoiDung = preferences.getInt('userId') ?? 0;
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Cart/GetCartByUserId/$idNguoiDung'));

  debugPrint('ccc: ${idNguoiDung}');
  if (response.statusCode == 200) {
    cartData = GetCart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load cart');
  }
}
double calculateTotalPrice() {
  double total = 0;
  if (cartData != null && cartData!.result != null && cartData!.result!.cartItems != null) {
    for (var item in cartData!.result!.cartItems!) {
      total += (item.productVariant!.price ?? 0) * (item.quantity ?? 0);
    }
  }
  return total;
}
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  double totalPrice = 0;

  void _showAlertDialog(String ggg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(ggg),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 45.0,),
        Expanded(
          child: Text(
            AppLocalizations.of(context)?.translate('cart') ?? '',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15.0,),
        Container(
          height: 1.0,
          width: 350.0,
          color: Colors.black,
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // ProductListWidget(products: products),
              ProductListWidget()
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          height: 1.0,
          color: Colors.black,
        ),
        const SizedBox(height: 25.0,),
        const SizedBox(height: 25.0,),
        SizedBox(
          width: 350.0,
          height: 50.0,
          child: TextButton(onPressed: () {
            setState(() {
              fetchData();
              totalPrice = calculateTotalPrice();
            });
            // _showAlertDialog('$totalPrice');
          },
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange,
              textStyle: const TextStyle(fontSize: 18.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            //THANH TOÁN
            child: Text(AppLocalizations.of(context)?.translate('payNow') ?? '', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
          ),
        ),
        const SizedBox(height: 45.0,),
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
//UI FOR LIST PRODUCT
class ProductListWidget extends StatefulWidget{
  const ProductListWidget({super.key});

  // final List<Product> products;
  // GetCart? cartData;


  @override
  State<ProductListWidget> createState() => _ProductListWidget();
}
class _ProductListWidget extends State<ProductListWidget> {
  // GetCart? cartData;

  void _showAlertDialog(String ggg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(ggg),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idNguoiDung = preferences.getInt('userId') ?? 0;
    });
    final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Cart/GetCartByUserId/$idNguoiDung'));

    debugPrint('ccc: ${idNguoiDung}');
    if (response.statusCode == 200) {
      setState(() {
        cartData = GetCart.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<int> layGiaTriInt() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('userId') ?? 0;  // Trả về 0 nếu không có giá trị nào được lưu
  }
  void iiiI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idNguoiDung = preferences.getInt('userId');
    });
    _showAlertDialog('$idNguoiDung');
  }


  Future<void> deleteCartQuantity(int idCart, int cartItem,int idProductVariant) async {
    final apiUrl = 'http://10.0.2.2:5117/api/Cart/$idCart/lineItems/$cartItem';

    DeleteCartItemModel.DeleteCartItem deleteCartItem = DeleteCartItemModel.DeleteCartItem(
        productVariantId: idProductVariant,
        quantity: 0,
        isIncreasedBy: true
    );

    String jsonBody = json.encode(deleteCartItem.toJson());

    final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonBody
    );

    try {
      if (response.statusCode == 200) {
        fetchData();
      } else {
        debugPrint('fff: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('ggg: ${response.statusCode}');
    }
  }
  Future<void> _refreshData() async {
    await fetchData();
  }
  @override
  Widget build(BuildContext context){

    return Container(
      height: 500.0,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: RefreshIndicator(
        onRefresh: _refreshData ,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: cartData!.result!.cartItems!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.9,
            mainAxisSpacing: 25.0,
          ),
          itemBuilder: (context, index) {
            final cartItem = cartData!.result!.cartItems![index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border:Border.all(color: Colors.black, width: 1.0),
              ),
              child: Row(
                children: [
                  // Checkbox(
                  //   value: _isSelected,
                  //   onChanged: _tonggleSelection,
                  // ),
                  const SizedBox(width: 10.0,),
                  Image.network(cartItem.productVariant!.variantValues![0].optionValue!.thumbnail ?? 'assets/products/product4.png', width: 96.0, height: 96.0,),
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: Expanded(child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150.0,
                          child: Column(
                            children: [
                              // Text(cartItem.productVariant!.variantValues![0].optionValue!.thumbnail ?? '', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),
                              Text(cartItem.productVariant!.variantName ?? '', style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),
                              Text(cartItem.productVariant!.price.toString() + " VND" ?? '', style: const TextStyle(fontSize: 16.0, color: Colors.red), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Container(
                          width: 175.0,
                          child: Row(
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
                                  onPressed: () {
                                    int newQuantity = cartItem.quantity ?? 0;
                                    if (newQuantity < 2) return;
                                    newQuantity--;
                                    setState(() {
                                      cartItem.quantity = newQuantity;
                                    });
                                    updateCartQuantity(
                                        cartItem.cartId ?? 0,
                                        cartItem.id ?? 0,
                                        cartItem.productVariant!.id ?? 0,
                                        newQuantity);
                                    // updateCartQuantity(cartItem.cartId ?? 0, cartItem.productVariant!.id ?? 0);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10.0,),
                              Container(
                                width: 35.0,
                                alignment: Alignment.center,
                                child: Text(cartItem.quantity.toString() ?? '0', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                              ),
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
                                  onPressed: () {
                                    int newQuantity = cartItem.quantity ?? 0;
                                    if (newQuantity < 1) return;
                                    setState(() {
                                      newQuantity++;
                                      cartItem.quantity = newQuantity;
                                    });
                                    updateCartQuantity(
                                        cartItem.cartId ?? 0,
                                        cartItem.id ?? 0,
                                        cartItem.productVariant!.id ?? 0,
                                        newQuantity);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 60.0),
                    margin: EdgeInsets.only(left: 5.0),
                    child: Container(
                      height: 36.0,
                      width: 36.0,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.red
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete, color: Colors.white, size: 18.0,),
                        onPressed: () {
                          deleteCartQuantity(
                              cartItem.cartId ?? 0,
                              cartItem.id ?? 0,
                              cartItem.productVariant!.id ?? 0
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
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
