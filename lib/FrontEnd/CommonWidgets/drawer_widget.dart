import 'package:avatar_glow/avatar_glow.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/loading_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/CategoryPage/category_page.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/home_page.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/providers/home_page_provider.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/maps_widget_center.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/phoneVerification/phone_verification.dart';
import 'package:bigbaang/FrontEnd/Pages/customer_service.dart';
import 'package:bigbaang/FrontEnd/Pages/my_order_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/notification_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/profile_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/rating_review.dart';
import 'package:bigbaang/FrontEnd/Pages/save_product_screen.dart';
import 'package:bigbaang/FrontEnd/deliver_location.dart';
import 'package:bigbaang/Models/cart_address.dart';
import 'package:bigbaang/Models/profile_model.dart';
import 'package:bigbaang/backend/service/firebase_auth_service.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/checkout_list_api_provider.dart';
import 'package:bigbaang/service/delivery_address_api_provider.dart';
import 'package:bigbaang/service/login_provider.dart';
import 'package:bigbaang/service/profile_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool arrowDown = false;

Drawer drawer(BuildContext context, Key scaffoldKey) {
  final homePageProvider = Provider.of<HomePageProvider>(context);
  final profileDetailsProvider = Provider.of<ProfileApiProvder>(context);
  final checkOutListAPI = Provider.of<CheckOutListAPIProvider>(context);
  final sharedPreferencesProvider =
      Provider.of<SharedPreferencesProvider>(context);
  return Drawer(
    elevation: 2,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                topGreetingSection(profileDetailsProvider),
                Utils.getSizedBox(height: 10),
                //  cartAddressSection(checkOutListAPI, context),
                Utils.getSizedBox(height: 5),
                Divider(
                  thickness: 1.5,
                ),
                Utils.getSizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.car_repair,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Earliest delivery in 1 day*",
                        style: CommonStyles.blackText14BoldW500(),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              homePageProvider.showDeliveryContainer =
                                  !homePageProvider.showDeliveryContainer;
                            },
                            child: Icon(Icons.arrow_drop_down)))
                  ],
                ),
                Utils.getSizedBox(height: 15),
                if (homePageProvider.showDeliveryContainer)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 17, right: 17, bottom: 20),
                    child: Text(
                      "Delivery time might vary for some products. You  can check exact delivery time on each product.",
                      style: CommonStyles.blackText10BoldW500(),
                    ),
                  ),
                Container(
                  height: 8,
                  color: Colors.black12,
                ),
                Utils.getSizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*       Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        shadowColor: Colors.lightBlue,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.home,
                                size: 20,
                                color: Colors.indigo,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomePage()));
                                },
                                child: Text(
                                  "Home",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Utils.getSizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        shadowColor: Colors.lightBlue,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: 20,
                                color: Colors.indigo,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                                },
                                child: Text(
                                  "My Account",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Utils.getSizedBox(height: 20),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10),
                        child: Row(
                          children: [
                            AvatarGlow(
                              endRadius: 20,
                              glowColor: Colors.lightBlue,
                              child: Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.indigo,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyOrderScreen()));
                              },
                              child: Text(
                                "Bigg Baang / My List",
                                style: CommonStyles.blueBold12(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CategoryPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10),
                          child: Row(
                            children: [
                              AvatarGlow(
                                endRadius: 20,
                                glowColor: Colors.lightBlue,
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 20,
                                  color: Colors.indigo,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Shop by Category",
                                style: CommonStyles.blueBold12(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Utils.getSizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10),
                        child: Row(
                          children: [
                            AvatarGlow(
                              endRadius: 20,
                              glowColor: Colors.lightBlue,
                              child: Icon(
                                Icons.miscellaneous_services_rounded,
                                size: 20,
                                color: Colors.indigo,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CustomerService(
                                          userName: profileDetailsProvider
                                              .profileModel!
                                              .userDetails!
                                              .username,
                                        )));
                              },
                              child: Text("Customer Service",
                                  style: CommonStyles.blueBold12()),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 20),
                      /* InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RatingsReviewScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Rate & Review Products",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Utils.getSizedBox(width: 15),
                            Container(
                              height: 20,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "New",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 40),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10),
                        child: Row(
                          children: [
                            AvatarGlow(
                              endRadius: 20,
                              glowColor: Colors.lightBlue,
                              child: Icon(
                                Icons.notifications,
                                size: 20,
                                color: Colors.indigo,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationScreen()));
                              },
                              child: Text(
                                "Notification",
                                style: CommonStyles.blueBold12(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10),
                        child: Row(
                          children: [
                            AvatarGlow(
                              endRadius: 20,
                              glowColor: Colors.indigo,
                              child: Icon(
                                Icons.logout,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                showAlertDialog(
                                    context, sharedPreferencesProvider);
                              },
                              child: Text(
                                "Log Out",
                                style: CommonStyles.greenBold(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Utils.getSizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "FAQ",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Icon(
                            Icons.add,
                            size: 20,
                          )
                        ],
                      ),*/
                      Utils.getSizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

showAlertDialog(
    BuildContext context, SharedPreferencesProvider sharedPreferencesProvider) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: CommonStyles.greenBold(),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "Log out",
      style: CommonStyles.textw200RedS16(),
    ),
    onPressed: () async {
      final firebaseAuthService =
          Provider.of<FirebaseAuthService>(context, listen: false);
      showLoading(context);
      await firebaseAuthService.signOut();
      Navigator.of(context).pop();

      // sharedPreferencesProvider.isUserLoggedIn = false;
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const PhoneVerification(),
      //   ),
      //   (Route route) => false,
      // );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Big Baang",
      style: CommonStyles.blueBold14(),
    ),
    content: Text(
      "Do you want to Logout ?",
      style: CommonStyles.blackText14BoldW500(),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget topGreetingSection(ProfileApiProvder profileDetailsProvider) {
  return profileDetailsProvider.ifLoading
      ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          color: Colors.black54,
          child: Utils.loadingWidget())
      : profileDetailsProvider.error
          ? Container(
              height: 50,
              width: double.infinity,
              color: Colors.black54,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    profileDetailsProvider.errorMessage,
                    style: CommonStyles.whiteText15BoldW500(),
                  ),
                ),
              ))
          : Column(
              children: [
                /* profileDetailsProvider
                        .profileModel!.userDetails!.profileImage.isNotEmpty
                    ? CachedNetworkImageProfilePicture(
                        height: 160,
                        width: 200,
                        imageUrl:
                            "${profileDetailsProvider.profileModel!.profileBaseurl}${profileDetailsProvider.profileModel!.userDetails!.profileImage}")
                    : */
                Image.asset("assets/images/bblogo.png"),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.indigo,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Hello, ${profileDetailsProvider.profileModel!.userDetails!.username}",
                          style: CommonStyles.whiteText15BoldW500(),
                        ),
                      ),
                    )),
              ],
            );
}

