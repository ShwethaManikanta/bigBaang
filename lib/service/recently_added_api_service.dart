import 'dart:convert';
import 'package:bigbaang/Models/recently_added_product.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class RecentlyAddedApiService with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  RecentlyAddedProductModel? _recentlyAddedProductModel;

  Future<void> getRecentlyAddedProduct() async {
    Uri recentlyAddedProductUrl =
        Uri.parse("${baseURL}index.php/Api_customer/recently_product");
    final response = await post(recentlyAddedProductUrl, body: {
      "lat": 11.4567890,
      "long": 10.4567890,
      'user_id': ApiService.userID
    });

    if (response.statusCode == 200) {
      try {
        print("Response @ Recently" + response.body);

        final jsonResponse = jsonDecode(response.body);
        print("Response @ jsonResonse" + jsonResponse.toString());

        _recentlyAddedProductModel =
            RecentlyAddedProductModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _recentlyAddedProductModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error while getting the data from internet ${response.statusCode}";
      _recentlyAddedProductModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;
  String get errorMessage => _errorMessage;

  RecentlyAddedProductModel? get recentlyAddedProductModel =>
      _recentlyAddedProductModel;
}
