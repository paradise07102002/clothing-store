class SignUp {
  String? userName;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? password;

  SignUp(
      {this.userName,
        this.fullName,
        this.phoneNumber,
        this.email,
        this.password});

  SignUp.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}