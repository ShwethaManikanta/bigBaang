import 'dart:convert';
import 'package:bigbaang/Models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CategoryListApiProvider extends ChangeNotifier {


  final String baseURL = "https://bigbaang.in/bigbaang_admin/";



  bool _error = false;
  String _errorMessage = "";
  CategoryListData? _categoryListData;

  bool get isLoading => _error == false && _categoryListData == null;

  Future<void> get getCategoryListData async {
    Uri categoryListDataUrl = Uri.parse(
        "${baseURL}index.php/Api_customer/listcategory");
    print("Get Category Uri Parsed");
    final response = await post(categoryListDataUrl);
    print("Respnse got from category uri!");
    print("response Body------------" + response.body.toString());
    if (response.statusCode == 200) {
      try {
        print("Decoding json file");
        final jsonResponse = jsonDecode(response.body);
        print("get category List json file decoded");
        _categoryListData = CategoryListData.fromJson(jsonResponse);
        print("Data Ready");
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _categoryListData = null;
        print("Error caught while parsing json");
      }
    } else {
      _error = true;
      _errorMessage =
          "Something went wrong : Status Code ${response.statusCode}";
      _categoryListData = null;
      print("Error caught while getting response from json");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  CategoryListData? get categoryListData => _categoryListData;
}
