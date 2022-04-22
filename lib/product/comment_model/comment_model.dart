// class CommentModel {
//   String? id;
//   List<Comments>? comments;
//   String? rating;

//   CommentModel({this.id, this.comments, this.rating});

//   CommentModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['comments'] != null) {
//       comments = <Comments>[];
//       json['comments'].forEach((v) {
//         comments!.add(new Comments.fromJson(v));
//       });
//     }
//     rating = json['rating'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.comments != null) {
//       data['comments'] = this.comments!.map((v) => v.toJson()).toList();
//     }
//     data['rating'] = this.rating;
//     return data;
//   }
// }

// class Comments {
//   String? commentOwner;
//   String? comment;
//   String? commentTime;

//   Comments({this.commentOwner, this.comment, this.commentTime});

//   Comments.fromJson(Map<String, dynamic> json) {
//     commentOwner = json['commentOwner'];
//     comment = json['comment'];
//     commentTime = json['commentTime'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['commentOwner'] = this.commentOwner;
//     data['comment'] = this.comment;
//     data['commentTime'] = this.commentTime;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

// import 'dart:convert';

// CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

// String commentModelToJson(CommentModel data) => json.encode(data.toJson());

// class CommentModel {
//   CommentModel({
//     this.id,
//     this.comments,
//     this.rating,
//   });

//   String? id;
//   List<Comment>? comments;
//   String? rating;

//   CommentModel copyWith({
//     String? id,
//     List<Comment>? comments,
//     String? rating,
//   }) =>
//       CommentModel(
//         id: id ?? this.id,
//         comments: comments ?? this.comments,
//         rating: rating ?? this.rating,
//       );

//   factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
//         id: json["id"] == null ? null : json["id"],
//         comments: json["comments"] == null
//             ? null
//             : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
//         rating: json["rating"] == null ? null : json["rating"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "comments": comments == null ? null : List<dynamic>.from(comments!.map((x) => x.toJson())),
//         "rating": rating == null ? null : rating,
//       };
// }

// class Comment {
//   Comment({
//     this.commentOwner,
//     this.comment,
//     this.commentTime,
//   });

//   String? commentOwner;
//   String? comment;
//   String? commentTime;

//   Comment copyWith({
//     String? commentOwner,
//     String? comment,
//     String? commentTime,
//   }) =>
//       Comment(
//         commentOwner: commentOwner ?? this.commentOwner,
//         comment: comment ?? this.comment,
//         commentTime: commentTime ?? this.commentTime,
//       );

//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         commentOwner: json["commentOwner"] == null ? null : json["commentOwner"],
//         comment: json["comment"] == null ? null : json["comment"],
//         commentTime: json["commentTime"] == null ? null : json["commentTime"],
//       );

//   Map<String, dynamic> toJson() => {
//         "commentOwner": commentOwner == null ? null : commentOwner,
//         "comment": comment == null ? null : comment,
//         "commentTime": commentTime == null ? null : commentTime,
//       };
// }

// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.comments,
    this.rating,
    this.id,
  });

  List<Comment>? comments;
  String? rating;
  String? id;

  CommentModel copyWith({
    List<Comment>? comments,
    String? rating,
    String? id,
  }) =>
      CommentModel(
        comments: comments ?? this.comments,
        rating: rating ?? this.rating,
        id: id ?? this.id,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        comments: json["comments"] == null
            ? null
            // : List<Comment>.from(json["comments"].map<String, dynamic>((x) => Comment.fromJson(x))),
            : List<Comment>.from(json.entries.map((e) => Comment.fromJson(e.value)).toList()),
        rating: json["rating"] == null ? null : json["rating"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "comments": comments == null ? null : List<dynamic>.from(comments?.map((x) => x.toJson()) ?? {}),
        "rating": rating == null ? null : rating,
        "id": id == null ? null : id,
      };
}

class Comment {
  Comment({
    this.commentOwner,
    this.comment,
    this.commentTime,
  });

  String? commentOwner;
  String? comment;
  String? commentTime;

  Comment copyWith({
    String? commentOwner,
    String? comment,
    String? commentTime,
  }) =>
      Comment(
        commentOwner: commentOwner ?? this.commentOwner,
        comment: comment ?? this.comment,
        commentTime: commentTime ?? this.commentTime,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentOwner: json["commentOwner"] == null ? null : json["commentOwner"],
        comment: json["comment"] == null ? null : json["comment"],
        commentTime: json["commentTime"] == null ? null : json["commentTime"],
      );

  Map<String, dynamic> toJson() => {
        "commentOwner": commentOwner == null ? null : commentOwner,
        "comment": comment == null ? null : comment,
        "commentTime": commentTime == null ? null : commentTime,
      };
}
