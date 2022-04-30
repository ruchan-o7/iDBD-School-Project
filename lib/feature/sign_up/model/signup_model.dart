import 'dart:convert';

UserSignUpModel userSignUpModelFromJson(String str) => UserSignUpModel.fromJson(json.decode(str));

String userSignUpModelToJson(UserSignUpModel data) => json.encode(data.toJson());

class UserSignUpModel {
  UserSignUpModel({
    this.imageUrl,
    this.userMail,
    this.userName,
    this.userPassword,
    this.userUid,
    this.signDate,
    this.likedBooks,
    this.ownedBooks,
  });

  String? imageUrl;
  String? userMail;
  String? userName;
  String? userPassword;
  String? userUid;
  String? signDate;
  List<String>? likedBooks;
  List<String>? ownedBooks;

  UserSignUpModel copyWith({
    String? imageUrl,
    String? userMail,
    String? userName,
    String? userPassword,
    String? userUid,
    String? signDate,
    List<String>? likedBooks,
    List<String>? ownedBooks,
  }) =>
      UserSignUpModel(
        imageUrl: imageUrl ?? this.imageUrl,
        userMail: userMail ?? this.userMail,
        userName: userName ?? this.userName,
        userPassword: userPassword ?? this.userPassword,
        userUid: userUid ?? this.userUid,
        signDate: signDate ?? this.signDate,
        likedBooks: likedBooks ?? this.likedBooks,
        ownedBooks: ownedBooks ?? this.ownedBooks,
      );

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) => UserSignUpModel(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        userMail: json["userMail"] == null ? null : json["userMail"],
        userName: json["userName"] == null ? null : json["userName"],
        userPassword: json["userPassword"] == null ? null : json["userPassword"],
        userUid: json["userUID"] == null ? null : json["userUID"],
        signDate: json["signDate"] == null ? null : json["signDate"],
        likedBooks: json["likedBooks"] == null ? null : List<String>.from(json["likedBooks"].map((x) => x)),
        ownedBooks: json["ownedBooks"] == null ? null : List<String>.from(json["ownedBooks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl == null ? null : imageUrl,
        "userMail": userMail == null ? null : userMail,
        "userName": userName == null ? null : userName,
        "userPassword": userPassword == null ? null : userPassword,
        "userUID": userUid == null ? null : userUid,
        "signDate": signDate == null ? null : signDate,
        "likedBooks": likedBooks == null ? null : List<dynamic>.from(likedBooks!.map((x) => x)),
        "ownedBooks": ownedBooks == null ? null : List<dynamic>.from(ownedBooks!.map((x) => x)),
      };
}
