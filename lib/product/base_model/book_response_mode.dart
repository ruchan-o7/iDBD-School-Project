//25,03,2022 - 19:16     UPTODATE MODEL --> https://www.googleapis.com/books/v1/volumes?q=intibah
class BookResponseModel {
  String? kind;
  List<Items>? items;

  BookResponseModel({this.kind, this.items});

  BookResponseModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
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

  Items(
      {this.id,
      this.etag,
      this.selfLink,
      this.volumeInfo,
      this.saleInfo,
      this.accessInfo});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    etag = json['etag'];
    selfLink = json['selfLink'];
    volumeInfo = json['volumeInfo'] != null
        ? new VolumeInfo.fromJson(json['volumeInfo'])
        : null;
    saleInfo = json['saleInfo'] != null
        ? new SaleInfo.fromJson(json['saleInfo'])
        : null;
    accessInfo = json['accessInfo'] != null
        ? new AccessInfo.fromJson(json['accessInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['etag'] = this.etag;
    data['selfLink'] = this.selfLink;
    if (this.volumeInfo != null) {
      data['volumeInfo'] = this.volumeInfo!.toJson();
    }
    if (this.saleInfo != null) {
      data['saleInfo'] = this.saleInfo!.toJson();
    }
    if (this.accessInfo != null) {
      data['accessInfo'] = this.accessInfo!.toJson();
    }
    return data;
  }
}

class VolumeInfo {
  String? title;
  List<String>? authors;
  String? publishedDate;
  int? pageCount;
  int? averageRating;
  int? ratingsCount;
  bool? allowAnonLogging;
  ImageLinks? imageLinks;
  String? language;
  String? previewLink;
  String? infoLink;
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
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink});

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authors = json['authors'].cast<String>();
    publishedDate = json['publishedDate'];
    pageCount = json['pageCount'];
    averageRating = json['averageRating'];
    ratingsCount = json['ratingsCount'];
    allowAnonLogging = json['allowAnonLogging'];
    imageLinks = json['imageLinks'] != null
        ? new ImageLinks.fromJson(json['imageLinks'])
        : null;
    language = json['language'];
    previewLink = json['previewLink'];
    infoLink = json['infoLink'];
    canonicalVolumeLink = json['canonicalVolumeLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['publishedDate'] = this.publishedDate;
    data['pageCount'] = this.pageCount;
    data['averageRating'] = this.averageRating;
    data['ratingsCount'] = this.ratingsCount;
    data['allowAnonLogging'] = this.allowAnonLogging;
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks!.toJson();
    }
    data['language'] = this.language;
    data['previewLink'] = this.previewLink;
    data['infoLink'] = this.infoLink;
    data['canonicalVolumeLink'] = this.canonicalVolumeLink;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smallThumbnail'] = this.smallThumbnail;
    data['thumbnail'] = this.thumbnail;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['saleability'] = this.saleability;
    data['isEbook'] = this.isEbook;
    return data;
  }
}

class AccessInfo {
  String? country;
  String? viewability;
  String? textToSpeechPermission;
  Pdf? pdf;
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
    pdf = json['pdf'] != null ? new Pdf.fromJson(json['pdf']) : null;
    webReaderLink = json['webReaderLink'];
    accessViewStatus = json['accessViewStatus'];
    quoteSharingAllowed = json['quoteSharingAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['viewability'] = this.viewability;
    data['textToSpeechPermission'] = this.textToSpeechPermission;
    if (this.pdf != null) {
      data['pdf'] = this.pdf!.toJson();
    }
    data['webReaderLink'] = this.webReaderLink;
    data['accessViewStatus'] = this.accessViewStatus;
    data['quoteSharingAllowed'] = this.quoteSharingAllowed;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
