import 'dart:convert';
import 'package:bigbaang/Models/profile_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class ProfileApiProvder with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ProfileModel? _profileModel;

  Future<void> fetchProfileDetails() async {
    Uri profileApiUrl = Uri.parse("${baseURL}index.php/Api_customer/profile");

    final response =
        await post(profileApiUrl, body: {"user_id": ApiService.userID});
    print(ApiService.userID);

    if (response.statusCode == 200) {
      try {
        print("Response @ ProfileApi " + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response @ Profile" + jsonResponse.toString());
        _profileModel = ProfileModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _profileModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error while getting the data from internet ${response.statusCode}";
      _profileModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;
  String get errorMessage => _errorMessage;
  ProfileModel? get profileModel => _profileModel;

  bool get ifLoading => _error == false && profileModel == null;
}

class ProfileUpdateApiProvder with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ProfileUpdateResponseModel? _profileUpdateResponseModel;

  Future<void> updateProfileDetails(
      ProfileUpdateRequestModel profileUpdateRequestModel) async {
    print("-------------------------------  >>>>>>>>>> Profile Api Provider");
    Uri profileApiUrl =
        Uri.parse("${baseURL}index.php/Api_customer/profile_update");

    final response =
        await post(profileApiUrl, body: profileUpdateRequestModel.toMap());
    print(ApiService.userID);

    if (response.statusCode == 200) {
      try {
        print("Response @ ProfileApi " + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response @ Profile" + jsonResponse.toString());
        _profileUpdateResponseModel =
            ProfileUpdateResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _profileUpdateResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error while getting the data from internet ${response.statusCode}";
      _profileUpdateResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;
  String get errorMessage => _errorMessage;
  ProfileUpdateResponseModel? get profileUpdateResponse =>
      _profileUpdateResponseModel;

  bool get ifLoading => _error == false && _profileUpdateResponseModel == null;
}
