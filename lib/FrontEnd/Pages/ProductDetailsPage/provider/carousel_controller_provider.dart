import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class CarouselControllerProvider with ChangeNotifier {
  CarouselController _carouselController = CarouselController();

  late List<String> _imagesLinkList;
  // String _currentImageViewUrl;

  bool _bookProcessing = false;
  bool _isCompletedBooking = false;

  bool _isAddCart = false;
  // double opacity = 0.0;

  //SliverPresistantHeader
  double _shrinkOffset = 0.0;
  double _scale = 1.0;

  List<String> get imagesLinkList => _imagesLinkList;

  CarouselControllerProvider() {
    _imagesLinkList = [
      'https://domf5oio6qrcr.cloudfront.net/medialibrary/5299/h1018g16207257715328.jpg',
      'https://www.eatthis.com/wp-content/uploads/sites/4/2020/02/Cauliflower.jpg?quality=82&strip=1&resize=640%2C360'
    ];
  }
  // set currentImageView(String url) {
  //   _currentImageViewUrl = url;
  //   notifyListeners();
  // }

  set carouselController(CarouselController controller) {
    _carouselController = controller;
    notifyListeners();
  }

  CarouselController get carouselController => _carouselController;

  double imageOpacity(double shrinkOffset, double maxExtent) {
    if (shrinkOffset.isNaN || maxExtent.isNaN) {
      return _shrinkOffset = 0;
    }
    _shrinkOffset = (1.0 - max(0.0, shrinkOffset) / maxExtent);
    if (_shrinkOffset.isNaN) {
      _shrinkOffset = 0.99;
    }

    return _shrinkOffset;
  }

  double imageScale(double shrinkOffset, double maxExtent) {
    if (shrinkOffset.isNaN || maxExtent.isNaN) {
      return _scale = 1;
    }
    _scale = (1.5 - max(0.0, shrinkOffset) / maxExtent);
    if (_scale > 1) {
      _scale = 1.01;
    }

    if (_scale.isNaN) {
      _scale = 0.01;
    }
    return _scale;
  }

  // String formatDate(DateTime dateTime) {
  //   return dateFormatter.format(dateTime);
  // }

  // set dateOfBooking(String date) {
  //   if (date != null) {
  //     _dateOfBooking = date;
  //   } else {
  //     _dateOfBooking = null;
  //   }
  // }

  // set timeOfBooking(String time) {
  //   if (time != null) {
  //     _timeOfBooking = time;
  //   } else {
  //     _timeOfBooking = null;
  //   }
  // }

  // String get dateOfBooking => _dateOfBooking;

  // String get timeOfBooking => _timeOfBooking;

  // void clearTimeAndDateOfBooking() {
  //   _dateOfBooking = _timeOfBooking = null;
  //   _isCompletedBooking = _bookProcessing = false;
  // }

  // bool isTimeAndDateValidate() {
  //   if (_timeOfBooking.isNotEmpty && _dateOfBooking.isNotEmpty) return true;
  //   return false;
  // }

  double get scale => _scale;

  double get shrinkOffset => _shrinkOffset;

  // set bookedDateTime(DateTime dateTime) {
  //   if (dateTime != null) {
  //     _bookedDate = dateTime;
  //   }
  // }

  // DateTime get bookedDateTime => _bookedDate;

  set bookProcessing(bool processing) {
    _bookProcessing = processing;
    notifyListeners();
  }

  set isCompletedBooking(bool isFinishedBoking) {
    _isCompletedBooking = isFinishedBoking;
    notifyListeners();
  }

  set isAddCart(bool isAddCart) {
    _isAddCart = isAddCart;
    notifyListeners();
  }

  bool get isCompletedBooking => _isCompletedBooking;

  bool get bookProcessing => _bookProcessing;

  bool get isAddCart => _isAddCart;
}

class GeneralProviderProductDetails with ChangeNotifier {
  bool _isExpanded = false;
  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  bool get isExpanded => _isExpanded;
}
