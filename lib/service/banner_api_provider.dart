import 'dart:convert';

import 'package:bigbaang/Models/banner_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BannerApiProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  BannerModel? _bannerModel;

  Future<void> get getBanners async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/bannerList");
    final response = await get(url);
    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _bannerModel = BannerModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _bannerModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _bannerModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  BannerModel? get bannerModel => _bannerModel;

  bool get isLoading => _error == false && _bannerModel == null;
}

class OfferBannerApiProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  OfferBannerModel? _bannerModel;

  Future<void> get getBanners async {
    Uri url = Uri.parse(
        "https://bigbaang.in/big_bank/index.php/Api_customer/offer_bannerList");
    final response = await get(url);
    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _bannerModel = OfferBannerModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _bannerModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _bannerModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  OfferBannerModel? get bannerModel => _bannerModel;

  bool get isLoading => _error == false && _bannerModel == null;
}
