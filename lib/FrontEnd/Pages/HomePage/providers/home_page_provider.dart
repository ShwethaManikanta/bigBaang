// ignore_for_file: constant_identifier_names

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

enum HomePageState { Uninitialized, Initailized }

class HomePageProvider with ChangeNotifier {
  HomePageState _state = HomePageState.Uninitialized;
  final CarouselController _carouselController = CarouselController();
  String _currentAddress = "Basveswara nagar, Bangalore";

  // String get currentAddress => _currentAddress;

  String? getCurrentAddress() {
    return _currentAddress;
  }

  set currentAddress(String value) {
    _currentAddress = value;
    notifyListeners();
    print("----------${_currentAddress} =---------");
  }

  HomePageProvider() {
    _state = HomePageState.Initailized;
  }

  HomePageState get state => _state;

  CarouselController get carouselController => _carouselController;

  bool _showDeliveryContainer = false;

  bool get showDeliveryContainer => _showDeliveryContainer;

  set showDeliveryContainer(bool value) {
    _showDeliveryContainer = value;
    notifyListeners();
  }
}
