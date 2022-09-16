import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesInitializationStatus { initialized, uninitialized }

class SharedPreferencesProvider with ChangeNotifier {
  late SharedPreferences sharedPreferences;

  SharedPreferencesInitializationStatus _status =
      SharedPreferencesInitializationStatus.uninitialized;

  late String _userId;
  late bool _isUserLoggedIn;
  late bool _viewedSplashPage;

  SharedPreferencesProvider() {
    initialize();
  }

  initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _status = SharedPreferencesInitializationStatus.initialized;
    _userId = sharedPreferences.getString("id") ?? "NA";
    _isUserLoggedIn = sharedPreferences.getBool("isUserLoggedIn") ?? false;
    _viewedSplashPage = sharedPreferences.getBool("viewedSplashPage") ?? false;
    notifyListeners();
  }

  String get userId => _userId;

  bool get isUserLoggedIn => _isUserLoggedIn;

  bool get viewedSplashPage => _viewedSplashPage;

  set isUserLoggedIn(bool value) {
    sharedPreferences.setBool("isUserLoggedIn", value);
    notifyListeners();
  }

  set userId(String value) {
    sharedPreferences.setString("id", value);
    notifyListeners();
  }

  SharedPreferencesInitializationStatus get status => _status;
}
