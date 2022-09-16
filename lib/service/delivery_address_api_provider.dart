import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DeliveryAddressAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  // AddToCartResponseModel? _addToCartResponseModel;

  Future<void> deliveryAddress(String userId, String type) async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/address_type_update");
    final response = await post(url, body: {"user_id": userId, "type": type});
    print("Add Delivery Address " + response.toString());
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
