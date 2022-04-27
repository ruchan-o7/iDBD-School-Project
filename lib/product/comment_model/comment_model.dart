// // To parse this JSON data, do
// //
// //     final commentModel = commentModelFromJson(jsonString);

// import 'dart:convert';

// BaseModel commentModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

// String commentModelToJson(BaseModel data) => json.encode(data.toJson());

// class BaseModel {
//   BaseModel({
//     this.comments,
//     this.users,
//   });

//   List<CommentsModel>? comments;
//   List<UserModel>? users;

//   BaseModel copyWith({
//     List<CommentsModel>? comments,
//     List<UserModel>? users,
//   }) =>
//       BaseModel(
//         comments: comments ?? this.comments,
//         users: users ?? this.users,
//       );

//   factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
//         comments: json["comments"] == null
//             ? null
//             : List<CommentsModel>.from(json["comments"].map((x) => CommentsModel.fromJson(x))),
//         users: json["users"] == null
//             ? null
//             : List<UserModel>.from(json["users"].map((x) => UserModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "comments": comments == null ? null : List<dynamic>.from(comments!.map((x) => x.toJson())),
//         "users": users == null ? null : List<dynamic>.from(users!.map((x) => x.toJson())),
//       };
// }

// class CommentsModel {
//   CommentsModel({
//     this.bookId,
//     this.comment,
//   });

//   String? bookId;
//   List<CommentModel>? comment;

//   CommentsModel copyWith({
//     String? bookId,
//     List<CommentModel>? comment,
//   }) =>
//       CommentsModel(
//         bookId: bookId ?? this.bookId,
//         comment: comment ?? this.comment,
//       );

//   factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
//         bookId: json["bookId"] == null ? null : json["bookId"],
//         comment: json["comment"] == null
//             ? null
//             : List<CommentModel>.from(json["comment"].map((x) => CommentModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "bookId": bookId == null ? null : bookId,
//         "comment": comment == null ? null : List<dynamic>.from(comment!.map((x) => x.toJson())),
//       };
// }

// class CommentModel {
//   CommentModel({
//     this.comment,
//     this.time,
//     this.userUid,
//   });

//   String? comment;
//   String? time;
//   String? userUid;

//   CommentModel copyWith({
//     String? comment,
//     String? time,
//     String? userUid,
//   }) =>
//       CommentModel(
//         comment: comment ?? this.comment,
//         time: time ?? this.time,
//         userUid: userUid ?? this.userUid,
//       );

//   factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
//         comment: json["comment"] == null ? null : json["comment"],
//         time: json["time"] == null ? null : json["time"],
//         userUid: json["userUid"] == null ? null : json["userUid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "comment": comment == null ? null : comment,
//         "time": time == null ? null : time,
//         "userUid": userUid == null ? null : userUid,
//       };
// }

// class UserModel {
//   UserModel({
//     this.likedBooks,
//     this.markedBook,
//     this.ownedBooks,
//     this.userUid,
//   });

//   List<String>? likedBooks;
//   List<String>? markedBook;
//   List<String>? ownedBooks;
//   String? userUid;

//   UserModel copyWith({
//     List<String>? likedBooks,
//     List<String>? markedBook,
//     List<String>? ownedBooks,
//     String? userUid,
//   }) =>
//       UserModel(
//         likedBooks: likedBooks ?? this.likedBooks,
//         markedBook: markedBook ?? this.markedBook,
//         ownedBooks: ownedBooks ?? this.ownedBooks,
//         userUid: userUid ?? this.userUid,
//       );

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         likedBooks: json["likedBooks"] == null ? null : List<String>.from(json["likedBooks"].map((x) => x)),
//         markedBook: json["markedBook"] == null ? null : List<String>.from(json["markedBook"].map((x) => x)),
//         ownedBooks: json["ownedBooks"] == null ? null : List<String>.from(json["ownedBooks"].map((x) => x)),
//         userUid: json["userUID"] == null ? null : json["userUID"],
//       );

//   Map<String, dynamic> toJson() => {
//         "likedBooks": likedBooks == null ? null : List<dynamic>.from(likedBooks!.map((x) => x)),
//         "markedBook": markedBook == null ? null : List<dynamic>.from(markedBook!.map((x) => x)),
//         "ownedBooks": ownedBooks == null ? null : List<dynamic>.from(ownedBooks!.map((x) => x)),
//         "userUID": userUid == null ? null : userUid,
//       };
// }

import 'dart:convert';

class commentModelFromRTD {
  String? comment;
  String? commenterId;
  commentModelFromRTD({
    this.comment,
    this.commenterId,
  });

  commentModelFromRTD copyWith({
    String? comment,
    String? commenterId,
  }) {
    return commentModelFromRTD(
      comment: comment ?? this.comment,
      commenterId: commenterId ?? this.commenterId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'commenterId': commenterId,
    };
  }

  factory commentModelFromRTD.fromMap(Map<String, dynamic> map) {
    return commentModelFromRTD(
      comment: map['comment'],
      commenterId: map['commenterId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory commentModelFromRTD.fromJson(String source) => commentModelFromRTD.fromMap(json.decode(source));

  @override
  String toString() => 'commentModelFromRTD(comment: $comment, commenterId: $commenterId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is commentModelFromRTD && other.comment == comment && other.commenterId == commenterId;
  }

  @override
  int get hashCode => comment.hashCode ^ commenterId.hashCode;
}
