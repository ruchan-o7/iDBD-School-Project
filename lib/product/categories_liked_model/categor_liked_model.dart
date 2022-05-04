class CategoriesLikedModel {
  String? bookId;
  String? likedBy;
  LikedTime? likedTime;

  CategoriesLikedModel({this.bookId, this.likedBy, this.likedTime});

  CategoriesLikedModel.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    likedBy = json['likedBy'];
    likedTime = json['likedTime'] != null ? LikedTime.fromJson(json['likedTime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookId'] = bookId;
    data['likedBy'] = likedBy;
    if (likedTime != null) {
      data['likedTime'] = likedTime!.toJson();
    }
    return data;
  }
}

class LikedTime {
  int? year;
  int? month;

  LikedTime({this.year, this.month});

  LikedTime.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}
