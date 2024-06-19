class Product {
  int? id;
  String? nameProduct;
  String? desProduct;
  int? priceProduct;
  String? imageProduct;

  Product(
      {this.id,
        this.nameProduct,
        this.desProduct,
        this.priceProduct,
        this.imageProduct});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameProduct = json['nameProduct'];
    desProduct = json['desProduct'];
    priceProduct = json['priceProduct'];
    imageProduct = json['imageProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameProduct'] = this.nameProduct;
    data['desProduct'] = this.desProduct;
    data['priceProduct'] = this.priceProduct;
    data['imageProduct'] = this.imageProduct;
    return data;
  }
}