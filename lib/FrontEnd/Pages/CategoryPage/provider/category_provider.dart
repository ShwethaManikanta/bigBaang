import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  bool _isExpandedCategory = false;

  bool get isExpandedCategory => _isExpandedCategory;

  set isExpandedCategory(bool value) {
    _isExpandedCategory = value;
    notifyListeners();
  }
}
