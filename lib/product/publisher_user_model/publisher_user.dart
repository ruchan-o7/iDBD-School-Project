import 'dart:convert';

import 'package:flutter/foundation.dart';

class PublisherUser {
  bool? isPublisher;
  String? userId;
  String? userName;
  String? userTitle;
  String? photo;
  List<String>? onGoingRequests;
  PublisherUser({
    this.isPublisher,
    this.userId,
    this.userName,
    this.userTitle,
    this.photo,
    this.onGoingRequests,
  });

  PublisherUser copyWith({
    bool? isPublisher,
    String? userId,
    String? userName,
    String? userTitle,
    String? photo,
    List<String>? onGoingRequests,
  }) {
    return PublisherUser(
      isPublisher: isPublisher ?? this.isPublisher,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userTitle: userTitle ?? this.userTitle,
      photo: photo ?? this.photo,
      onGoingRequests: onGoingRequests ?? this.onGoingRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isPublisher': isPublisher,
      'userId': userId,
      'userName': userName,
      'userTitle': userTitle,
      'photo': photo,
      'onGoingRequest': onGoingRequests,
    };
  }

  factory PublisherUser.fromMap(Map<String, dynamic> map) {
    return PublisherUser(
      isPublisher: map['isPublisher'],
      userId: map['userId'],
      userName: map['userName'],
      userTitle: map['userTitle'],
      photo: map['photo'],
      onGoingRequests: List<String>.from(map['onGoingRequests']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PublisherUser.fromJson(String source) => PublisherUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PublisherUser(isPublisher: $isPublisher, userId: $userId, userName: $userName, userTitle: $userTitle, photo: $photo, onGoingRequests: $onGoingRequests)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublisherUser &&
        other.isPublisher == isPublisher &&
        other.userId == userId &&
        other.userName == userName &&
        other.userTitle == userTitle &&
        other.photo == photo &&
        listEquals(other.onGoingRequests, onGoingRequests);
  }

  @override
  int get hashCode {
    return isPublisher.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        userTitle.hashCode ^
        photo.hashCode ^
        onGoingRequests.hashCode;
  }
}
