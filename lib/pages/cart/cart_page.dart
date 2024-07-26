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

import '../../provider/app_localizations.dart';
import '../product_widget/product_list_widget.dart';


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


class Product {
  final String id;
  final String imageURL;
  final String name;
  final String price;

  Product({required this.id, required this. imageURL, required this.name, required this.price});
}
