import 'dart:convert';

class PublisherUser {
  bool? isPublisher;
  String? userId;
  String? userName;
  String? userTitle;
  String? photo;
  PublisherUser({
    this.isPublisher,
    this.userId,
    this.userName,
    this.userTitle,
    this.photo,
  });

  PublisherUser copyWith({
    bool? isPublisher,
    String? userId,
    String? userName,
    String? userTitle,
    String? photo,
  }) {
    return PublisherUser(
      isPublisher: isPublisher ?? this.isPublisher,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userTitle: userTitle ?? this.userTitle,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isPublisher': isPublisher,
      'userId': userId,
      'userName': userName,
      'userTitle': userTitle,
      'photo': photo,
    };
  }

  factory PublisherUser.fromMap(Map<String, dynamic> map) {
    return PublisherUser(
      isPublisher: map['isPublisher'],
      userId: map['userId'],
      userName: map['userName'],
      userTitle: map['userTitle'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PublisherUser.fromJson(String source) => PublisherUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PublisherUser(isPublisher: $isPublisher, userId: $userId, userName: $userName, userTitle: $userTitle, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublisherUser &&
        other.isPublisher == isPublisher &&
        other.userId == userId &&
        other.userName == userName &&
        other.userTitle == userTitle &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return isPublisher.hashCode ^ userId.hashCode ^ userName.hashCode ^ userTitle.hashCode ^ photo.hashCode;
  }
}
