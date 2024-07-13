import 'package:clothing_store/model/category.dart' as CategoryModel;
import 'package:flutter/material.dart';
import 'package:clothing_store/pages/detail_product.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getAllProduct.dart' as GetAllProductModel;

import '../provider/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>
{
  @override
  Widget build(BuildContext context)
  {
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
                        padding: EdgeInsets.only(top: 20.0),
                        child: AppBar(
                          title: Align(
                            alignment: Alignment.center,
                            child: Text(AppLocalizations.of(context)?.translate('fashionShop') ?? '', style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
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
                      child: const TextField( // Replace Row with TextField
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Tìm kiếm',
                        ),
                      ),
                    ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  height: 120.0,
                  width: double.infinity,
                  child: const CategoryWidget(),
                ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              ProductListWidget(title: AppLocalizations.of(context)?.translate('newProduct') ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}

//UI FOR ITEM PRODUCT
class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key, required this.getAllProduct});

  final GetAllProductModel.Result getAllProduct;

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
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailProductPage(productId: widget.getAllProduct.id ?? 0))
        );
      },
      child: Container(
        // width: 128.0,
        // height: 128.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 125.0,),
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
              Image.network(widget.getAllProduct.thumbnail ?? '', width: 64.0, height: 64.0,),
              Expanded(child: Text(widget.getAllProduct.name ?? '', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),),
              Expanded(child: Text(widget.getAllProduct.price.toString() ?? '', style: const TextStyle(fontSize: 12.0, color: Colors.red), overflow: TextOverflow.ellipsis,),)
            ],
          ),
      ),
    );
  }
}

//Category
class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidget();
}
class _CategoryWidget extends State<CategoryWidget> {
  late Future<List<CategoryModel.Result>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel.Result>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // debugPrint('Snapshot error: ${snapshot.error}');
          // return Center(child: Text('Lỗi'));
          return Center(child: Text('Snapshot error: ${snapshot.error}'));
        } else if(!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint('No categories found');
          return const Center(child: Text('No Category found'));
        } else {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 5.0,
              // crossAxisSpacing: 15.0,
              // childAspectRatio: 1,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {{
              CategoryModel.Result category = snapshot.data![index];
              return Column(
                children: [
                  Container(
                    width: 64.0,
                    height: 64.0,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.network(category.thumbnail ?? 'https://tse3.mm.bing.net/th?id=OIP.YEvB14OZEQZ2oALiFkJj-wHaE8&pid=Api&P=0&h=180', width: 64.0, height: 64.0, fit: BoxFit.contain),
                    ),
                    // child: Image.network(category.thumbnail ?? 'https://tse3.mm.bing.net/th?id=OIP.YEvB14OZEQZ2oALiFkJj-wHaE8&pid=Api&P=0&h=180'),
                  ),
                  Expanded(child: Text(category.name ?? 'Error', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),)
                ],
              );
            }},
          );
        }
      },
    );
  }
}
//UI FOR LIST PRODUCT
class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key, required this.title});

  final String title;
  @override
  State<ProductListWidget> createState() => _ProductListWidget();
}
class _ProductListWidget extends State<ProductListWidget>{
  late Future<List<GetAllProductModel.Result>> futureGetAllProduct;

  bool _isFavorite = false;

  void _tonggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    futureGetAllProduct = getAllProduct();
  }
  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<GetAllProductModel.Result>>(
        future: futureGetAllProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Snapshot Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            debugPrint('No Product found');
            return Center(child: Text('No Product fount'));
          } else {
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
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 25.0
                      ),
                      itemBuilder: (context, index) {
                        GetAllProductModel.Result getAllProduct = snapshot.data![index];
                        return ProductItemWidget(getAllProduct: getAllProduct);
                      },
                    ),
                  )
                ],
              ),
            );
          }
        }
    );
  }
}
