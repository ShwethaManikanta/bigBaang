import 'package:bigbaang/FrontEnd/Pages/CategoryPage/provider/category_provider.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/home_page.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/providers/home_page_provider.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/home_bottom.dart';
import 'package:bigbaang/FrontEnd/Pages/ProfileSetup/profile_setup.dart';
import 'package:bigbaang/Models/login_model.dart';
import 'package:bigbaang/Models/order_history_model.dart';
import 'package:bigbaang/backend/auth/auth_widget.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/auth_widget_builder.dart';
import 'package:bigbaang/service/banner_api_provider.dart';
import 'package:bigbaang/service/category_list_api_provider.dart';
import 'package:bigbaang/service/checkout_list_api_provider.dart';
import 'package:bigbaang/service/clear_cart_api_provider.dart';
import 'package:bigbaang/service/delivery_address_api_provider.dart';
import 'package:bigbaang/service/forget_change_password_api.dart';
import 'package:bigbaang/service/login_provider.dart';
import 'package:bigbaang/service/notification_api_providers.dart';
import 'package:bigbaang/service/order_history_api_provider.dart';
import 'package:bigbaang/service/pick_image_provider.dart';
import 'package:bigbaang/service/product_details.dart';
import 'package:bigbaang/service/profile_api_provider.dart';
import 'package:bigbaang/service/recently_searched_api_provider.dart';
import 'package:bigbaang/service/shop_list_api_provider.dart';
import 'package:bigbaang/service/sign_in_api_provider.dart';
import 'package:bigbaang/service/signup_api_provider.dart';
import 'package:bigbaang/service/subcategory_api_provider.dart';
import 'package:bigbaang/service/top_offers_api_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FrontEnd/CommonWidgets/common_styles.dart';
import 'FrontEnd/CommonWidgets/loading_widget.dart';
import 'FrontEnd/CommonWidgets/utils.dart';
import 'backend/auth/auth_widget_builder.dart';
import 'backend/service/firebase_auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Color(0xffebebeb)));
    return MultiProvider(
      providers: [
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
        ChangeNotifierProvider<HomePageProvider>(
            create: (context) => HomePageProvider()),
        ChangeNotifierProvider<SignInAPIProvider>(
            create: (_) => SignInAPIProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider()),
        ChangeNotifierProvider<SharedPreferencesProvider>(
            create: (context) => SharedPreferencesProvider()),
        ChangeNotifierProvider<SignupAPIProvider>(
            create: (context) => SignupAPIProvider()),
        ChangeNotifierProvider<ProfileApiProvder>(
            create: (context) => ProfileApiProvder()),
        ChangeNotifierProvider<CategoryListApiProvider>(
            create: (_) => CategoryListApiProvider()),
        ChangeNotifierProvider<BannerApiProvider>(
            create: (_) => BannerApiProvider()),
        ChangeNotifierProvider<OfferBannerApiProvider>(
            create: (_) => OfferBannerApiProvider()),
        ChangeNotifierProvider<RecentlySearchedAPIProvider>(
            create: (_) => RecentlySearchedAPIProvider()),
        ChangeNotifierProvider<TopOffersApiProvider>(
            create: (_) => TopOffersApiProvider()),
        ChangeNotifierProvider<AddToCartAPIProvider>(
            create: (context) => AddToCartAPIProvider()),
        ChangeNotifierProvider<NotificationCountAPIProvider>(
            create: (context) => NotificationCountAPIProvider()),
        ChangeNotifierProvider<NotificationListAPIProvider>(
            create: (context) => NotificationListAPIProvider()),
        ChangeNotifierProvider<NotificationUpdateAPIProvider>(
            create: (context) => NotificationUpdateAPIProvider()),
        ChangeNotifierProvider<ForgetPasswordAPIProvider>(
            create: (context) => ForgetPasswordAPIProvider()),
        ChangeNotifierProvider<ChangePasswordAPIProvider>(
            create: (context) => ChangePasswordAPIProvider()),
        ChangeNotifierProvider<ProductDetailsAPIProvider>(
            create: (context) => ProductDetailsAPIProvider()),
        ChangeNotifierProvider<RecentlySearchedAPIProvider>(
            create: (context) => RecentlySearchedAPIProvider()),
        ChangeNotifierProvider<ProfileUpdateApiProvder>(
            create: (context) => ProfileUpdateApiProvder()),
        ChangeNotifierProvider<CartListAPIProvider>(
            create: (context) => CartListAPIProvider()),
        ChangeNotifierProvider<SubCategoryBasedProductAPIPorvider>(
            create: (_) => SubCategoryBasedProductAPIPorvider()),
        ChangeNotifierProvider<ShopListApiProvider>(
            create: (_) => ShopListApiProvider()),
        ChangeNotifierProvider<MeatShopListApiProvider>(
            create: (_) => MeatShopListApiProvider()),
        ChangeNotifierProvider<VegShopListApiProvider>(
            create: (_) => VegShopListApiProvider()),
        ChangeNotifierProvider<OthersShopListApiProvider>(
            create: (_) => OthersShopListApiProvider()),
        ChangeNotifierProvider<DeliveryAddressAPIProvider>(
            create: (_) => DeliveryAddressAPIProvider()),
        ChangeNotifierProvider<CheckOutListAPIProvider>(
            create: (_) => CheckOutListAPIProvider()),
        ChangeNotifierProvider<ClearCartAPIProvider>(
            create: (_) => ClearCartAPIProvider()),
        ChangeNotifierProvider<OrderHistoryAPIProvider>(
            create: (_) => OrderHistoryAPIProvider()),
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService())
      ],
      child: AuthWidgetBuilder(builder: (
        BuildContext context,
        AsyncSnapshot<LoggedInUser?> userSnapshot,
      ) {
        return MaterialApp(
            title: 'Big Baang',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AuthWidget(userSnapshot: userSnapshot));
      }),
    );
  }
}

