// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBookModel _$SearchBookModelFromJson(Map<String, dynamic> json) =>
    SearchBookModel(
      kind: json['kind'] as String?,
      totalItems: json['totalItems'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchBookModelToJson(SearchBookModel instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      kind: json['kind'] as String?,
      id: json['id'] as String?,
      etag: json['etag'] as String?,
      selfLink: json['selfLink'] as String?,
      volumeInfo: json['volumeInfo'] == null
          ? null
          : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      saleInfo: json['saleInfo'] == null
          ? null
          : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
      accessInfo: json['accessInfo'] == null
          ? null
          : AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
      searchInfo: json['searchInfo'] == null
          ? null
          : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'saleInfo': instance.saleInfo,
      'accessInfo': instance.accessInfo,
      'searchInfo': instance.searchInfo,
    };

VolumeInfo _$VolumeInfoFromJson(Map<String, dynamic> json) => VolumeInfo(
      title: json['title'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      publishedDate: json['publishedDate'] as String?,
      industryIdentifiers: (json['industryIdentifiers'] as List<dynamic>?)
          ?.map((e) => IndustryIdentifiers.fromJson(e as Map<String, dynamic>))
          .toList(),
      readingModes: json['readingModes'] == null
          ? null
          : ReadingModes.fromJson(json['readingModes'] as Map<String, dynamic>),
      pageCount: json['pageCount'] as int?,
      printType: json['printType'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      maturityRating: json['maturityRating'] as String?,
      allowAnonLogging: json['allowAnonLogging'] as bool?,
      contentVersion: json['contentVersion'] as String?,
      language: json['language'] as String?,
      previewLink: json['previewLink'] as String?,
      infoLink: json['infoLink'] as String?,
      canonicalVolumeLink: json['canonicalVolumeLink'] as String?,
      imageLinks: json['imageLinks'] == null
          ? null
          : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
      panelizationSummary: json['panelizationSummary'] == null
          ? null
          : PanelizationSummary.fromJson(
              json['panelizationSummary'] as Map<String, dynamic>),
      publisher: json['publisher'] as String?,
      description: json['description'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$VolumeInfoToJson(VolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publishedDate': instance.publishedDate,
      'industryIdentifiers': instance.industryIdentifiers,
      'readingModes': instance.readingModes,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'categories': instance.categories,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink,
      'imageLinks': instance.imageLinks,
      'panelizationSummary': instance.panelizationSummary,
      'publisher': instance.publisher,
      'description': instance.description,
      'subtitle': instance.subtitle,
    };

IndustryIdentifiers _$IndustryIdentifiersFromJson(Map<String, dynamic> json) =>
    IndustryIdentifiers(
      type: json['type'] as String?,
      identifier: json['identifier'] as String?,
    );

Map<String, dynamic> _$IndustryIdentifiersToJson(
        IndustryIdentifiers instance) =>
    <String, dynamic>{
      'type': instance.type,
      'identifier': instance.identifier,
    };

ReadingModes _$ReadingModesFromJson(Map<String, dynamic> json) => ReadingModes(
      text: json['text'] as bool?,
      image: json['image'] as bool?,
    );

Map<String, dynamic> _$ReadingModesToJson(ReadingModes instance) =>
    <String, dynamic>{
      'text': instance.text,
      'image': instance.image,
    };

ImageLinks _$ImageLinksFromJson(Map<String, dynamic> json) => ImageLinks(
      smallThumbnail: json['smallThumbnail'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$ImageLinksToJson(ImageLinks instance) =>
    <String, dynamic>{
      'smallThumbnail': instance.smallThumbnail,
      'thumbnail': instance.thumbnail,
    };

PanelizationSummary _$PanelizationSummaryFromJson(Map<String, dynamic> json) =>
    PanelizationSummary(
      containsEpubBubbles: json['containsEpubBubbles'] as bool?,
      containsImageBubbles: json['containsImageBubbles'] as bool?,
    );

Map<String, dynamic> _$PanelizationSummaryToJson(
        PanelizationSummary instance) =>
    <String, dynamic>{
      'containsEpubBubbles': instance.containsEpubBubbles,
      'containsImageBubbles': instance.containsImageBubbles,
    };

SaleInfo _$SaleInfoFromJson(Map<String, dynamic> json) => SaleInfo(
      country: json['country'] as String?,
      saleability: json['saleability'] as String?,
      isEbook: json['isEbook'] as bool?,
      listPrice: json['listPrice'] == null
          ? null
          : ListPrice.fromJson(json['listPrice'] as Map<String, dynamic>),
      retailPrice: json['retailPrice'] == null
          ? null
          : ListPrice.fromJson(json['retailPrice'] as Map<String, dynamic>),
      buyLink: json['buyLink'] as String?,
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => Offers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaleInfoToJson(SaleInfo instance) => <String, dynamic>{
      'country': instance.country,
      'saleability': instance.saleability,
      'isEbook': instance.isEbook,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
      'buyLink': instance.buyLink,
      'offers': instance.offers,
    };

ListPrice _$ListPriceFromJson(Map<String, dynamic> json) => ListPrice(
      amount: (json['amount'] as num?)?.toDouble(),
      currencyCode: json['currencyCode'] as String?,
    );

Map<String, dynamic> _$ListPriceToJson(ListPrice instance) => <String, dynamic>{
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
    };

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
      finskyOfferType: json['finskyOfferType'] as int?,
      listPrice: json['listPrice'] == null
          ? null
          : ListPrice2.fromJson(json['listPrice'] as Map<String, dynamic>),
      retailPrice: json['retailPrice'] == null
          ? null
          : ListPrice2.fromJson(json['retailPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'finskyOfferType': instance.finskyOfferType,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
    };

ListPrice2 _$ListPrice2FromJson(Map<String, dynamic> json) => ListPrice2(
      amountInMicros: json['amountInMicros'] as int?,
      currencyCode: json['currencyCode'] as String?,
    );

Map<String, dynamic> _$ListPrice2ToJson(ListPrice2 instance) =>
    <String, dynamic>{
      'amountInMicros': instance.amountInMicros,
      'currencyCode': instance.currencyCode,
    };

AccessInfo _$AccessInfoFromJson(Map<String, dynamic> json) => AccessInfo(
      country: json['country'] as String?,
      viewability: json['viewability'] as String?,
      embeddable: json['embeddable'] as bool?,
      publicDomain: json['publicDomain'] as bool?,
      textToSpeechPermission: json['textToSpeechPermission'] as String?,
      epub: json['epub'] == null
          ? null
          : Epub.fromJson(json['epub'] as Map<String, dynamic>),
      pdf: json['pdf'] == null
          ? null
          : Pdf.fromJson(json['pdf'] as Map<String, dynamic>),
      webReaderLink: json['webReaderLink'] as String?,
      accessViewStatus: json['accessViewStatus'] as String?,
      quoteSharingAllowed: json['quoteSharingAllowed'] as bool?,
    );

Map<String, dynamic> _$AccessInfoToJson(AccessInfo instance) =>
    <String, dynamic>{
      'country': instance.country,
      'viewability': instance.viewability,
      'embeddable': instance.embeddable,
      'publicDomain': instance.publicDomain,
      'textToSpeechPermission': instance.textToSpeechPermission,
      'epub': instance.epub,
      'pdf': instance.pdf,
      'webReaderLink': instance.webReaderLink,
      'accessViewStatus': instance.accessViewStatus,
      'quoteSharingAllowed': instance.quoteSharingAllowed,
    };

Epub _$EpubFromJson(Map<String, dynamic> json) => Epub(
      isAvailable: json['isAvailable'] as bool?,
    );

Map<String, dynamic> _$EpubToJson(Epub instance) => <String, dynamic>{
      'isAvailable': instance.isAvailable,
    };

Pdf _$PdfFromJson(Map<String, dynamic> json) => Pdf(
      isAvailable: json['isAvailable'] as bool?,
      acsTokenLink: json['acsTokenLink'] as String?,
    );

Map<String, dynamic> _$PdfToJson(Pdf instance) => <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'acsTokenLink': instance.acsTokenLink,
    };

SearchInfo _$SearchInfoFromJson(Map<String, dynamic> json) => SearchInfo(
      textSnippet: json['textSnippet'] as String?,
    );

Map<String, dynamic> _$SearchInfoToJson(SearchInfo instance) =>
    <String, dynamic>{
      'textSnippet': instance.textSnippet,
    };
