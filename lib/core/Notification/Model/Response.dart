class NotificationResponse{

  var  success ;

  NotificationResponse.fromJson(json){

    this.success = json["success"] ;

  }

}