import 'dart:convert';
import 'package:bigbaang/Models/add_to_cart_model.dart';
import 'package:bigbaang/Models/cart_product_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddToCartAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  AddToCartResponseModel? _addToCartResponseModel;

  Future<void> addToCart(AddToCartRequestModel addToCartRequestModel) async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/addToCart");
    final response = await post(url, body: addToCartRequestModel.toJson());
    print("Add to cart request model " + addToCartRequestModel.toString());
    print("The response coede -----" + response.statusCode.toString());
    if (response.statusCode == 200) {
      try {
        print("response body add To cart----" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("----------------" + jsonResponse.toString());
        _addToCartResponseModel = AddToCartResponseModel.fromJson(jsonResponse);
        print(_addToCartResponseModel.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _addToCartResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _addToCartResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  AddToCartResponseModel? get addToCartResponse => _addToCartResponseModel;
}

class CartListAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  CartListResponseModel? _cartListResponseModel;

  Future<void> get getCartList async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/cartlist");
    final response = await post(url, body: {'user_id': ApiService.userID!});
    print("Response . StatusCode ------------   ${response.statusCode}");
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _cartListResponseModel = CartListResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _cartListResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _cartListResponseModel = null;
    }
    notifyListeners();
  }

  bool get ifLoading => _error == false && _cartListResponseModel == null;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  CartListResponseModel? get cartListResponseModel => _cartListResponseModel;
}
