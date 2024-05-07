enum MessageType {
  NEW_PRODUCT_ADDED,
  REQUEST_SEND,
  VENDOR_RECEIVED,
  VENDOR_SEND_NOTIFICATION_DRIVER,
  DRIVER_RECEIVED_NOTIFICATION,
}

class NotificationModel {
  String? to;
  late Notification notification;
  late Data data;
  Map<String, dynamic> toJson(){
    return {
      "to" : this.to ,
      "notification" : notification.toJson() ,
      "data": data.toJson() ,
    };
  }
  NotificationModel.fromJson(json){
    this.to = json["to"] ;
    this.data = Data.fromJson(json["data"]) ;
    this.notification = Notification.fromJson(json["notification"]) ;
  }

}

class Notification {
  String? title;
  String? body;


  Notification({this.body , this.title}) ;

  Notification.fromJson(dynamic) {
    this.title = dynamic["title"];
    this.body = dynamic["body"];
  }
  Map<String , dynamic> toJson(){
    return {
      "title" : this.title , 
      "body" : this.body
    };
  }
  
}

class Data {
  MessageType? type;
  String? title;
  String? body;

  Data.fromJson(dynamic) {
    this.title = dynamic["title"];
    this.body = dynamic["body"];
    this.type = _checkType(dynamic["type"]) ;
  }

  Map<String , dynamic> toJson(){
    return {
      "title" : this.title ,
      "body" : this.body ,
      "type" : _sendMessageType(type)
    };
  }
  _checkType(type) {
    if (type == MessageType.DRIVER_RECEIVED_NOTIFICATION.toString()){
      return MessageType.DRIVER_RECEIVED_NOTIFICATION ;
    }else if(type == MessageType.NEW_PRODUCT_ADDED.toString()){
      return  MessageType.NEW_PRODUCT_ADDED ;
    }else if(type == MessageType.REQUEST_SEND.toString()){
      return MessageType.REQUEST_SEND ;
    }else if(type == MessageType.VENDOR_RECEIVED.toString()){
      return MessageType.VENDOR_RECEIVED  ;
    }else if(type == MessageType.VENDOR_SEND_NOTIFICATION_DRIVER.toString()){
      return MessageType.VENDOR_SEND_NOTIFICATION_DRIVER ;
    }
  }

  _sendMessageType(MessageType? type) {
    if (type == MessageType.DRIVER_RECEIVED_NOTIFICATION){
      return MessageType.DRIVER_RECEIVED_NOTIFICATION.toString() ;
    }else if(type == MessageType.NEW_PRODUCT_ADDED){
      return  MessageType.NEW_PRODUCT_ADDED.toString() ;
    }else if(type == MessageType.REQUEST_SEND){
      return MessageType.REQUEST_SEND.toString() ;
    }else if(type == MessageType.VENDOR_RECEIVED){
      return MessageType.VENDOR_RECEIVED.toString()  ;
    }else if(type == MessageType.VENDOR_SEND_NOTIFICATION_DRIVER){
      return MessageType.VENDOR_SEND_NOTIFICATION_DRIVER.toString() ;
    }
  }
}
