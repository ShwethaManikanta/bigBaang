import 'dart:convert';

import 'package:bigbaang/Models/notifications_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NotificationCountAPIProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  NotificationCountModel? _notificationCountModel;

  Future<void> get notificationCount async {
    Uri notificationCountUrl =
        Uri.parse("${baseURL}index.php/Api_customer/notificationCount");
    final response =
        await post(notificationCountUrl, body: {'user_id': ApiService.userID});
    print("Notification Count Sattus code  --" +
        response.statusCode.toString() +
        "Notification count body  --" +
        response.body);
    if (response.statusCode == 200) {
      try {
        print("Json Response ----");

        final jsonResponse = jsonDecode(response.body);
        print("Json Response ----" + jsonResponse.toString());
        _notificationCountModel = NotificationCountModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _notificationCountModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _notificationCountModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  NotificationCountModel? get notificationCountModel => _notificationCountModel;

  bool get isLoading => _notificationCountModel == null && _error == false;
}

class NotificationListAPIProvider extends ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  NotificationListModel? _notificationListModel;

  Future<void> get notificationList async {
    Uri notificationCountUrl = Uri.parse(
        "https://bigbaang.in/big_bank/index.php/Api_customer/notificationList");
    final response =
        await post(notificationCountUrl, body: {'user_id': ApiService.userID});
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _notificationListModel = NotificationListModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _notificationListModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _notificationListModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  NotificationListModel? get notificationLists => _notificationListModel;

  bool get isLoading => _notificationListModel == null && _error == false;
}

class NotificationUpdateAPIProvider extends ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  Map<String, dynamic>? _notificationUpdateResponse;

  Future<void> get notificationUpdate async {
    Uri notificationCountUrl = Uri.parse(
        "https://bigbaang.in/big_bank/index.php/Api_customer/notificationUpdate");
    final response =
        await post(notificationCountUrl, body: {'user_id': ApiService.userID});
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _notificationUpdateResponse = {
          "status": jsonResponse['status'],
          "message": jsonResponse['message']
        };
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _notificationUpdateResponse = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _notificationUpdateResponse = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  Map<String, dynamic>? get notificationUpdateResponse =>
      _notificationUpdateResponse;

  bool get loading => _notificationUpdateResponse == null && _error == false;
}
