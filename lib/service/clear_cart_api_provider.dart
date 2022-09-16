import 'dart:convert';
import 'package:bigbaang/Models/place_order_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ClearCartAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  PlaceOrderModel? _clearCartModel;

  PlaceOrderModel? get clearCartModel => _clearCartModel;

  bool get isLoading => _error == false && _clearCartModel == null;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _clearCartModel = null;
  }

  Future<void> getClearCart() async {
    print("Get cart API");
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/order_cart_clear");
    final response = await post(url, body: {"user_id": ApiService.userID});

    print(" -----------_clearCartModel " + ApiService.userID!);
    print("The response coede -----" + response.statusCode.toString());
    if (response.statusCode == 200) {
      try {
        print("response body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("----------------" + jsonResponse.toString());
        _clearCartModel = PlaceOrderModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _clearCartModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "_clearCartModel went wrong status code ${response.statusCode}";
      _clearCartModel = null;
    }
    notifyListeners();
  }
}
