import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/user_text_fields.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/Cart/cart.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/notification_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/profile_screen.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/notification_api_providers.dart';
import 'package:bigbaang/service/profile_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomAppBarWithSearch extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBarWithSearch({Key? key, required this.scaffoldKey})
      : super(key: key);

  @override
  State<CustomAppBarWithSearch> createState() => _CustomAppBarWithSearchState();
}

class _CustomAppBarWithSearchState extends State<CustomAppBarWithSearch> {
  @override
  void initState() {
    initializeProfileDetails();
    super.initState();
  }

  initializeProfileDetails() async {
    if (context.read<ProfileApiProvder>().profileModel == null) {
      context.read<ProfileApiProvder>().fetchProfileDetails();
    }
  }

  final searchTextEditingController = TextEditingController();

  final searchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileAPIProvider = Provider.of<ProfileApiProvder>(context);
    return Container(
      height: 200,
      width: deviceWidth(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1, 1),
          end: Alignment(1, -1),
          colors: <Color>[
            Color(0xff4158D0),
            Color(0xff4158D0),
            Color(0xff4158D0),
            //   Color(0xffc850c0),
            //   Color(0xffffcc70)
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          FontAwesomeIcons.bars,
                          size: 25,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      Utils.getSizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Big Baang",
                              style: HomePageStyles.loginTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/images/bblogo.png",
                              height: 40,
                              width: 40,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const NotificationAppBarWidgetHomePage(),
                      Utils.getSizedBox(width: 10),
                      const CartAppBarWidgetHomePage(),
                      Utils.getSizedBox(width: 10),
                      profileAPIProvider.ifLoading
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()));
                              },
                              child: const SizedBox(
                                height: 35,
                                width: 35,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 27,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                          : SizedBox(
                              width: 35,
                              height: 35,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Hero(
                                    tag: "ProfilePicture",
                                    child: CachedNetworkImageProfilePicture(
                                        height: 27,
                                        width: 27,
                                        imageUrl: profileAPIProvider
                                                .profileModel!.profileBaseurl! +
                                            profileAPIProvider.profileModel!
                                                .userDetails!.profileImage),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
              Container(
                width: deviceWidth(context),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 15, left: 15),
                child: Form(
                  key: searchKey,
                  child: searchTextField(searchTextEditingController,
                      "Item Name", "Item Name", "Item Name", "", "", context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartAppBarWidgetHomePage extends StatefulWidget {
  const CartAppBarWidgetHomePage({Key? key}) : super(key: key);

  @override
  _CartAppBarWidgetHomePageState createState() =>
      _CartAppBarWidgetHomePageState();
}

class _CartAppBarWidgetHomePageState extends State<CartAppBarWidgetHomePage> {
  @override
  void initState() {
    getCartValue();
    super.initState();
  }

  Future getCartValue() async {
    if (context.read<CartListAPIProvider>().cartListResponseModel == null) {
      await context.read<CartListAPIProvider>().getCartList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartListResponseModel = Provider.of<CartListAPIProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const CartPage()));
      },
      child: SizedBox(
        height: 35,
        width: 35,
        child: Stack(
          children: [
            const Align(
                alignment: Alignment.bottomLeft,
                child:
                    Icon(Icons.shopping_cart, size: 27, color: Colors.white)),
            if (cartListResponseModel.ifLoading)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                ),
              )
            else
              Align(
                alignment: Alignment.topRight,
                child: cartListResponseModel.cartListResponseModel == null ||
                        cartListResponseModel.cartListResponseModel!.status ==
                            "0" ||
                        cartListResponseModel
                                .cartListResponseModel!.countProduct ==
                            "" ||
                        cartListResponseModel
                                .cartListResponseModel!.countProduct ==
                            "0"
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 0.3,
                                color: Colors.black54,
                                offset: Offset(-3, 3))
                          ],
                          color: Colors.green,
                        ),
                        child: Center(
                          child: int.parse(cartListResponseModel
                                      .cartListResponseModel!.countProduct
                                      .toString()) >
                                  999
                              ? Text(
                                  "1k+",
                                  style: CommonStyles.textDataWhite8Bold(),
                                )
                              : Text(
                                  cartListResponseModel
                                      .cartListResponseModel!.countProduct!,
                                  style: CommonStyles.textDataWhite8Bold(),
                                ),
                        ),
                      ),
              )
          ],
        ),
      ),
    );
  }
}

class NotificationAppBarWidgetHomePage extends StatefulWidget {
  const NotificationAppBarWidgetHomePage({Key? key}) : super(key: key);

  @override
  _NotificationAppBarWidgetHomePageState createState() =>
      _NotificationAppBarWidgetHomePageState();
}

class _NotificationAppBarWidgetHomePageState
    extends State<NotificationAppBarWidgetHomePage> {
  @override
  void initState() {
    getCartValue();
    super.initState();
  }

  Future getCartValue() async {
    if (context.read<NotificationCountAPIProvider>().notificationCountModel ==
        null) {
      await context.read<NotificationCountAPIProvider>().notificationCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationCount =
        Provider.of<NotificationCountAPIProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NotificationScreen()));
      },
      child: SizedBox(
        height: 35,
        width: 35,
        child: Stack(
          children: [
            const Align(
                alignment: Alignment.bottomLeft,
                child:
                    Icon(Icons.notifications, size: 27, color: Colors.white)),
            if (notificationCount.isLoading)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                ),
              )
            else
              Align(
                alignment: Alignment.topRight,
                child: notificationCount.notificationCountModel == null ||
                        notificationCount.notificationCountModel!
                                .unreadNotificationCount ==
                            "" ||
                        notificationCount.notificationCountModel!
                                .unreadNotificationCount ==
                            "0"
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 0.3,
                                color: Colors.black54,
                                offset: Offset(-3, 3))
                          ],
                          color: Colors.green,
                        ),
                        child: Center(
                          child: int.parse(notificationCount
                                      .notificationCountModel!
                                      .unreadNotificationCount
                                      .toString()) >
                                  999
                              ? Text(
                                  "1k+",
                                  style: CommonStyles.textDataWhite8Bold(),
                                )
                              : Text(
                                  notificationCount.notificationCountModel!
                                      .unreadNotificationCount,
                                  style: CommonStyles.textDataWhite8Bold(),
                                ),
                        ),
                      ),
              )
          ],
        ),
      ),
    );
  }
}
