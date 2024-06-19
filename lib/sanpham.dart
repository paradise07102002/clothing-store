class Product {
  int? id;
  String? name;
  String? des;
  int? price;
  String? image;

  Product({this.id, this.name, this.des, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    des = json['des'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['des'] = this.des;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}