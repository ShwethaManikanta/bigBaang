import 'dart:convert';
import 'package:bigbaang/Models/order_history_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OrderHistoryAPIProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  OrderHistoryModel? _orderHistoryModel;

  OrderHistoryModel? get orderHistoryModel => _orderHistoryModel;

  bool get isLoading => _error == false && _orderHistoryModel == null;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  initialize() {
    _error = false;
    _errorMessage = "";
    _orderHistoryModel = null;
  }

  Future<void> getOrderHistory() async {
    print("Get cart API");
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/order_history");
    final response = await post(url, body: {"user_id": ApiService.userID});
    print("Add cart list Address " + response.toString());
    print(" -----------Cart User ID " + ApiService.userID!);
    print("The response coede -----" + response.statusCode.toString());
    if (response.statusCode == 200) {
      try {
        print("response body" + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("----------------" + jsonResponse.toString());
        // _addToCartResponseModel = AddToCartResponseModel.fromJson(jsonResponse);
        // print(_addToCartResponseModel.toString());
        _orderHistoryModel = OrderHistoryModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _orderHistoryModel = null;
      }
    } else {
      _error = true;
      _errorMessage = "Something went wrong status code ${response.statusCode}";
      _orderHistoryModel = null;
    }
    notifyListeners();
  }
}
