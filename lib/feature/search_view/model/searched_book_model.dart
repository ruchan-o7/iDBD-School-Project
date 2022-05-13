import 'package:json_annotation/json_annotation.dart';

import '../../../product/base_model/book_response_mode.dart';

part 'searched_book_model.g.dart';

@JsonSerializable()
class SearchBookModel {
  String? kind;
  int? totalItems;
  List<Items>? items;

  SearchBookModel({this.kind, this.totalItems, this.items});

  factory SearchBookModel.fromJson(Map<String, dynamic> json) {
    return _$SearchBookModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchBookModelToJson(this);
  }
}

@JsonSerializable()
class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers({this.type, this.identifier});

  factory IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    return _$IndustryIdentifiersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IndustryIdentifiersToJson(this);
  }
}

@JsonSerializable()
class ReadingModes {
  bool? text;
  bool? image;

  ReadingModes({this.text, this.image});

  factory ReadingModes.fromJson(Map<String, dynamic> json) {
    return _$ReadingModesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReadingModesToJson(this);
  }
}

@JsonSerializable()
class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return _$ImageLinksFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ImageLinksToJson(this);
  }
}

@JsonSerializable()
class PanelizationSummary {
  bool? containsEpubBubbles;
  bool? containsImageBubbles;

  PanelizationSummary({this.containsEpubBubbles, this.containsImageBubbles});

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) {
    return _$PanelizationSummaryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PanelizationSummaryToJson(this);
  }
}

@JsonSerializable()
class SaleInfo {
  String? country;
  String? saleability;
  bool? isEbook;
  ListPrice? listPrice;
  ListPrice? retailPrice;
  String? buyLink;
  List<Offers>? offers;

  SaleInfo(
      {this.country,
      this.saleability,
      this.isEbook,
      this.listPrice,
      this.retailPrice,
      this.buyLink,
      this.offers});

  factory SaleInfo.fromJson(Map<String, dynamic> json) {
    return _$SaleInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SaleInfoToJson(this);
  }
}

@JsonSerializable()
class ListPrice {
  double? amount;
  String? currencyCode;

  ListPrice({this.amount, this.currencyCode});

  factory ListPrice.fromJson(Map<String, dynamic> json) {
    return _$ListPriceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ListPriceToJson(this);
  }
}

@JsonSerializable()
class Offers {
  int? finskyOfferType;
  ListPrice2? listPrice;
  ListPrice2? retailPrice;

  Offers({this.finskyOfferType, this.listPrice, this.retailPrice});

  factory Offers.fromJson(Map<String, dynamic> json) {
    return _$OffersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OffersToJson(this);
  }
}

@JsonSerializable()
class ListPrice2 {
  int? amountInMicros;
  String? currencyCode;

  ListPrice2({this.amountInMicros, this.currencyCode});

  factory ListPrice2.fromJson(Map<String, dynamic> json) {
    return _$ListPrice2FromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ListPrice2ToJson(this);
  }
}

@JsonSerializable()
class AccessInfo {
  String? country;
  String? viewability;
  bool? embeddable;
  bool? publicDomain;
  String? textToSpeechPermission;
  Epub? epub;
  Pdf? pdf;
  String? webReaderLink;
  String? accessViewStatus;
  bool? quoteSharingAllowed;

  AccessInfo(
      {this.country,
      this.viewability,
      this.embeddable,
      this.publicDomain,
      this.textToSpeechPermission,
      this.epub,
      this.pdf,
      this.webReaderLink,
      this.accessViewStatus,
      this.quoteSharingAllowed});

  factory AccessInfo.fromJson(Map<String, dynamic> json) {
    return _$AccessInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AccessInfoToJson(this);
  }
}

@JsonSerializable()
class Epub {
  bool? isAvailable;

  Epub({this.isAvailable});

  factory Epub.fromJson(Map<String, dynamic> json) {
    return _$EpubFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EpubToJson(this);
  }
}

@JsonSerializable()
class Pdf {
  bool? isAvailable;
  String? acsTokenLink;

  Pdf({this.isAvailable, this.acsTokenLink});

  factory Pdf.fromJson(Map<String, dynamic> json) {
    return _$PdfFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PdfToJson(this);
  }
}

@JsonSerializable()
class SearchInfo {
  String? textSnippet;

  SearchInfo({this.textSnippet});

  factory SearchInfo.fromJson(Map<String, dynamic> json) {
    return _$SearchInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchInfoToJson(this);
  }
}
