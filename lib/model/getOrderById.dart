class GetOrderById {
  List<Result>? result;
  int? statusCode;

  GetOrderById({this.result, this.statusCode});

  GetOrderById.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  int? total;
  int? promotionId;
  bool? paymentStatus;
  String? paymentUrl;
  int? paymentId;
  String? address;
  Customer? customer;
  Payment? payment;
  Promotion? promotion;

  Result(
      {this.id,
        this.customerId,
        this.total,
        this.promotionId,
        this.paymentStatus,
        this.paymentUrl,
        this.paymentId,
        this.address,
        this.customer,
        this.payment,
        this.promotion});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    total = json['total'];
    promotionId = json['promotionId'];
    paymentStatus = json['paymentStatus'];
    paymentUrl = json['paymentUrl'];
    paymentId = json['paymentId'];
    address = json['address'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    promotion = json['promotion'] != null
        ? new Promotion.fromJson(json['promotion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['total'] = this.total;
    data['promotionId'] = this.promotionId;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentUrl'] = this.paymentUrl;
    data['paymentId'] = this.paymentId;
    data['address'] = this.address;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? fullName;
  String? userName;
  String? phoneNumber;
  String? email;
  int? gender;
  String? createAt;
  String? lastUpdate;
  String? birthday;
  String? role;
  Null? avatar;

  Customer(
      {this.id,
        this.fullName,
        this.userName,
        this.phoneNumber,
        this.email,
        this.gender,
        this.createAt,
        this.lastUpdate,
        this.birthday,
        this.role,
        this.avatar});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    gender = json['gender'];
    createAt = json['createAt'];
    lastUpdate = json['lastUpdate'];
    birthday = json['birthday'];
    role = json['role'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['createAt'] = this.createAt;
    data['lastUpdate'] = this.lastUpdate;
    data['birthday'] = this.birthday;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Payment {
  int? id;
  String? title;

  Payment({this.id, this.title});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Promotion {
  String? name;
  int? promotionTypeId;
  int? promotionValue;
  Null? promotionType;

  Promotion(
      {this.name,
        this.promotionTypeId,
        this.promotionValue,
        this.promotionType});

  Promotion.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    promotionTypeId = json['promotionTypeId'];
    promotionValue = json['promotionValue'];
    promotionType = json['promotionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['promotionTypeId'] = this.promotionTypeId;
    data['promotionValue'] = this.promotionValue;
    data['promotionType'] = this.promotionType;
    return data;
  }
}