import 'dart:io';
import 'dart:math';

import 'package:bigbaang/FrontEnd/CommonWidgets/clippers.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/home_bottom.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/phoneVerification/verify_screen.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/login_provider.dart';
import 'package:bigbaang/service/sign_in_api_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobile_number_picker/mobile_number_picker.dart';
import 'package:provider/provider.dart';

import '../../../../backend/service/firebase_auth_service.dart';
import '../../../../main.dart';
import '../../../CommonWidgets/common_styles.dart';
import '../../../CommonWidgets/utils.dart';

// class HomeWidget extends StatelessWidget {
//   const HomeWidget(
//       {Key? key, required this.isLoggedIn, required this.viewedSplashPage})
//       : super(key: key);
//
//   final bool isLoggedIn;
//   final bool viewedSplashPage;
//
//   @override
//   Widget build(BuildContext context) {
//     if (viewedSplashPage) {
//       return LoginCheck(
//         isLoggedIn: isLoggedIn,
//       );
//     }
//     return const Onboarding();
//   }
// }

// class LoginCheck extends StatelessWidget {
//   const LoginCheck({Key? key, required this.isLoggedIn}) : super(key: key);

//   final bool isLoggedIn;

//   @override
//   Widget build(BuildContext context) {
//     if (isLoggedIn) {
//       final sharedPreferencesProvider =
//           Provider.of<SharedPreferencesProvider>(context, listen: false);
//       ApiService.userID = sharedPreferencesProvider.userId;
//       return const HomeBottomScreen();
//     }
//     return const PhoneVerification();
//   }
// }

// class PhoneVerification extends StatefulWidget {
//   const PhoneVerification({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _LandingPageState createState() => _LandingPageState();
// }

// class _LandingPageState extends State<PhoneVerification> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   body() {
//     return const PhoneNumberPageView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return body();
//   }
// }

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneNumberPageViewState();
}

class _PhoneNumberPageViewState extends State<PhoneVerification> {
  bool showNextScreen = false;
  PageController pageController = PageController();
  final assetsImageList = [
    'assets/loginImages/avacardo.png',
    'assets/loginImages/beans.png',
    'assets/loginImages/brocklee.png',
    'assets/loginImages/cabbage.png',
    'assets/loginImages/carrot.png',
    'assets/loginImages/greens.png',
    'assets/loginImages/hurbs.png',
    'assets/loginImages/lemon.png',
    'assets/loginImages/peanuts.png'
  ];

