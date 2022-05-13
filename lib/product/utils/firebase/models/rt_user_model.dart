class RTUserModel {
  List<String>? likedBooks;
  String? userUID;
  List<String>? markedBook;
  List<String>? ownedBooks;

  RTUserModel({this.likedBooks, this.userUID, this.markedBook, this.ownedBooks});

  factory RTUserModel.fromJson(Map<String, dynamic> json) {
    return RTUserModel(
        likedBooks: json['likedBooks'].cast<String>(),
        userUID: json['userUID'],
        markedBook: json['markedBook'].cast<String>(),
        ownedBooks: json['ownedBooks'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likedBooks'] = likedBooks;
    data['userUID'] = userUID;
    data['markedBook'] = markedBook;
    data['ownedBooks'] = ownedBooks;
    return data;
  }
}
