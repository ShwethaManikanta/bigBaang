import 'dart:convert';
import 'package:bigbaang/Models/shop_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ShopListApiProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ShopListModel? _shopListModel;

  ShopListModel? get shopListModel => _shopListModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get isLoading => _error == false && _shopListModel == null;

  Future<void> get getShopListData async {
    Uri shopListURL = Uri.parse("${baseURL}index.php/Api_customer/listvendor");
    print("Get SHOP Uri Parsed");
    final response = await post(shopListURL, body: {"type": "1"});

    print("Respnse got from shopListURL uri!");

    if (response.statusCode == 200) {
      try {
        print("Decoding json file");
        final jsonResponse = jsonDecode(response.body);
        print("get SHOP List json file decoded");
        _shopListModel = ShopListModel.fromJson(jsonResponse);
        print("Data Ready");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _shopListModel = null;
        print("Error caught while parsing json");
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong : Status Code ${response.statusCode}";
      _shopListModel = null;
      print("Error caught while getting response from json");
    }
    notifyListeners();
  }
}

// meat  Type  - 2
class MeatShopListApiProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ShopListModel? _shopListModel;

  ShopListModel? get shopListModel => _shopListModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get isLoading => _error == false && _shopListModel == null;

  Future<void> get getShopListData async {
    Uri shopListURL = Uri.parse("${baseURL}index.php/Api_customer/listvendor");
    print("Get SHOP Uri Parsed");
    final response = await post(shopListURL, body: {"type": "2"});
    print("Respnse got from shopListURL uri!");

    if (response.statusCode == 200) {
      try {
        print("Decoding json file");
        final jsonResponse = jsonDecode(response.body);
        print("get SHOP List json file decoded");
        _shopListModel = ShopListModel.fromJson(jsonResponse);
        print("Data Ready");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _shopListModel = null;
        print("Error caught while parsing json");
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong : Status Code ${response.statusCode}";
      _shopListModel = null;
      print("Error caught while getting response from json");
    }
    notifyListeners();
  }
}

// Veg  type 3

class VegShopListApiProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ShopListModel? _shopListModel;

  ShopListModel? get shopListModel => _shopListModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get isLoading => _error == false && _shopListModel == null;

  Future<void> get getShopListData async {
    Uri shopListURL = Uri.parse("${baseURL}index.php/Api_customer/listvendor");
    print("Get SHOP Uri Parsed");
    final response = await post(shopListURL, body: {"type": "3"});

    print("Respnse got from shopListURL uri!");

    if (response.statusCode == 200) {
      try {
        print("Decoding json file");
        final jsonResponse = jsonDecode(response.body);
        print("get SHOP List json file decoded");
        _shopListModel = ShopListModel.fromJson(jsonResponse);
        print("Data Ready");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _shopListModel = null;
        print("Error caught while parsing json");
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong : Status Code ${response.statusCode}";
      _shopListModel = null;
      print("Error caught while getting response from json");
    }
    notifyListeners();
  }
}

// Others

class OthersShopListApiProvider extends ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  ShopListModel? _shopListModel;

  ShopListModel? get shopListModel => _shopListModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get isLoading => _error == false && _shopListModel == null;

  Future<void> get getShopListData async {
    Uri shopListURL = Uri.parse("${baseURL}index.php/Api_customer/listvendor");
    print("Get SHOP Uri Parsed");
    final response = await post(shopListURL, body: {"type": "4"});

    print("Respnse got from shopListURL uri!");

    if (response.statusCode == 200) {
      try {
        print("Decoding json file");
        final jsonResponse = jsonDecode(response.body);
        print("get SHOP List json file decoded");
        _shopListModel = ShopListModel.fromJson(jsonResponse);
        print("Data Ready");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _shopListModel = null;
        print("Error caught while parsing json");
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong : Status Code ${response.statusCode}";
      _shopListModel = null;
      print("Error caught while getting response from json");
    }
    notifyListeners();
  }
}
