import 'dart:convert';
import 'package:bigbaang/Models/top_offers_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TopOffersApiProvider with ChangeNotifier {
  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  bool _error = false;
  String _errorMessage = "";
  TopOffersModel? _topOffersModel;

  Future<void> get getTopOffersModel async {
    Uri topOfferUrl = Uri.parse("${baseURL}index.php/Api_customer/top_offers");
    final response =
        await post(topOfferUrl, body: {'user_id': ApiService.userID});
    if (response.statusCode == 200) {
      try {
        print("Response from the top offer api call " + response.body);
        final jsonResponse = jsonDecode(response.body);
        print("Json Response from the top offer api call " +
            jsonResponse.toString());
        _topOffersModel = TopOffersModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _topOffersModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error while getting the data from internet ${response.statusCode}";
      _topOffersModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  TopOffersModel? get topOffersModel => _topOffersModel;

  bool get isLoading => _error == false && _topOffersModel == null;
}
