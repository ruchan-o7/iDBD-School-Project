// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookRequestModel _$BookRequestModelFromJson(Map<String, dynamic> json) =>
    BookRequestModel(
      id: json['id'] as String,
      isApproved: json['isApproved'] as bool? ?? false,
      volumeInfo:
          VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookRequestModelToJson(BookRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isApproved': instance.isApproved,
      'volumeInfo': instance.volumeInfo,
    };
