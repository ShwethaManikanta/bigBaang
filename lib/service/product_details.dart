import 'dart:convert';

import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductDetailsAPIProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ProductDetailModel? _productDetailModel;

  Future<void> getProductDetails(String productId) async {
    Uri productDetails =
        Uri.parse("${baseURL}index.php/Api_customer/product_details");
    final response = await post(productDetails,
        body: {"product_id": productId, "user_id": ApiService.userID});
    print("the response body  ---- - - - - - - - -- - - - - - - --- - -" +
        response.body);
    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        _productDetailModel = ProductDetailModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _productDetailModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "There seems to be problem : ${response.statusCode.toString()}";
      _productDetailModel = null;
    }
    notifyListeners();
  }

  bool get ifLoading => _productDetailModel == null && _error == false;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ProductDetailModel? get productDetailsModel => _productDetailModel;

  void reinitialize() {
    _error = false;
    _errorMessage = "";
    _productDetailModel = null;
  }
}
