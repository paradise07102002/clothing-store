import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getFavorite.dart' as GetFavoriteModel;

class FavoriteProductList extends StatefulWidget {
  final int userId;

  const FavoriteProductList({super.key, required this.userId});

  @override
  _FavoriteProductListState createState() => _FavoriteProductListState();
}

class _FavoriteProductListState extends State<FavoriteProductList> {
  late Future<GetFavoriteModel.GetFavorite> futureGetFavorite;

  @override
  void initState() {
    super.initState();
    futureGetFavorite = getWishlistByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetFavoriteModel.GetFavorite>(
      future: futureGetFavorite,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.result == null || snapshot.data!.result!.isEmpty) {
          return const Center(child: Text('No favorite products found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.result!.length,
            itemBuilder: (context, index) {
              var wishlistItem = snapshot.data!.result![index].wishlistItems;
              if (wishlistItem == null || wishlistItem.isEmpty) {
                return Container();
              }
              return Column(
                children: wishlistItem.map((item) {
                  var product = item.product;
                  return ListTile(
                    leading: Image.network(product?.thumbnail ?? '', width: 50, height: 50),
                    title: Text(product?.name ?? ''),
                    subtitle: Text('Price: ${product?.price.toString() ?? ''}'),
                  );
                }).toList(),
              );
            },
          );
        }
      },
    );
  }
}
