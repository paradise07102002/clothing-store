class GetOptionValueById {
  List<Result>? result;
  int? statusCode;

  GetOptionValueById({this.result, this.statusCode});

  GetOptionValueById.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? optionId;
  String? value;
  int? productId;
  String? thumbnail;

  Result({this.id, this.optionId, this.value, this.productId, this.thumbnail});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionId = json['optionId'];
    value = json['value'];
    productId = json['productId'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['optionId'] = this.optionId;
    data['value'] = this.value;
    data['productId'] = this.productId;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}