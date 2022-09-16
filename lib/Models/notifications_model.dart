class NotificationCountModel {
  late String status;
  late String message;
  late String userId;
  late String unreadNotificationCount;

  NotificationCountModel(
      {required this.status,
      required this.message,
      required this.userId,
      required this.unreadNotificationCount});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    unreadNotificationCount = json['unread_notification_count'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['user_id'] = userId;
    data['unread_notification_count'] = unreadNotificationCount;
    return data;
  }
}

class NotificationListModel {
  late String status;
  late String message;
  late String notificationListUrl;
  late List<NotificationList>? notificationList;

  NotificationListModel(
      {required this.status,
      required this.message,
      required this.notificationListUrl,
      required this.notificationList});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    notificationListUrl = json['notification_list_url'];
    if (json['notification_list'] != null) {
      notificationList = [];
      json['notification_list'].forEach((v) {
        notificationList!.add(NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['notification_list_url'] = notificationListUrl;
    if (notificationList != null) {
      data['notification_list'] =
          notificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  late String id;
  late String userId;
  late String driverId;
  late String retailerId;
  late String title;
  late String body;
  late String notifImage;
  late String audioFilename;
  late String status;
  late String orderId;
  late String readStatus;
  late String createdAt;

  NotificationList(
      {required this.id,
      required this.userId,
      required this.driverId,
      required this.retailerId,
      required this.title,
      required this.body,
      required this.notifImage,
      required this.audioFilename,
      required this.status,
      required this.orderId,
      required this.readStatus,
      required this.createdAt});

  NotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    retailerId = json['retailer_id'];
    title = json['title'];
    body = json['body'];
    notifImage = json['notif_image'];
    audioFilename = json['audio_filename'];
    status = json['status'];
    orderId = json['order_id'];
    readStatus = json['read_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['retailer_id'] = retailerId;
    data['title'] = title;
    data['body'] = body;
    data['notif_image'] = notifImage;
    data['audio_filename'] = audioFilename;
    data['status'] = status;
    data['order_id'] = orderId;
    data['read_status'] = readStatus;
    data['created_at'] = createdAt;
    return data;
  }
}
