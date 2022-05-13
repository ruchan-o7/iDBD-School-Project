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
        imageUrl: json["imageUrl"],
        userMail: json["userMail"],
        userName: json["userName"],
        userPassword: json["userPassword"],
        userUid: json["userUID"],
        signDate: json["signDate"],
        likedBooks: json["likedBooks"] == null ? null : List<String>.from(json["likedBooks"].map((x) => x)),
        ownedBooks: json["ownedBooks"] == null ? null : List<String>.from(json["ownedBooks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "userMail": userMail,
        "userName": userName,
        "userPassword": userPassword,
        "userUID": userUid,
        "signDate": signDate,
        "likedBooks": likedBooks == null ? null : List<dynamic>.from(likedBooks!.map((x) => x)),
        "ownedBooks": ownedBooks == null ? null : List<dynamic>.from(ownedBooks!.map((x) => x)),
      };
}