  void _refresh() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void goBack() {
    // pageController.initialPage(
    //     duration: const Duration(seconds: 1), curve: Curves.easeIn);
    pageController.previousPage(
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Image.asset(
          "assets/images/bblogo.png",
          height: 270,
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Stack(
            children: [
              ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  /*   decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 19, 10),
                        offset: Offset(
                          -5.0,
                          -5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xff4158D0),
                        // Color.fromARGB(255, 124, 80, 121),
                        Color(0xffffcc70)
                      ],
                    ),
                  ),*/
                  child: ClipPath(
                    clipper: CustomShapeClipper(),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: deviceWidth(context),
                        decoration: const BoxDecoration(
                            /* gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color.fromARGB(255, 155, 157, 173),
                          Color.fromARGB(255, 93, 125, 189)
                        ],
                      ),*/
                            ),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          allowImplicitScrolling: false,
                          children: [
                            PhoneNumberWidget(
                              refresh: _refresh,
                            ),
                            VerifyScreen(
                              phoneNumber: _phoneController.text,
                              goBack: goBack,
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              /* Positioned(
            bottom: 50,
            child: SizedBox(
                height: deviceHeight(context),
                width: deviceWidth(context),
                child: PageView.builder(
                  itemCount: assetsImageList.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: index == 0
                              ? 30
                              : index == 1
                                  ? 40.0
                                  : index == 2
                                      ? 50
                                      : index == 3
                                          ? 60.0
                                          : index == 4
                                              ? 70.0
                                              : index == 5
                                                  ? 80.0
                                                  : 90.0,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(assetsImageList[index]),
                                      colorFilter: ColorFilter.mode(
                                        Colors.white.withOpacity(0.4),
                                        BlendMode.modulate,
                                      ))

                                  // child: Image.asset(
                                  //   assetsImageList[index],
                                  //   colorFilter: new ColorFilter.mode(
                                  //       Colors.black.withOpacity(0.2),
                                  //       BlendMode.dstATop),
                                  )),

                          //

                          //  Container(
                          //   color: Colors.red,
                          //   // height: pageChangedIndex == index
                          //   //     ? PAGER_HEIGHT * scale
                          //   //     : 45.0,
                          //   // width: pageChangedIndex == index
                          //   //     ? PAGER_HEIGHT * scale
                          //   //     : 45.0,
                          //   child: Text('hey there'),
                          // ),
                        ),
                      ],
                    );
                  },
                  */ /*  options: CarouselOptions(
                      height: deviceHeight(context),
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, pageChangeReason) {},
                      scrollDirection: Axis.horizontal,
                    )*/ /*
                )

                // PageView.builder(

                //     itemCount: assetsImageList.length,
                //     controller: _pageController,
                //     physics: const BouncingScrollPhysics(),
                //     onPageChanged: (index) {
                //       setState(() {
                //         pageChangedIndex = index;
                //       });
                //     },
                //     itemBuilder: (context, index) {
                //       print(
                //           pageChangedIndex.toString() + '  ' + index.toString());
                //       // final scale = max(SCALE_FRACTION,
                //       //     (FULL_SCALE - (index - pageChangedIndex).abs()) + 0.2);
                //       return Stack(
                //         children: <Widget>[

                //         ],
                //       );
                //     }),
                ),
          ),*/
            ],
          ),
        ));
  }
}

TextEditingController _phoneController = TextEditingController();

class PhoneNumberWidget extends StatefulWidget {
  const PhoneNumberWidget({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;
  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  String? deviceToken;
  final formKey = GlobalKey<FormState>();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  String phoneNo = "Your number here";
  String? smsCode;

  MobileNumberPicker mobileNumber = MobileNumberPicker();
  static MobileNumber mobileNumberObject = MobileNumber();

  TextEditingController mobileNumberController = TextEditingController();
  final mobileNumberKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WidgetsBinding.instance!
          .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
      mobileNumber.getMobileNumberStream.listen((MobileNumber? event) {
        if (event?.states == PhoneNumberStates.PhoneNumberSelected) {
          setState(() {
            mobileNumberObject = event!;
            _phoneController = TextEditingController(
                text: mobileNumberObject.phoneNumber!.toString());
          });
        }
      });
    }

    super.initState();
  }

  void platform() {
    if (Platform.isAndroid) {
      WidgetsBinding.instance!
          .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
      mobileNumber.getMobileNumberStream.listen((MobileNumber? event) {
        if (event?.states == PhoneNumberStates.PhoneNumberSelected) {
          setState(() {
            mobileNumberObject = event!;
            _phoneController = TextEditingController(
                text: mobileNumberObject.phoneNumber!.toString());
          });
        }
      });
    }
  }

  verifyPhone(BuildContext context) async {
    final firebaseAuthServiceProvider =
        Provider.of<FirebaseAuthService>(context, listen: false);

    try {
      Utils.showSendingOTP(context);
      await firebaseAuthServiceProvider
          .signInWithPhoneNumberAutoVerify(
              //  "+91",
              "+91" + _phoneController.text.toString(),
              context,
              pushWidget: const GetLoginUser())
          .catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }

        Utils.showErrorDialog(context, errorMsg);
      });
      Navigator.of(context).pop();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => VerifyScreen(
      //           phoneNumber: _phoneController.text,
      //         )));
      widget.refresh();
      // pageController.nextPage(
      //     duration: const Duration(seconds: 1), curve: Curves.ease);
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight =
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom);
    return SizedBox(
      height: deviceHeight(context),
      child: SingleChildScrollView(
        padding: keyboardHeight,

        // child: ConstrainedBox(
        //   constraints: BoxConstraints(
        //     minWidth: MediaQuery.of(context).size.width,
        //     minHeight: MediaQuery.of(context).size.height,
        //   ),
        //   child: IntrinsicHeight(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.max,
        //       children: <Widget>[
        //         // CONTENT HERE
        //       ],
        //     ),
        //   ),
        // ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(
                      //   'Login',
                      //   style: PhoneVerificationStyles.loginTextStyle(),
                      //   textAlign: TextAlign.center,
                      // ),
                      // const SizedBox(
                      //   height: 50,
                      // ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     SizedBox(
                      //       width: deviceWidth(context) * 0.8,
                      //       child: Form(
                      //           key: _phoneVerificationKey,
                      //           child: TextFormField(
                      //             controller: _phoneController,
                      //             keyboardType: TextInputType.emailAddress,
                      //             decoration: InputDecoration(
                      //               fillColor: Colors.white,
                      //               hintText: "  E-mail / Username  ",
                      //               contentPadding: const EdgeInsets.only(
                      //                   left: 1, top: 1, right: 1, bottom: 1),
                      //               hintStyle:
                      //                   PhoneVerificationStyles.textFieldStyle(),
                      //               filled: true,
                      //               prefixIcon: Icon(
                      //                 FontAwesomeIcons.user,
                      //                 color: Colors.brown[200],
                      //                 size: 20,
                      //               ),
                      //               border: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(12),
                      //               ),
                      //             ),
                      //             validator: (value) {
                      //               String pattern =
                      //                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      //               RegExp regex = RegExp(pattern);
                      //               if (!regex.hasMatch(value!)) {
                      //                 return "Enter Valid email";
                      //               }
                      //               return null;
                      //             },
                      //           )),
                      //     ),
                      //     const SizedBox(
                      //       height: 14,
                      //     ),
                      //     SizedBox(
                      //       width: deviceWidth(context) * 0.8,
                      //       child: Form(
                      //           key: _passwordKey,
                      //           child: TextFormField(
                      //             obscureText: _obscureText,
                      //             controller: _passwordController,
                      //             keyboardType: TextInputType.visiblePassword,
                      //             decoration: InputDecoration(
                      //               suffixIcon: IconButton(
                      //                 icon: _obscureText
                      //                     ? const Icon(
                      //                         FontAwesomeIcons.eye,
                      //                         size: 15,
                      //                       )
                      //                     : const Icon(
                      //                         FontAwesomeIcons.eyeSlash,
                      //                         size: 15,
                      //                       ),
                      //                 onPressed: () {
                      //                   setState(() {
                      //                     _obscureText = !_obscureText;
                      //                   });
                      //                 },
                      //               ),
                      //               hintText: "Password",
                      //               fillColor: Colors.white,
                      //               hintStyle:
                      //                   PhoneVerificationStyles.textFieldStyle(),
                      //               contentPadding: const EdgeInsets.only(
                      //                   left: 1, top: 1, right: 1, bottom: 1),
                      //               // labelStyle: PhoneVerificationStyles
                      //               //     .textFieldStyle(),
                      //               // labelText: "   Password   ",
                      //               filled: true,
                      //               prefixIcon: Icon(
                      //                 FontAwesomeIcons.lock,
                      //                 color: Colors.brown[200],
                      //                 size: 20,
                      //               ),
                      //               border: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(12),
                      //               ),
                      //             ),
                      //             validator: (value) {
                      //               if (value!.length < 4) {
                      //                 return "Password Invalid";
                      //               }
                      //               return null;
                      //             },
                      //           )),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, left: 10.0),
                            child: Utils.dividerThin(),
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              "Login or Sign Up",
                              style: CommonStyles.blueBold14(),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Utils.dividerThin(),
                          )),
                        ],
                      ),
                      Utils.getSizedBox(height: 15),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.5, bottom: 5.5, right: 5.5, left: 8),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  depth: -50,
                                  intensity: 40,
                                  surfaceIntensity: 0.50,
                                  shadowLightColor: Colors.transparent,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(10)),
                                  color: Colors.blue),
                              child: Container(
                                /*decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),*/
                                child: Padding(
                                  padding: const EdgeInsets.all(3.4),
                                  child: CountryCodePicker(
                                    onChanged: print,

                                    textStyle: CommonStyles.textDataWhite13(),
                                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                    initialSelection: 'IN',
                                    favorite: const ['+91', 'IN'],
                                    // optional. Shows only country name and flag
                                    showCountryOnly: false,
                                    // optional. Shows only country name and flag when popup is closed.
                                    showOnlyCountryWhenClosed: false,

                                    // optional. aligns the flag and the Text left
                                    alignLeft: false,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Expanded(
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.convex,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    depth: 8,
                                    lightSource: LightSource.topLeft,
                                    color: Colors.blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: TextFormField(
                                    autofocus: true,
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    cursorColor: Colors.black,
                                    validator: (value) {
                                      if (value!.length < 10 ||
                                          value.length > 10) {
                                        return "Please Enter Valid Number";
                                      }
                                      return null;
                                    },
                                    style:
                                        CommonStyles.textDataWhite13Spacing(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                              minHeight: 0, minWidth: 0),
                                      // prefixText: "+91",
                                      hintText: "Enter Phone Number",
                                      errorStyle:
                                          CommonStyles.textDataWhite12Bold(),
                                      hintStyle: CommonStyles.textDataWhite13(),
                                      // labelStyle: TextStyle(color: Colors.black),
                                      prefixStyle: CommonStyles.black12(),
                                      counterText: "",
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //     color: Colors.orange[600]!,
                                      //   ),
                                      // ),
                                      // prefix: Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       right: 6.0, bottom: 3),
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     children: [
                                      //       Text(
                                      //         "+91",
                                      //         style: CommonStyles.black12(),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      // focusedBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //     color: Colors.orange[900]!,
                                      //   ),
                                      // ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                      // fillColor: Colors.white,
                                      // filled: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              elevation: 2,
                              clipBehavior: Clip.antiAlias,
                              minWidth: deviceWidth(context) * 0.93,
                              height: 45,
                              color: Colors.blue,
                              child: Text('Login',
                                  style: CommonStyles.whiteText15BoldW500()),
                              onPressed: () {
                                print("Number is ----- - - - - " +
                                    _phoneController.text);
                                if (formKey.currentState!.validate()) {
                                  // print("isvalied");
                                  verifyPhone(context);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Utils.getSizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Utils.dividerThin(),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