class GetLoginUser extends StatefulWidget {
  const GetLoginUser({Key? key}) : super(key: key);

  @override
  _GetLoginUserState createState() => _GetLoginUserState();
}

class _GetLoginUserState extends State<GetLoginUser> {
  @override
  void initState() {
    if (mounted) {
      getVerifiedUser();
    }

    super.initState();
  }

  getVerifiedUser() async {
    final loggedInUserProvider =
        Provider.of<LoggedInUser>(context, listen: false);
    if (context.read<SignInAPIProvider>().signInResponse == null) {
      String? token = await FirebaseMessaging.instance.getToken();

      print("Logged In User Phone Number ------------");
      print("Logged In User" + loggedInUserProvider.phoneNo.toString());
      print("Logged In User Phone Number ------------");

      //  deviceToken: token ?? "NA",
      //         userFirebaseID: loggedInUserProvider.uid!,
      //         phoneNumber: loggedInUserProvider.phoneNo!.substring(
      //             loggedInUserProvider.phoneNo!.length - 10,
      //             loggedInUserProvider.phoneNo!.length
      context
          .read<SignInAPIProvider>()
          .sendSignInRequest(SignInRequest(
              phoneNumber: loggedInUserProvider.phoneNo!.substring(
                  loggedInUserProvider.phoneNo!.length - 10,
                  loggedInUserProvider.phoneNo!.length),
              deviceToken: token ?? "NA",
              deviceType: "bigbaangCustomerNotificationChannel"))
          .then((value) {
        setUserID();
        print("User id assigned for user  - - -- - - " +
            context
                .read<SignInAPIProvider>()
                .signInResponse!
                .customerDetails!
                .id);
      });
    }
  }

  setUserID() {
    ApiService.userID =
        context.read<SignInAPIProvider>().signInResponse!.customerDetails!.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: checkForUserNameAndEmail()
          // HomeBottomNavigationScreen()

          ),
    );
  }

  checkForUserNameAndEmail() {
    final verifyUserLoginAPIProvider = Provider.of<SignInAPIProvider>(context);

    if (verifyUserLoginAPIProvider.isLoading) {
      return ifLoading();
    } else if (verifyUserLoginAPIProvider.error) {
      return Utils.showErrorDialog(
          context, verifyUserLoginAPIProvider.errorMessage);
    } else if (verifyUserLoginAPIProvider.signInResponse!.status == "0") {
      return Utils.showErrorDialog(
          context, verifyUserLoginAPIProvider.signInResponse!.message);
    }
    if (verifyUserLoginAPIProvider.signInResponse!.customerDetails!.email ==
            "" ||
        verifyUserLoginAPIProvider.signInResponse!.customerDetails!.username ==
            "") {
      return const HomeBottomScreen();
    } else {
      return const HomeBottomScreen();
    }
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueBold12(),
        )
      ],
    );
  }
}

class GetUserNameAndEmail extends StatefulWidget {
  const GetUserNameAndEmail({Key? key}) : super(key: key);

