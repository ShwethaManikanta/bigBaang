import 'dart:convert';

import 'package:bigbaang/Models/add_to_cart_model.dart';
import 'package:bigbaang/Models/cart_address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EditCartAddress with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  // AddToCartResponseModel? _addToCartResponseModel;

  Future<void> addToCart(EditCartAddressRequestModel editCartAddress) async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/addToCart");
    final response = await post(url, body: editCartAddress.toMap());
    print("Add to cart request model " + editCartAddress.toString());
    print("The response coede -----" + response.statusCode.toString());
    if (response.statusCode == 200) {
      try {
        print("response body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("----------------" + jsonResponse.toString());
        // _addToCartResponseModel = AddToCartResponseModel.fromJson(jsonResponse);
        // print(_addToCartResponseModel.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        // _addToCartResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      // _addToCartResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  // AddToCartResponseModel? get addToCartResponse => _addToCartResponseModel;
}
