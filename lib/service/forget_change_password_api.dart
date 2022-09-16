import 'dart:convert';

import 'package:bigbaang/Models/change_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ForgetPasswordAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ForgetPasswordResponseModel? _forgetPasswordResponseModel;

  Future<void> forgetPasswordRequest(String phoneNumber) async {
    Uri forgetPasswordUrl =
        Uri.parse('${baseURL}index.php/Api_customer/forgotPassword');
    final response =
        await post(forgetPasswordUrl, body: {'mobile_no': phoneNumber});
    if (response.statusCode == 200) {
      try {
        print("Json response for forget password initialized   json response " +
            response.body);
        final jsonResponse = jsonDecode(response.body);
        print("THe json response " + jsonResponse.toString());
        _forgetPasswordResponseModel =
            ForgetPasswordResponseModel.fromJson(jsonResponse);
        // print("-------------------OTP" +
        //     _forgetPasswordResponseModel!.otp.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _forgetPasswordResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Oops! Something is not right : ${response.statusCode.toString()}";
      _forgetPasswordResponseModel = null;
    }
    notifyListeners();
  }

  bool get ifLoading => _error == false && _forgetPasswordResponseModel == null;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ForgetPasswordResponseModel? get forgetPasswordResponse =>
      _forgetPasswordResponseModel;
}

class ChangePasswordAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  ChangePasswordResponseModel? _changePasswordResponseModel;

  Future<void> changePasswordRequest(String userId, String newPassword) async {
    Uri forgetPasswordUrl = Uri.parse(
        'https://bigbaang.in/big_bank/index.php/Api_customer/changepassword');
    final response = await post(forgetPasswordUrl,
        body: {'user_id': userId, 'new_password': newPassword});
    if (response.statusCode == 200) {
      try {
        print("Json response for forget password initialized");
        final jsonResponse = jsonDecode(response.body);

        _changePasswordResponseModel =
            ChangePasswordResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _changePasswordResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Oops! Something is not right : ${response.statusCode.toString()}";
      _changePasswordResponseModel = null;
    }
    notifyListeners();
  }

  bool get ifLoading => _error == false && _changePasswordResponseModel == null;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ChangePasswordResponseModel? get changePasswordResponse =>
      _changePasswordResponseModel;
}
