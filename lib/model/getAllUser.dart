class getAllUser {
  List<Result>? result;
  int? statusCode;

  getAllUser({this.result, this.statusCode});

  getAllUser.fromJson(Map<String, dynamic> json) {
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

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
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