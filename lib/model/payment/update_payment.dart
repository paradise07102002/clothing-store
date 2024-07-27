class UpdatePayment {
  Result? result;
  int? statusCode;

  UpdatePayment({this.result, this.statusCode});

  UpdatePayment.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? url;

  Result({this.message, this.url});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['url'] = this.url;
    return data;
  }
}