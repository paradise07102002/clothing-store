class GetFavorite {
  List<Result>? result;
  int? statusCode;

  GetFavorite({this.result, this.statusCode});

  GetFavorite.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Result {
  int? id;
  int? userId;
  String? createAt;
  String? lastUpdate;
  List<WishlistItems>? wishlistItems;

  Result(
      {this.id,
        this.userId,
        this.createAt,
        this.lastUpdate,
        this.wishlistItems});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createAt = json['createAt'];
    lastUpdate = json['lastUpdate'];
    if (json['wishlistItems'] != null) {
      wishlistItems = <WishlistItems>[];
      json['wishlistItems'].forEach((v) {
        wishlistItems!.add(WishlistItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['createAt'] = createAt;
    data['lastUpdate'] = lastUpdate;
    if (wishlistItems != null) {
      data['wishlistItems'] = wishlistItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistItems {
  int? id;
  int? wishlistId;
  Product? product;

  WishlistItems({this.id, this.wishlistId, this.product});

  WishlistItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wishlistId = json['wishlistId'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wishlistId'] = wishlistId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  int? categoryId;
  int? price;
  String? thumbnail;
  List<dynamic>? productVariants; // Use dynamic instead of Null

  Product(
      {this.id,
        this.name,
        this.description,
        this.categoryId,
        this.price,
        this.thumbnail,
        this.productVariants});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    categoryId = json['categoryId'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    if (json['productVariants'] != null) {
      productVariants = <dynamic>[];
      json['productVariants'].forEach((v) {
        productVariants!.add(v); // No need to call `fromJson` on dynamic
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['price'] = price;
    data['thumbnail'] = thumbnail;
    if (productVariants != null) {
      data['productVariants'] = productVariants;
    }
    return data;
  }
}
