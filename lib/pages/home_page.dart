import 'package:clothing_store/pages/widget/product_widget/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:clothing_store/pages/detail_product.dart';
import 'register_page.dart';
import '../model/category.dart';
import '../model/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Category> categories = [
    Category(id: '1', imageURL: "assets/products/product5.png", name: "Hat"),
    Category(id: '2', imageURL: "assets/products/product1.png", name: "Shirts"),
    Category(id: '3', imageURL: "assets/products/product4.png", name: "Pants"),
    Category(
        id: '4', imageURL: "assets/categories/category1.png", name: "Shoes"),
  ];
  List<Product> products = [
    Product(
      id: "1",
      imageURL: "assets/products/product1.png",
      name:
          "Sản phẩm 11111111111111111111111111111111111111111111111111111111111",
      price: "500.000.000 đ",
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
    return SingleChildScrollView(
      child: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(300.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF486EFF),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AppBar(
                          title: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Fashion shops',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0, bottom: 30.0),
                      width: 350.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(0.5),
                      child: const TextField(
                        // Replace Row with TextField
                        decoration: InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Tìm kiếm',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      height: 120.0,
                      width: double.infinity,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 5.0,
                          // crossAxisSpacing: 15.0,
                          // childAspectRatio: 1,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          {
                            final category = categories[index];
                            return Column(
                              children: [
                                Container(
                                  width: 64.0,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    category.imageURL,
                                    width: 4.0,
                                    height: 4.0,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              ProductListWidget(title: 'Sản phẩm bán chạy', products: products),
              ProductListWidget(title: 'Sản phẩm mới nhất', products: products),
              ProductListWidget(title: 'Sản phẩm khác', products: products),
            ],
          ),
        ],
      ),
    );
  }
}
