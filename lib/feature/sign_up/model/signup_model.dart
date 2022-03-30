class UserSignUpModel {
  String? imageUrl;
  String? userMail;
  String? userName;
  String? userPassword;
  String? userUID;
  String? signDate;

  UserSignUpModel(
      {this.imageUrl,
      this.userMail,
      this.userName,
      this.userPassword,
      this.userUID,
      this.signDate});

  UserSignUpModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    userMail = json['userMail'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userUID = json['userUID'];
    signDate = json['signDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['userMail'] = userMail;
    data['userName'] = userName;
    data['userPassword'] = userPassword;
    data['userUID'] = userUID;
    data['signDate'] = signDate;
    return data;
  }
}
