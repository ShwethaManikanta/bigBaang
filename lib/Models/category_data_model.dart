import 'package:flutter/material.dart';

class Categories {
  final String category, imagePath;

  Categories({required this.category, required this.imagePath});
}

class CategoriesWithIcon {
  final IconData categoryIcon;
  final String categoryString;
  CategoriesWithIcon(
      {required this.categoryIcon, required this.categoryString});
}

class SubCategoriesWithIcon {
  // final IconData categoryIcon;
  final String categoryString;
  SubCategoriesWithIcon({required this.categoryString});
}
