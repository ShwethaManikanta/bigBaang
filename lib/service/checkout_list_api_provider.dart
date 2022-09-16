import 'dart:convert';
import 'package:bigbaang/Models/checkout_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CheckOutListAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  CheckOutModel? _checkOutModel;

  CheckOutModel? get checkOutModel => _checkOutModel;
  bool get isLoading => _error == false && _checkOutModel == null;

  Future<void> checkOutList() async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/checkout_list");
    final response = await post(url, body: {"user_id": ApiService.userID});
    print("Add Checkout Address " + response.toString());
    print("The response coede -----" + response.statusCode.toString());
    if (response.statusCode == 200) {
      try {
        print("response body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("----------------" + jsonResponse.toString());
        // _addToCartResponseModel = AddToCartResponseModel.fromJson(jsonResponse);
        // print(_addToCartResponseModel.toString());
        _checkOutModel = CheckOutModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _checkOutModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _checkOutModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;
}
