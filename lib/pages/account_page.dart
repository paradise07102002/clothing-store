import 'package:flutter/material.dart';
import 'package:clothing_store/sanpham.dart';
import 'package:clothing_store/api_service.dart';


class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return
       FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3 / 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name ?? 'No Name',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.black),
                      ),
                      Text('${product.price} VND'),
                      Image.network(product.image ?? 'https://tse3.mm.bing.net/th?id=OIP.YEvB14OZEQZ2oALiFkJj-wHaE8&pid=Api&P=0&h=180', width: 200.0, height: 150.0, fit: BoxFit.cover,)
                    ],
                  ),
                );
              },
            );
          }
        },
      );
  }
}