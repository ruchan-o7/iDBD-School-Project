import 'dart:convert';

import '../../../product/base_model/book_response_mode.dart';

class BookRequestModel {
  String id;
  bool isApproved;
  VolumeInfo volumeInfo;
  BookRequestModel({
    required this.id,
    this.isApproved = false,
    required this.volumeInfo,
  });

  BookRequestModel copyWith({
    String? id,
    bool? isApproved,
    VolumeInfo? volumeInfo,
  }) {
    return BookRequestModel(
      id: id ?? this.id,
      isApproved: isApproved ?? this.isApproved,
      volumeInfo: volumeInfo ?? this.volumeInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isApproved': isApproved,
      'volumeInfo': volumeInfo.toJson(),
    };
  }

  factory BookRequestModel.fromMap(Map<String, dynamic> map) {
    return BookRequestModel(
      id: map['id'] ?? '',
      isApproved: map['isApproved'] ?? false,
      volumeInfo: VolumeInfo.fromJson(map['volumeInfo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookRequestModel.fromJson(String source) => BookRequestModel.fromMap(json.decode(source));

  @override
  String toString() => 'BookRequestModel(id: $id, isApproved: $isApproved, volumeInfo: $volumeInfo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookRequestModel &&
        other.id == id &&
        other.isApproved == isApproved &&
        other.volumeInfo == volumeInfo;
  }

  @override
  int get hashCode => id.hashCode ^ isApproved.hashCode ^ volumeInfo.hashCode;
}
