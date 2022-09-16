import 'dart:convert';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SubCategoryAPIPorvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  SubCategoryModel? _subCategoryModel;

  Future<void> getSubCategoryModel(String categoryId) async {
    Uri subCategoryUrl =
        Uri.parse("${baseURL}index.php/Api_customer/list_subcategory");

    final response =
        await post(subCategoryUrl, body: {"category_id": categoryId});
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _subCategoryModel = SubCategoryModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _subCategoryModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went Wrong Status Code : ${response.statusCode}";
      _subCategoryModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  SubCategoryModel? get subCategoryModel => _subCategoryModel;

  bool get isLoading => _subCategoryModel == null && _error == false;

  initialize() {
    _error = false;
    _errorMessage = "";
    _subCategoryModel = null;
  }
}

class SubCategoryBasedProductAPIPorvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  SubCategoryProductsModel? _subCategoryProductsModel;

  Future<void> getSubCategoryProducts(String categoryId,String retailerID,
      {String filterMode = "0"}) async {
    Uri subCategoryBasedProductUrl =
        Uri.parse("${baseURL}index.php/Api_customer/subcategory_based_product");

    final response = await post(subCategoryBasedProductUrl, body: {
      "subcategory_id": categoryId,
      "filter": filterMode,
      "user_id": ApiService.userID,
      "retailer_id" : retailerID

    });


    print("categoryId ----------- All Product ------ "+categoryId);
    print("retailerID ----------- All Product ------ "+retailerID);

    print("user_id ----------- All Product ------ "+ApiService.userID.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _subCategoryProductsModel =
            SubCategoryProductsModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _subCategoryProductsModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went Wrong Status Code : ${response.statusCode}";
      _subCategoryProductsModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  SubCategoryProductsModel? get subCategoryModel => _subCategoryProductsModel;

  bool get isLoading => _subCategoryProductsModel == null && _error == false;

  initialize() {
    _error = false;
    _errorMessage = "";
    _subCategoryProductsModel = null;
  }
}
