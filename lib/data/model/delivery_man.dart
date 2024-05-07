/// success : "true"
/// message : [{"delivery_men_id":1,"full_name":"Iftakher Uddin2222","email":"iu.rishad502@gmail.com","phone":"01843080023","is_active":1,"created_at":"2022-07-31T17:22:49.000000Z","updated_at":"2022-07-31T17:22:49.000000Z"},{"delivery_men_id":2,"full_name":"kawcher habib","email":"kawcher578@gmail.com","phone":"01798652432","is_active":1,"created_at":"2022-07-31T17:28:20.000000Z","updated_at":"2022-07-31T17:28:20.000000Z"},{"delivery_men_id":3,"full_name":"sumaiya","email":"ni@gmail.com","phone":"01632193890","is_active":1,"created_at":"2022-08-01T15:12:07.000000Z","updated_at":"2022-08-01T15:12:07.000000Z"},{"delivery_men_id":4,"full_name":"ri","email":"si@gmail.com","phone":"01632193891","is_active":1,"created_at":"2022-08-04T06:03:15.000000Z","updated_at":"2022-08-04T06:03:15.000000Z"},{"delivery_men_id":5,"full_name":"Driver","email":"driver@gmail.com","phone":"01838856775","is_active":1,"created_at":"2022-08-04T18:39:40.000000Z","updated_at":"2022-08-04T18:39:40.000000Z"},{"delivery_men_id":6,"full_name":"Iftakher Uddin","email":"iu.rishad2@gmail.com","phone":"01843080023","is_active":1,"created_at":"2022-08-10T16:41:03.000000Z","updated_at":"2022-08-10T16:41:03.000000Z"}]
/// status_code : 200

class DeliveryMan {
  DeliveryMan({
    String? success,
    List<Message>? message,
    int? statusCode,
  }) {
    _success = success;
    _message = message;
    _statusCode = statusCode;
  }

  DeliveryMan.fromJson(dynamic json) {
    _success = json['success'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message!.add(Message.fromJson(v));
      });
    }
    _statusCode = json['status_code'];
  }

  String? _success;
  List<Message>? _message;
  int? _statusCode;

  DeliveryMan copyWith({
    String? success,
    List<Message>? message,
    int? statusCode,
  }) =>
      DeliveryMan(
        success: success ?? _success,
        message: message ?? _message,
        statusCode: statusCode ?? _statusCode,
      );

  String? get success => _success;

  List<Message>? get message => _message;

  int? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_message != null) {
      map['message'] = _message!.map((v) => v.toJson()).toList();
    }
    map['status_code'] = _statusCode;
    return map;
  }
}

/// delivery_men_id : 1
/// full_name : "Iftakher Uddin2222"
/// email : "iu.rishad502@gmail.com"
/// phone : "01843080023"
/// is_active : 1
/// created_at : "2022-07-31T17:22:49.000000Z"
/// updated_at : "2022-07-31T17:22:49.000000Z"

class Message {
  Message({
    int? deliveryMenId,
    String? fullName,
    String? email,
    String? phone,
    String? image,
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _deliveryMenId = deliveryMenId;
    _fullName = fullName;
    _email = email;
    _phone = phone;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
  }

  Message.fromJson(dynamic json) {
    _deliveryMenId = json['delivery_men_id'];
    _fullName = json['full_name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['delivery_men_image'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _deliveryMenId;
  String? _fullName;
  String? _email;
  String? _phone;
  int? _isActive;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Message copyWith({
    int? deliveryMenId,
    String? fullName,
    String? email,
    String? phone,
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      Message(
        deliveryMenId: deliveryMenId ?? _deliveryMenId,
        fullName: fullName ?? _fullName,
        email: email ?? _email,
        phone: phone ?? _phone,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get deliveryMenId => _deliveryMenId;

  String? get fullName => _fullName;

  String? get email => _email;

  String? get phone => _phone;

  int? get isActive => _isActive;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['delivery_men_id'] = _deliveryMenId;
    map['full_name'] = _fullName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
