//25,03,2022 - 19:16     UPTODATE MODEL --> https://www.googleapis.com/books/v1/volumes?q=intibah
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookResponseModel {
  String? kind;
  List<Items>? items;

  BookResponseModel({this.kind, this.items});

  BookResponseModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;

  Items({this.id, this.etag, this.selfLink, this.volumeInfo, this.saleInfo, this.accessInfo});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    etag = json['etag'];
    selfLink = json['selfLink'];
    volumeInfo = json['volumeInfo'] != null ? VolumeInfo.fromJson(json['volumeInfo']) : null;
    saleInfo = json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null;
    accessInfo = json['accessInfo'] != null ? AccessInfo.fromJson(json['accessInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['etag'] = etag;
    data['selfLink'] = selfLink;
    if (volumeInfo != null) {
      data['volumeInfo'] = volumeInfo!.toJson();
    }
    if (saleInfo != null) {
      data['saleInfo'] = saleInfo!.toJson();
    }
    if (accessInfo != null) {
      data['accessInfo'] = accessInfo!.toJson();
    }
    return data;
  }

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

class VolumeInfo {
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

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] == null ? null : List<String>.from(json["categories"].map((x) => x));
    title = json['title'];
    description = json["description"];
    authors = json["authors"] != null ? json['authors'].cast<String>() : null;
    publishedDate = json['publishedDate'];
    pageCount = json['pageCount'];
    averageRating = json["averageRating"] == null ? null : json['averageRating'];
    ratingsCount = json["ratingsCount"] == null ? null : json['ratingsCount'];
    allowAnonLogging = json['allowAnonLogging'];
    imageLinks = json['imageLinks'] != null ? ImageLinks.fromJson(json['imageLinks']) : null;
    language = json['language'];
    previewLink = json['previewLink'];
    infoLink = json['infoLink'];
    canonicalVolumeLink = json['canonicalVolumeLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['authors'] = authors;
    data['publishedDate'] = publishedDate;
    data['description'] = description;
    data['pageCount'] = pageCount;
    data["categories"] = categories?.toList();
    // "categories": categories ==null?null:List<dynamic>.from(categories.map((e) => e));
    data['averageRating'] = averageRating;
    data['ratingsCount'] = ratingsCount;
    data['allowAnonLogging'] = allowAnonLogging;
    if (imageLinks != null) {
      data['imageLinks'] = imageLinks!.toJson();
    }
    data['language'] = language;
    data['previewLink'] = previewLink;
    data['infoLink'] = infoLink;
    data['canonicalVolumeLink'] = canonicalVolumeLink;
    return data;
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['smallThumbnail'] = smallThumbnail;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class SaleInfo {
  String? country;
  String? saleability;
  bool? isEbook;

  SaleInfo({this.country, this.saleability, this.isEbook});

  SaleInfo.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    saleability = json['saleability'];
    isEbook = json['isEbook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['saleability'] = saleability;
    data['isEbook'] = isEbook;
    return data;
  }
}

class AccessInfo {
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

  AccessInfo.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    viewability = json['viewability'];
    textToSpeechPermission = json['textToSpeechPermission'];
    pdf = json['pdf'] != null ? Pdf.fromJson(json['pdf']) : null;
    webReaderLink = json['webReaderLink'];
    accessViewStatus = json['accessViewStatus'];
    quoteSharingAllowed = json['quoteSharingAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['viewability'] = viewability;
    data['textToSpeechPermission'] = textToSpeechPermission;
    if (pdf != null) {
      data['pdf'] = pdf!.toJson();
    }
    data['webReaderLink'] = webReaderLink;
    data['accessViewStatus'] = accessViewStatus;
    data['quoteSharingAllowed'] = quoteSharingAllowed;
    return data;
  }
}

class Pdf {
  bool? isAvailable;

  Pdf({this.isAvailable});

  Pdf.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAvailable'] = isAvailable;
    return data;
  }
}
