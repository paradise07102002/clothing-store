class ResetPassword {
  int? id;
  String? oldPassword;
  String? newPassword;

  ResetPassword({this.id, this.oldPassword, this.newPassword});

  ResetPassword.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    return data;
  }
}