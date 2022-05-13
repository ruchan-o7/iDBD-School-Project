import 'dart:convert';

class CommentModelFromRTD {
  String? comment;
  String? commenterId;
  CommentModelFromRTD({
    this.comment,
    this.commenterId,
  });

  CommentModelFromRTD copyWith({
    String? comment,
    String? commenterId,
  }) {
    return CommentModelFromRTD(
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

  factory CommentModelFromRTD.fromMap(Map<String, dynamic> map) {
    return CommentModelFromRTD(
      comment: map['comment'],
      commenterId: map['commenterId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModelFromRTD.fromJson(String source) => CommentModelFromRTD.fromMap(json.decode(source));

  @override
  String toString() => 'commentModelFromRTD(comment: $comment, commenterId: $commenterId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModelFromRTD && other.comment == comment && other.commenterId == commenterId;
  }

  @override
  int get hashCode => comment.hashCode ^ commenterId.hashCode;
}
