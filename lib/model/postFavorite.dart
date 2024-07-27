class PostFavorite {
  Result? result;
  int? statusCode;

  PostFavorite({this.result, this.statusCode});

  PostFavorite.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  int? id;
  int? wishlistId;
  Null? product;

  Result({this.id, this.wishlistId, this.product});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wishlistId = json['wishlistId'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wishlistId'] = this.wishlistId;
    data['product'] = this.product;
    return data;
  }
}