import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../FrontEnd/Pages/HomePage/widgets/app_bar_and_search.dart';

class AppBarProductPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  AppBarProductPage(
      {Key? key,
      required this.scaffoldKey,
      this.onlySearch = false,
      this.noIcon = false,
      this.showFilter = false,
      this.showCart = false,
      required this.appBartext})
      : super(key: key);
  final searchTextEditingController = TextEditingController();
  final searchKey = GlobalKey<FormState>();
  final List<String> list1 = List.generate(5, (index) => "index $index");
  final List<String> list2 = List.generate(5, (index) => "index $index");
  final bool onlySearch;
  final String appBartext;
  final bool noIcon;
  final bool showFilter;
  final bool showCart;

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
            /*Color(0xffc850c0),
            Color(0xffffcc70)*/
          ],
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                Center(
                  child: Text(
                    appBartext,
                    style: HomePageStyles.loginTextStyle(),
                  ),
                ),
              ],
            ),
            if (!noIcon)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                            onPressed: () async {
                              // await showSearch(
                              //     context: context,
                              //     delegate: DataSearch(
                              //         controller: textEditingController,
                              //         productNameList: nameList,
                              //         productCategoryList: categoryList));
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 27,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),*/
                  if (showCart)
                    const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: CartAppBarWidgetHomePage()),
                  /* if (showFilter)
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                              onPressed: () {
                                // FilterScreen();
                              },
                              icon: const Icon(
                                Icons.filter_list_alt,
                                size: 27,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )*/
                ],
              ),
          ],
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
