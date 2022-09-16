import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/user_text_fields.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBarWithSearchCategoryCategory extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  CustomAppBarWithSearchCategoryCategory({Key? key, required this.scaffoldKey})
      : super(key: key);
  final searchTextEditingController = TextEditingController();
  final searchKey = GlobalKey<FormState>();
  final List<String> list1 = List.generate(5, (index) => "index $index");
  final List<String> list2 = List.generate(5, (index) => "index $index");

  @override
  Widget build(BuildContext context) {
    return //AppBar for the app
        Container(
      width: deviceWidth(context),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff4158D0),
            Color(0xff4158D0),
            Color(0xff4158D0),
            /* Color(0xffc850c0),
            Color(0xffffcc70)*/
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.bars,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Text(
                    "Shop By Category",
                    style: HomePageStyles.loginTextStyle(),
                  ),
                ],
              ),
            ),
            Container(
              width: deviceWidth(context),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 15, left: 15),
              child: Form(
                key: searchKey,
                child: searchTextField(searchTextEditingController, "Item Name",
                    "Item Name", "Item Name", "", "", context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
