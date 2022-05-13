//25,03,2022 - 19:16     UPTODATE MODEL --> https://www.googleapis.com/books/v1/volumes?q=intibah

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../feature/search_view/model/searched_book_model.dart';
part 'book_response_mode.g.dart';

abstract class BaseDataModel {
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class BookResponseModel extends BaseDataModel {
  String? kind;
  List<Items>? items;

  BookResponseModel({this.kind, this.items});

  factory BookResponseModel.fromJson(Map<String, dynamic> json) => _$BookResponseModelFromJson(json);

  @override
  toJson() => _$BookResponseModelToJson(this);
}

@JsonSerializable()
class Items extends BaseDataModel {
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;

  Items({this.id, this.etag, this.selfLink, this.volumeInfo, this.saleInfo, this.accessInfo});

  @override
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ItemsToJson(this);

  factory Items.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Items(
        accessInfo: data["accesInfo"],
        etag: data["etag"],
        id: data["id"],
        saleInfo: data["saleInfo"],
        selfLink: data["selfLing"],
        volumeInfo: data["volumeInfo"]);
  }
}

@JsonSerializable()
class VolumeInfo extends BaseDataModel {
  String? title;
  List<String>? authors;
  String? publishedDate;
  int? pageCount;
  dynamic averageRating;
  int? ratingsCount;
  dynamic description;
  bool? allowAnonLogging;
  ImageLinks? imageLinks;
  List<String>? categories;
  String? language;

  ///Google play üzerinden satın alma sitesini açar
  String? previewLink;

  ///Google play üzerinden satın alma sitesini açar
  String? infoLink;

  ///Google play üzerinden satın alma sitesini açar
  String? canonicalVolumeLink;

  VolumeInfo(
      {this.title,
      this.authors,
      this.publishedDate,
      this.pageCount,
      this.averageRating,
      this.ratingsCount,
      this.allowAnonLogging,
      this.imageLinks,
      this.language,
      this.description,
      this.previewLink,
      this.categories,
      this.infoLink,
      this.canonicalVolumeLink});

  @override
  factory VolumeInfo.fromJson(Map<String, dynamic> json) => _$VolumeInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VolumeInfoToJson(this);
}

@JsonSerializable()
class SaleInfo extends BaseDataModel {
  String? country;
  String? saleability;
  bool? isEbook;

  SaleInfo({this.country, this.saleability, this.isEbook});

  @override
  factory SaleInfo.fromJson(Map<String, dynamic> json) => _$SaleInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaleInfoToJson(this);
}

@JsonSerializable()
class AccessInfo extends BaseDataModel {
  String? country;
  String? viewability;
  String? textToSpeechPermission;
  Pdf? pdf;

  ///Google play önizleme linki
  String? webReaderLink;
  String? accessViewStatus;
  bool? quoteSharingAllowed;

  AccessInfo(
      {this.country,
      this.viewability,
      this.textToSpeechPermission,
      this.pdf,
      this.webReaderLink,
      this.accessViewStatus,
      this.quoteSharingAllowed});

  factory AccessInfo.fromJson(Map<String, dynamic> json) => _$AccessInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AccessInfoToJson(this);
}

@JsonSerializable()
class Pdf extends BaseDataModel {
  bool? isAvailable;

  Pdf({this.isAvailable});

  factory Pdf.fromJson(Map<String, dynamic> json) => _$PdfFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PdfToJson(this);
}
