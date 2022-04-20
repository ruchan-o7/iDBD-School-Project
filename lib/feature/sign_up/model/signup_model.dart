class UserSignUpModel {
  String? imageUrl;
  String? userMail;
  String? userName;
  String? userPassword;
  String? userUID;
  String? signDate;
  List<String>? likedBooks;
  List<String>? ownedBooks;

  UserSignUpModel({
    this.imageUrl,
    this.userMail,
    this.userName,
    this.userPassword,
    this.userUID,
    this.signDate,
  });

  UserSignUpModel.fromJson(Map<String, dynamic> json) {
    likedBooks = json['likedBooks'];
    ownedBooks = json['ownedBooks'];
    imageUrl = json['imageUrl'];
    userMail = json['userMail'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userUID = json['userUID'];
    signDate = json['signDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likedBooks'] = likedBooks;
    data['ownedBooks'] = ownedBooks;
    data['imageUrl'] = imageUrl;
    data['userMail'] = userMail;
    data['userName'] = userName;
    data['userPassword'] = userPassword;
    data['userUID'] = userUID;
    data['signDate'] = signDate;
    return data;
  }

  UserSignUpModel copyWith({
    String? imageUrl,
    String? userMail,
    String? userName,
    String? userPassword,
    String? userUID,
    String? signDate,
  }) {
    return UserSignUpModel(
      imageUrl: imageUrl ?? this.imageUrl,
      userMail: userMail ?? this.userMail,
      userName: userName ?? this.userName,
      userPassword: userPassword ?? this.userPassword,
      userUID: userUID ?? this.userUID,
      signDate: signDate ?? this.signDate,
    );
  }
}
