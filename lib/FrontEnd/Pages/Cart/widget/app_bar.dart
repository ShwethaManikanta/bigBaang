import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  CustomAppBar({Key? key, required this.scaffoldKey, this.back = false})
      : super(key: key);
  final searchTextEditingController = TextEditingController();
  final searchKey = GlobalKey<FormState>();
  // final List<String> list1 = List.generate(5, (index) => "index $index");
  // final List<String> list2 = List.generate(5, (index) => "index $index");
  final bool back;

  @override
  Widget build(BuildContext context) {
    return //AppBar for the app
        Container(
      width: deviceWidth(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1, 1),
          end: Alignment(1, -1),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  back != true
                      ? IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.bars,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            scaffoldKey.currentState?.openDrawer();
                          },
                        )
                      : IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                  Text(
                    "Review Cart",
                    style: HomePageStyles.loginTextStyle(),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     // IconButton(
              //     //     onPressed: () async {
              //     //       // await showSearch(
              //     //       //     context: context,
              //     //       //     delegate: DataSearch(
              //     //       //         controller: textEditingController,
              //     //       //         productNameList: nameList,
              //     //       //         productCategoryList: categoryList));
              //     //     },
              //     //     icon: const Icon(
              //     //       Icons.search,
              //     //       size: 24,
              //     //       color: Colors.white,
              //     //     )),
              //     // IconButton(
              //     //   onPressed: () {},
              //     //   icon: const Icon(Icons.more_vert,
              //     //       size: 27, color: Colors.white),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownMenuModel {
  final String dropDownText;
  final String icon;
  DropDownMenuModel({required this.dropDownText, required this.icon});
}