  @override
  _GetUserNameState createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserNameAndEmail> {
  bool showNextScreen = false;
  String? deviceToken;

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  PageController pageController = PageController();

  bool isLocationInitialized = false;

  bool nameVerified = false, emailVerified = false, phoneNumberVerified = false;

  @override
  void initState() {
    initializeNameNumber();
    super.initState();
  }

  initializeNameNumber() {
    final loggedInUser = Provider.of<LoggedInUser>(context, listen: false);
    phoneNumberController.text = loggedInUser.phoneNo!.length > 9
        ? loggedInUser.phoneNo!.substring(3, loggedInUser.phoneNo!.length)
        : loggedInUser.phoneNo!;
    if (loggedInUser.phoneNo!.length > 10) {
      if (loggedInUser.phoneNo!
              .substring(3, loggedInUser.phoneNo!.length)
              .length ==
          10) {
        setState(() {
          phoneNumberVerified = true;
        });
      }
    }
    emailController.text = loggedInUser.email ?? "";
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (loggedInUser.email != null && loggedInUser.name != null) {
      if (regex.hasMatch(loggedInUser.email ?? "")) {
        setState(() {
          emailVerified = true;
        });
      }
      name.text = loggedInUser.name!;
      if (loggedInUser.name != "" && loggedInUser.name!.length > 3) {
        setState(() {
          nameVerified = true;
        });
      }
    }

    print(nameVerified.toString() +
        "-------" +
        emailVerified.toString() +
        "-------" +
        phoneNumberVerified.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customerName(),
    );
    // return PageView(
    //   physics: NeverScrollableScrollPhysics(),
    //   controller: pageController,
    //   children: [customerName(), selectLocationPage()],
    // );
  }

  customerName() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Utils.getSizedBox(height: 15),
            // Row(
            //   children: [
            //     InkWell(
            //         onTap: () {
            //           Navigator.of(context).pop();
            //         },
            //         child: const Icon(FontAwesomeIcons.arrowLeft))
            //   ],
            // ),
            Utils.getSizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Step 1 of 1: Add Personal Details",
                style: CommonStyles.blackBold12(),
              ),
            ),
            Utils.getSizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Adding these details is a one time process. Next time, you will be directly presented with home screen",
                maxLines: 2,
                style: CommonStyles.blackw54s9Thin(),
              ),
            ),
            Utils.getSizedBox(height: 15),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  readOnly: true,
                  onChanged: (value) {
                    if (value.length == 10) {
                      setState(() {
                        phoneNumberVerified = true;
                      });
                    } else {
                      setState(() {
                        phoneNumberVerified = false;
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  decoration: InputDecoration(
                      prefix: Text(
                        "+91  ",
                        style: CommonStyles.black15(),
                      ),
                      counterText: "",
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Phone Number",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                ),
              ),
              key: phoneNumberKey,
            ),
            Utils.getSizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: name,
                  // autovalidateMode: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  onChanged: (value) {
                    if (value.length >= 3) {
                      setState(() {
                        nameVerified = true;
                      });
                      print("Is name verified" + nameVerified.toString());
                    } else {
                      setState(() {
                        nameVerified = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Name",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Minimum Length is 3";
                    }
                    return null;
                  },
                ),
              ),
              key: nameKey,
            ),
            Utils.getSizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    RegExp regex = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    //   String pattern =
                    //       r'/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i';
                    // = RegExp(pattern);
                    if (regex.hasMatch(value)) {
                      setState(() {
                        emailVerified = true;
                      });
                    } else {
                      setState(() {
                        emailVerified = false;
                      });
                    }
                    print("email virified" + emailVerified.toString());
                  },
                  decoration: InputDecoration(
                      hintStyle: CommonStyles.black11(),
                      hintText: "Email",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value!)) {
                      return "Enter Valid email";
                    }
                    return null;
                  },
                ),
              ),
              key: emailKey,
            ),
            Utils.getSizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: MaterialButton(
                  elevation: 18.0,
                  //Wrap with Material
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  minWidth: 100.0,
                  height: 45,
                  color: nameVerified && emailVerified && phoneNumberVerified
                      ? const Color(0xFF801E48)
                      : Colors.grey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Update', style: CommonStyles.textDataWhite12Bold()),
                      Utils.getSizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                  onPressed:
                      nameVerified && emailVerified && phoneNumberVerified
                          ? () async {
                              if (nameKey.currentState!.validate() &&
                                  emailKey.currentState!.validate() &&
                                  phoneNumberKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();

                                //call update api here
                                // showLoadingWithCustomText(
                                //     context, "Creating Profile");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HomePage()));

                                // await apiServices
                                //     .(
                                //         userName: name.text,
                                //         userEmail: emailController.text,
                                //         userPhoneNumber: phoneNumberController.text)
                                //     .then((value) {
                                //   // context
                                //   //     .read<VerifyUserLoginAPIProvider>()
                                //   //     .getUser(
                                //   //         deviceToken: "deviceToken",
                                //   //         userFirebaseID: loggedInUser.uid!,
                                //   //         phoneNumber: loggedInUser.phoneNo!
                                //   //             .substring(
                                //   //                 3, loggedInUser.phoneNo!.length));
                                //   Navigator.of(context).pop();
                                //   Navigator.of(context).push(MaterialPageRoute(
                                //       builder: (context) => const GetLocation()));
                                // });
                              }
                            }
                          : () {
                              // pageController.nextPage(
                              //     duration: Duration(milliseconds: 150),
                              //     curve: Curves.ease);
                              print(nameVerified.toString() +
                                  "-------" +
                                  emailVerified.toString() +
                                  "-------" +
                                  phoneNumberVerified.toString());
                            },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
