class UserResponseModel {
  int? id;
  String? token;

  UserResponseModel({this.id, this.token});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
