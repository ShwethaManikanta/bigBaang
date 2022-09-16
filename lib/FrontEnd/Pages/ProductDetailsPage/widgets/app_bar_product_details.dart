import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarProductDetailsPage extends StatelessWidget {
  const AppBarProductDetailsPage({
    Key? key,
  }) : super(key: key);

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
            Color(0xffc850c0),
            Color(0xffffcc70)
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
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
                        size: 25,
                        color: Colors.white,
                      )),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.share, size: 27, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart,
                        size: 27, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
