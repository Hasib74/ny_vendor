/// success : "true"
/// status_code : "200"
/// response : [{"id":2,"name":"banner 1","image":"uploads/banner//1686594582.png","created_at":"2023-06-12T18:29:43.000000Z","updated_at":"2023-06-12T18:29:43.000000Z"},{"id":3,"name":"banner 2","image":"uploads/banner//1686594699.png","created_at":"2023-06-12T18:31:39.000000Z","updated_at":"2023-06-12T18:31:39.000000Z"}]

class BannerModel {
  BannerModel({
      String? success, 
      String? statusCode, 
      List<Response>? response,}){
    _success = success;
    _statusCode = statusCode;
    _response = response;
}

  BannerModel.fromJson(dynamic json) {
    _success = json['success'];
    _statusCode = json['status_code'];
    if (json['response'] != null) {
      _response = [];
      json['response'].forEach((v) {
        _response?.add(Response.fromJson(v));
      });
    }
  }
  String? _success;
  String? _statusCode;
  List<Response>? _response;
BannerModel copyWith({  String? success,
  String? statusCode,
  List<Response>? response,
}) => BannerModel(  success: success ?? _success,
  statusCode: statusCode ?? _statusCode,
  response: response ?? _response,
);
  String? get success => _success;
  String? get statusCode => _statusCode;
  List<Response>? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['status_code'] = _statusCode;
    if (_response != null) {
      map['response'] = _response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// name : "banner 1"
/// image : "uploads/banner//1686594582.png"
/// created_at : "2023-06-12T18:29:43.000000Z"
/// updated_at : "2023-06-12T18:29:43.000000Z"

class Response {
  Response({
      num? id, 
      String? name, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
Response copyWith({  num? id,
  String? name,
  String? image,
  String? createdAt,
  String? updatedAt,
}) => Response(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}