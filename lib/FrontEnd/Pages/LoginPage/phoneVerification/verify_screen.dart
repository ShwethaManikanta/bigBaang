import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../backend/service/firebase_auth_service.dart';
import '../../../../main.dart';
import '../../../CommonWidgets/common_buttons.dart';
import '../../../CommonWidgets/common_styles.dart';
import '../../../CommonWidgets/screen_width_and_height.dart';
import '../../../CommonWidgets/utils.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  final Function goBack;

  const VerifyScreen(
      {required this.phoneNumber, Key? key, required this.goBack})
      : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final controller = TextEditingController();
  final key = GlobalKey<FormState>();

  // String _comingSms = 'Unknown';

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    _listenOTP();

    super.initState();
  }

  _listenOTP() async {
    await SmsAutoFill().listenForCode();
    // final signature = await SmsAutoFill().getAppSignature;
    // print("The app signature is  - - -- - - - " + signature);
  }

  showSnackBar(msg, color, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: color,
      ),
    );
  }

  String _code = "";
  String signature = "{{ app signature }}";

  Future verifyOTP(BuildContext context) async {
    print("verify otp called");
    try {
      await Provider.of<FirebaseAuthService>(context, listen: false)
          .verifyOTP(controller.text.toString())
          .then((_) async {
        // Utils.showLoaderDialog(context);
        // final loggedInUser = Provider.of<LoggedInUser>(context, listen: false);
        // await Provider.of<VerifyUserLoginAPIProvider>(context)
        //     .getUser(
        //         deviceToken: "device_token",
        //         userFirebaseID: loggedInUser.uid,
        //         phoneNumber: "")
        //     .then((value) async {
        // await Provider.of<SharedPreferencesProvider>(context)
        //     .setUserId(
        //         userId: Provider.of<VerifyUserLoginAPIProvider>(context)
        //             .loginResponse!
        //             .driverDetails!
        //             .id!)
        //     .then((value) async {
        // Navigator.of(context).pop();
        // await Provider.of<SharedPreferencesProvider>(context, listen: false)
        //     .getUserId()
        //     .then(
        //         (value) => print("The suer Id --- - - - - - - - -" + value));

        // }).catchError((e) {
        //   String errorMsg = "";
        //   if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
        //     errorMsg = "Session expired, please resend OTP!";
        //   } else if (e
        //       .toString()
        //       .contains("ERROR_INVALID_VERIFICATION_CODE")) {
        //     errorMsg = "You have entered wrong OTP!";
        //   }
        //   Utils.showErrorDialog(context, errorMsg);
        // });
        // })

        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const GetLoginUser()));

        // .catchError((e) {
        //   String errorMsg = "Vefirying User Failed!";
        //   if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
        //     errorMsg = "Session expired, please resend OTP!";
        //   } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
        //     errorMsg = "You have entered wrong OTP!";
        //   }
        //   Utils.showErrorDialog(context, errorMsg);
        // });
      }).catchError((e) {
        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        Utils.showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // appBar: AppBar(
    //   backgroundColor: Colors.transparent,
    //   foregroundColor: Colors.transparent,
    //   elevation: 0,
    //   leading: Row(
    //     children: [
    //       SizedBox(
    //         height: 50,
    //         width: 50,
    //         child: InkWell(
    //           onTap: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Icon(
    //             FontAwesomeIcons.arrowLeft,
    //             color: Colors.black,
    //           ),
    //         ),
    //       )
    //     ],
    //     mainAxisSize: MainAxisSize.min,
    //   ),
    //   title: Text(
    //     "OTP Verification",
    //     style: CommonStyles.blackw54s20Thin(),
    //   ),
    // ),
    return WillPopScope(
      onWillPop: () async {
        widget.goBack();
        return false;
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 4),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.goBack();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Utils.getSizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("We have sent a verification code to",
                          style: CommonStyles.otpVerificationMessage()),
                      Text(
                        "+91 ${widget.phoneNumber}",
                        style: CommonStyles.otpVerificationMessage(),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Utils.getSizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: PinFieldAutoFill(
                    decoration: UnderlineDecoration(
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                        gapSpace: 10),
                    currentCode: _code,
                    onCodeSubmitted: (code) async {
                      verifyOTP(context);
                    },
                    onCodeChanged: (code) {
                      print(code);
                      controller.text = code.toString();
                      print(controller.text);
                      if (code!.length == 6) {
                        // FocusScope.of(context).requestFocus(FocusNode());
                        // verifyOTP(context);
                      }
                    },
                  ),
                ),
                Utils.getSizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ResendOTPStateful(
                      phoneNumber: widget.phoneNumber,
                    )
                  ],
                ),
                Utils.getSizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: RoundedButton(
                    title: 'Verify OTP',
                    onpressed: () async {
                      verifyOTP(context);
                    },
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

class ResendOTPStateful extends StatefulWidget {
  const ResendOTPStateful({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  @override
  _ResendOTPStatefulState createState() => _ResendOTPStatefulState();
}

class _ResendOTPStatefulState extends State<ResendOTPStateful> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  Timer? _timer;
  int _start = 45;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextButton(
          onPressed: _start != 0
              ? () {
                  context.read<FirebaseAuthService>().signInWithPhoneNumber(
                      "+91", "+91" + widget.phoneNumber, context);
                }
              : () {
                  Utils.showSnackBar(
                      context: context,
                      text: "Please wait for process to complete.");
                },
          child: _start != 0
              ? Text(
                  'Resend OTP in ' + _start.toString(),
                  style: CommonStyles.textDataWhite12Bold(),
                )
              : Text(
                  "Resend OTP",
                  style: CommonStyles.textDataWhite12Bold(),
                )),
    );
  }
}

// class VerifyScreen extends StatefulWidget {
//   const VerifyScreen({Key? key}) : super(key: key);
//   @override
//   VerifyScreenState createState() => VerifyScreenState();
// }

// class VerifyScreenState extends State<VerifyScreen> {
//   final controller = TextEditingController();
//   final key = GlobalKey<FormState>();

//   showSnackBar(msg, color, context) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(
//         msg,
//         style: const TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       duration: const Duration(seconds: 2),
//       behavior: SnackBarBehavior.floating,
//       elevation: 3.0,
//       backgroundColor: color,
//     ));
//   }

//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text(
//           'Error Occured',
//           style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
//         ),
//         content: Text(
//           message,
//           style: PhoneVerificationStyles.errorTextStyleStyle(),
//         ),
//         actions: <Widget>[
//           OutlinedButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: const Text('OK!'),
//           )
//         ],
//       ),
//     );
//   }

//   // verifyOTP(BuildContext context) {
//   //   try {
//   //     Provider.of<FirebaseAuthService>(context, listen: false)
//   //         .verifyOTP(controller.text.toString())
//   //         .then((_) {
//   //       Navigator.of(context)
//   //           .push(MaterialPageRoute(builder: (context) => HomePage()));
//   //     }).catchError((e) {
//   //       String errorMsg = 'Cant authentiate you Right now, Try again later!';
//   //       if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
//   //         errorMsg = "Session expired, please resend OTP!";
//   //       } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
//   //         errorMsg = "You have entered wrong OTP!";
//   //       }
//   //       _showErrorDialog(context, errorMsg);
//   //     });
//   //   } catch (e) {
//   //     _showErrorDialog(context, e.toString());
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Align(
//               //     alignment: Alignment.centerLeft,
//               //     child: Padding(
//               //       padding: const EdgeInsets.all(10.0),
//               //       child: Text(
//               //         'PickUp',
//               //         style: Theme.of(context).textTheme.headline6,
//               //       ),
//               //     )),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.33,
//                 alignment: Alignment.centerLeft,
//                 padding: const EdgeInsets.all(15),
//                 child: Text(
//                   'Please enter your password',
//                   style: PhoneVerificationStyles.enterYourNumberTextStyle(),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Form(
//                   key: key,
//                   child: UserTextField(
//                     titleLabel: 'Password',
//                     icon: Icons.dialpad,
//                     controller: controller,
//                     inputType: TextInputType.phone,
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: roundedButtonRadius30(
//                   context: context,
//                   widget: HomeBottomScreen(),
//                   title: 'Verify Password',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
