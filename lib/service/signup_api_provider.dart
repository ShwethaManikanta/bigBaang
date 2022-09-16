import 'dart:convert';
import 'package:bigbaang/Models/signup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class SignupAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  SignUpResponseModel? _signUpResponseModel;

  Future<void> fetchSignUp(SignUpRequestModel signUpRequestModel) async {
    Uri signUpApiUrl = Uri.parse("${baseURL}index.php/Api_customer/signup");
    final response =
        await post(signUpApiUrl, body: signUpRequestModel.toJson());
    if (response.statusCode == 200) {
      try {
        print("Response from the signup api call " + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response from the signup api call " +
            jsonResponse.toString());
        _signUpResponseModel = SignUpResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = "${e.toString()}";
        _signUpResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error while getting the data from internet ${response.statusCode}";
      _signUpResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  SignUpResponseModel? get signUpResponseModel => _signUpResponseModel;
}
