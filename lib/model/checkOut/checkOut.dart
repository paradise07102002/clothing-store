class CheckOut {
  String? address;
  int? total;
  int? promotionId;
  int? paymentId;

  CheckOut({this.address, this.total, this.promotionId, this.paymentId});

  CheckOut.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    total = json['total'];
    promotionId = json['promotionId'];
    paymentId = json['paymentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['total'] = this.total;
    data['promotionId'] = this.promotionId;
    data['paymentId'] = this.paymentId;
    return data;
  }
}