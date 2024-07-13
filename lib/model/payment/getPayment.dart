class GetPayment {
  List<Result>? result;
  int? statusCode;

  GetPayment({this.result, this.statusCode});

  GetPayment.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  String? title;
  int? amount;
  String? paymentDate;
  Null? orders;
  int? id;
  bool? isDeleted;
  String? createTime;
  String? lastUpdate;

  Result(
      {this.title,
        this.amount,
        this.paymentDate,
        this.orders,
        this.id,
        this.isDeleted,
        this.createTime,
        this.lastUpdate});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    paymentDate = json['paymentDate'];
    orders = json['orders'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    createTime = json['createTime'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['paymentDate'] = this.paymentDate;
    data['orders'] = this.orders;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['createTime'] = this.createTime;
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }
}