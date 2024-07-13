class PutCartItem {
  int? productVariantId;
  int? quantity;
  bool? isIncreasedBy;

  PutCartItem({this.productVariantId, this.quantity, this.isIncreasedBy});

  PutCartItem.fromJson(Map<String, dynamic> json) {
    productVariantId = json['productVariantId'];
    quantity = json['quantity'];
    isIncreasedBy = json['isIncreasedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productVariantId'] = this.productVariantId;
    data['quantity'] = this.quantity;
    data['isIncreasedBy'] = this.isIncreasedBy;
    return data;
  }
}