cartAddressSection(
    CheckOutListAPIProvider profileDetailsProvider, BuildContext context) {
  return profileDetailsProvider.isLoading
      ? Container(
          /*padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          color: Colors.black54,
          child: Utils.loadingWidget()*/
          )
      : profileDetailsProvider.error
          ? Container(
              height: 50,
              width: double.infinity,
              color: Colors.black54,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    profileDetailsProvider.errorMessage,
                    style: CommonStyles.whiteText15BoldW500(),
                  ),
                ),
              ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          right: 6.0, left: 6.0, top: 3, bottom: 3),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          "${profileDetailsProvider.checkOutModel!.getAllAddressCustomer!.address}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: MaterialButton(
                      color: const Color.fromARGB(255, 105, 13, 13),
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            builder: (_) {
                              return const BottomSheetAddLocation();
                            });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => PlacePickGoogleMaps()));
                      },
                      child: Text(
                        "Change",
                        style: CommonStyles.textDataWhite10Bold(),
                      )),
                )
              ],
            );
}

class BottomSheetAddLocation extends StatefulWidget {
  const BottomSheetAddLocation({Key? key}) : super(key: key);

  @override
  _BottomSheetAddLocationState createState() => _BottomSheetAddLocationState();
}

class _BottomSheetAddLocationState extends State<BottomSheetAddLocation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          headerText(),
          const Divider(
            height: 2,
            thickness: 1,
            color: Colors.black45,
          ),
          Utils.getSizedBox(height: 10),
          Expanded(child: locationListWidget()),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: MaterialButton(
              color: const Color.fromARGB(137, 165, 30, 30),
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () async {
                // final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>));

                String returnObject = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
                if (returnObject == null) {
                  Utils.getFloatingSnackBar(
                      context: context, snackBarText: "No address selected");
                }
                if (returnObject == "success") {
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content))conten
                  context.read<ProfileApiProvder>().fetchProfileDetails();
                }
                // _listLocation.add(LocationAddress(
                //     location: location,
                //     isActive: is.Active,
                //     locationType: locationType));
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Utils.getSizedBox(width: 8),
                    const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                    Utils.getSizedBox(width: 8),
                    Text(
                      "Add Address",
                      style: CommonStyles.textDataWhite12Bold(),
                    ),
                    Utils.getSizedBox(width: 8),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget headerText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: deviceWidth(context),
        child: Text(
          'Your Locations ',
          style: CommonStyles.blackText14thinW500(),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  String _groupValue = "";

  Widget locationListWidget() {
    final profileApiProvider = Provider.of<ProfileApiProvder>(context);
    if (profileApiProvider.ifLoading) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          width: double.infinity,
          color: Colors.black54,
          child: Utils.loadingWidget());
    } else if (profileApiProvider.error) {
      return Container(
          height: 50,
          width: double.infinity,
          color: Colors.black54,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                profileApiProvider.errorMessage,
                style: CommonStyles.whiteText15BoldW500(),
              ),
            ),
          ));
    } else if (profileApiProvider.profileModel!.getAllAddress != null &&
        profileApiProvider.profileModel!.getAllAddress!.length < 0) {
      return Container(
          height: 50,
          width: double.infinity,
          color: Colors.black54,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Address not added",
                style: CommonStyles.whiteText15BoldW500(),
              ),
            ),
          ));
    }
    print("---------------LREHJ-" +
        profileApiProvider.profileModel!.getAllAddress!.length.toString());
    return Scrollbar(
      isAlwaysShown: false,
      thickness: 10,
      radius: const Radius.circular(8),
      child: ListView.builder(
          itemCount: profileApiProvider.profileModel!.getAllAddress!.length,
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (context, index) {
            return locationCard(
                index, profileApiProvider.profileModel!.getAllAddress![index]);
          }),
    );
  }

  Widget locationCard(int index, GetAllAddress address) {
    return Card(
      //  color: Colors.pinkAccent,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                getAddressTypeText(address.addressTypeId!),
                style: CommonStyles.blackText12BoldW400(),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              children: [
                SizedBox(
                    height: 50,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address.doorNo! +
                            "," +
                            address.street! +
                            "," +
                            address.address!,
                        style: CommonStyles.blackText14BoldW500(),
                      ),
                    )),
                Utils.getSizedBox(width: 10),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Radio(
                        value: _listLocation[index].location.toString(),
                        groupValue: _groupValue,
                        onChanged: (value) async {
                          print(value.toString());
                          if (value.toString() != _groupValue) {
                            var result = await showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8))),
                                builder: (context) {
                                  return ConfirmLocationChangeWidget(
                                    addressType:
                                        address.addressTypeId.toString(),
                                    address: address.address!,
                                  );
                                });
                            print(result);
                            setState(() {
                              _groupValue = result;
                            });
                          } else {
                            print("else Part pringting");
                            Utils.getFloatingSnackBar(
                                context: context,
                                snackBarText:
                                    "Already selected as delivery address!!");
                          }
                        }),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () async {
                      String returnObject = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SearchPage()));
                      if (returnObject == null) {
                        Utils.getFloatingSnackBar(
                            context: context,
                            snackBarText: "No address selected");
                      }
                      if (returnObject == "success") {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content))conten
                        context.read<ProfileApiProvder>().fetchProfileDetails();
                      }
                    },
                    child: Center(
                      child: Row(
                        children: [
                          Utils.getSizedBox(width: 8),
                          const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                          Utils.getSizedBox(width: 8),
                          Text(
                            "Edit",
                            style: CommonStyles.textDataWhite12Bold(),
                          ),
                          Utils.getSizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                _groupValue != _listLocation[index].location
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            var result = await showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8))),
                                builder: (context) {
                                  return ConfirmLocationChangeWidget(
                                    addressType:
                                        address.addressTypeId.toString(),
                                    address: address.address!,
                                    createNewAddress: true,
                                  );
                                });
                            print(result);
                            setState(() {
                              _groupValue = result;
                            });
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Utils.getSizedBox(width: 8),
                                const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Utils.getSizedBox(width: 8),
                                Text(
                                  "Select Delevery Address",
                                  style: CommonStyles.textDataWhite12Bold(),
                                ),
                                Utils.getSizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: MaterialButton(
                          color: Colors.black54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {},
                          child: Center(
                            child: Row(
                              children: [
                                Utils.getSizedBox(width: 8),
                                const Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Utils.getSizedBox(width: 8),
                                Text(
                                  "Selected",
                                  style: CommonStyles.textDataWhite12Bold(),
                                ),
                                Utils.getSizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }

  getAddressTypeText(String id) {
    switch (id) {
      case "1":
        return "Home";
      case "2":
        return "Office";
      case "3":
        return "Others";
    }
  }

  getAddressTypeID(String addressType) {
    switch (addressType) {
      case "Home":
        return "1";
      case "Office":
        return "2";
      case "Others":
        return "3";
    }
  }
}

// class ShowSelectedAddress extends StatefulWidget {
//   const ShowSelectedAddress({Key? key}) : super(key: key);

//   @override
//   _ShowSelectedAddressState createState() => _ShowSelectedAddressState();
// }

// class _ShowSelectedAddressState extends State<ShowSelectedAddress> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

List<LocationAddress> _listLocation = [
  LocationAddress(
      locationType: "Home",
      isActive: "",
      location: "Bhadrappa Layour Kodigehalli 560094 Banglore,1"),
  LocationAddress(
      locationType: "Work",
      isActive: "",
      location: "Bhadrappa Layour Kodigehalli 560094 Banglore,2"),
  LocationAddress(
      locationType: "Office",
      isActive: "",
      location: "Bhadrappa Layour Kodigehalli 560094 Banglore,3"),
  LocationAddress(
      locationType: "Home1",
      isActive: "",
      location: "Bhadrappa Layour Kodigehalli 560094 Banglore,4")
];

class LocationAddress {
  late String location, locationType;
  late String isActive;

  LocationAddress(
      {required this.location,
      required this.isActive,
      required this.locationType});
}

class ConfirmLocationChangeWidget extends StatefulWidget {
  const ConfirmLocationChangeWidget(
      {Key? key,
      required this.address,
      required this.addressType,
      this.createNewAddress = false})
      : super(key: key);
  final String address;
  final bool createNewAddress;
  final String addressType;

  @override
  _ConfirmLocationChangeWidgetState createState() =>
      _ConfirmLocationChangeWidgetState();
}

class _ConfirmLocationChangeWidgetState
    extends State<ConfirmLocationChangeWidget> {
  getAddressTypeText(String id) {
    switch (id) {
      case "1":
        return "Home";
      case "2":
        return "Office";
      case "3":
        return "Others";
    }
  }

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final deliveryAddressProvider =
        Provider.of<DeliveryAddressAPIProvider>(context);
    final checkoutListApiProvider =
        Provider.of<CheckOutListAPIProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: SizedBox(
        height: 160,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.createNewAddress
                    ? Text(
                        "New Delivery Address ",
                        style: CommonStyles.blackText14thinW500(),
                      )
                    : Text(
                        "Your Delivery Address will be Changed to",
                        style: CommonStyles.blackText14thinW500(),
                      ),
                Utils.getSizedBox(height: 20),
                Text(
                  widget.address,
                  style: CommonStyles.blackText14BoldW500(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                elevation: 10,
                minWidth: 200,
                color: const Color.fromARGB(255, 1, 33, 59),
                onPressed: () async {
                  showLoading(context);
                  await deliveryAddressProvider.deliveryAddress(
                      ApiService.userID!, widget.addressType);
                  await checkoutListApiProvider.checkOutList();

                  Navigator.of(context).pop();
                  Navigator.of(context).pop(widget.address);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "OK",
                    style: CommonStyles.whiteText15BoldW500(),
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
