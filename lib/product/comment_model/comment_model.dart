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
