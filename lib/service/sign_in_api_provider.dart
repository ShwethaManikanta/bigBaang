import 'dart:convert';
import 'package:bigbaang/Models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignInAPIProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  SignInResponse? _signInResponse;

  Future<void> sendSignInRequest(SignInRequest signInRequest) async {
    Uri signUpApiUrl = Uri.parse("${baseURL}index.php/Api_customer/signin");

    print("SignUpAPI uri parsed");

    final response = await post(signUpApiUrl, body: signInRequest.toMap());

    print("Sign in request sent post method");
    if (response.statusCode == 200) {
      print("Sign in response code " + response.statusCode.toString());
      try {
        print("Response from the SignIn api call " + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response from the SignIn api call " +
            jsonResponse.toString());
        _signInResponse = SignInResponse.fromJson(jsonResponse);
      } catch (e) {
        print("error caught while parsing data!!!-------------------");
        _error = true;
        _errorMessage = "${e.toString()}";
        _signInResponse = null;
      }
    } else {
      print("error caught from post response!!!-------------------");
      _error = true;
      _errorMessage =
          "Error while getting the data from internet ${response.statusCode}";
      _signInResponse = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  SignInResponse? get signInResponse => _signInResponse;

  bool get isLoading => _error == false && _signInResponse == null;
}
