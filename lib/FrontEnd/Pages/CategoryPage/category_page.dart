import 'package:bigbaang/FrontEnd/Pages/CategoryPage/widgets/category_header.dart';
import 'package:bigbaang/FrontEnd/Pages/CategoryPage/widgets/vertical_category_list_builder.dart';
import 'package:flutter/material.dart';

import '../../CommonWidgets/drawer_widget.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalScaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context, _globalScaffoldKey),
      key: _globalScaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBarWithSearchCategoryCategory(
              scaffoldKey: _globalScaffoldKey),
          const Expanded(
              child: VerticalCategoryList(

          ))
        ],
      ),
    );
  }
}
