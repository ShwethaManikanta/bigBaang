import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/home_page.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/styles/phone_verification_styles.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:flutter/material.dart';

class RatingsReviewScreen extends StatefulWidget {
  @override
  _RatingsReviewScreenState createState() => _RatingsReviewScreenState();
}

class _RatingsReviewScreenState extends State<RatingsReviewScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarProductPage(
            scaffoldKey: scaffoldKey,
            noIcon: true,
            appBartext: "My Ratings & Reviews",
          ),
          Utils.getSizedBox(height: 10),
          DefaultTabController(
              length: 2,
              initialIndex: 1,
              child: Column(
                children: [
                  TabBar(
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.deepPurple,
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: 'Refine by',
                        ),
                        Tab(
                          text: 'Sort by',
                        ),
                      ]),
                  Container(
                    height: 500,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/cart.jpg"),
                              Utils.getSizedBox(height: 30),
                              Text(
                                "Oh! looks like you have not yet shopped any \nProduct",
                                style: CommonStyles.genderTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Utils.getSizedBox(height: 40),
                              MaterialButton(
                                elevation: 5,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.45,
                                height: 35,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomePage()));
                                },
                                child: Text(
                                  "Shop Now",
                                  style: PhoneVerificationStyles
                                      .sendOTPButtonTextStyle(),
                                ),
                                color: const Color(0xff6677d1),
                                splashColor: Colors.green,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/cart.jpg"),
                              Utils.getSizedBox(height: 30),
                              Text(
                                "Oh! looks like you have not yet shopped any \nProduct",
                                style: CommonStyles.genderTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Utils.getSizedBox(height: 40),
                              MaterialButton(
                                elevation: 5,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.45,
                                height: 35,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomePage()));
                                },
                                child: Text(
                                  "Shop Now",
                                  style: PhoneVerificationStyles
                                      .sendOTPButtonTextStyle(),
                                ),
                                color: const Color(0xff6677d1),
                                splashColor: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
