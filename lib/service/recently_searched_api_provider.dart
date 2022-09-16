import 'dart:convert';

import 'package:bigbaang/Models/recent_searched.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RecentlySearchedAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  RecentlySearchedProductModel? _recentlySearchedModel;

  Future<void> get recentlySearchedProducts async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/recently_product");
    final response = await post(url, body: {'user_id': ApiService.userID});
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _recentlySearchedModel =
            RecentlySearchedProductModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _recentlySearchedModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong status code : ${response.statusCode}";
      _recentlySearchedModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  RecentlySearchedProductModel? get recentlySearchedModel =>
      _recentlySearchedModel;

  bool get isLoading => _error == false && _recentlySearchedModel == null;
}
