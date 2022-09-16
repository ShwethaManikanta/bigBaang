import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/service/forget_change_password_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../CommonWidgets/common_styles.dart';
import '../../CommonWidgets/loading_widget.dart';

class ForgortPassword extends StatefulWidget {
  const ForgortPassword({Key? key}) : super(key: key);

  @override
  _ForgortPasswordState createState() => _ForgortPasswordState();
}

class _ForgortPasswordState extends State<ForgortPassword> {
  final phoneNumberController = TextEditingController();
  final phoneNumberKey = GlobalKey<FormState>();
  final newPassowrdController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordKey = GlobalKey<FormState>();
  final confirmPasswordKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final otpKey = GlobalKey<FormState>();

  bool _isOtpSent = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final forgetPasswordApiProvider =
        Provider.of<ForgetPasswordAPIProvider>(context);
    final changePasswordApiProvider =
        Provider.of<ChangePasswordAPIProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.getSizedBox(height: 150),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Mobile Number".toUpperCase(),
                  style: TextStyle(
                      color: Colors.yellow[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Utils.getSizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: phoneNumberKey,
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty || value.length != 10) {
                        return "Provide Valid Phone Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Mobile Number",
                      hintStyle: const TextStyle(color: Colors.black26),
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[600]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[900]!,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                    ),
                  ),
                ),
              ),
              Utils.getSizedBox(height: 25),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (phoneNumberKey.currentState!.validate()) {
                      print("sent request to phoneNumber" +
                          phoneNumberController.text);
                      showLoadingWithCustomText(
                          context, "Sending OTP Please Wait!");
                      await forgetPasswordApiProvider.forgetPasswordRequest(
                          "+91 " + phoneNumberController.text);
                      if (forgetPasswordApiProvider.error) {
                        print("The error messag e---------" +
                            forgetPasswordApiProvider.errorMessage);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Something went wrong!!",
                              style: CommonStyles.textDataWhite13(),
                            )));
                      } else if (forgetPasswordApiProvider
                              .forgetPasswordResponse!.status ==
                          '0') {
                        Navigator.of(context).pop();
                        showErrorMessage(
                            context,
                            forgetPasswordApiProvider
                                .forgetPasswordResponse!.message, () {
                          Navigator.of(context).pop();
                        });
                      } else {
                        Navigator.of(context).pop();
                        setState(() {
                          _isOtpSent = true;
                        });
                      }
                    }
                  },
                  child: const Text("Get OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellow[900]!),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ),
              ),
              Utils.getSizedBox(height: 25),
              Visibility(
                  visible: _isOtpSent,
                  child: Center(
                    child: Text(
                      "Otp has been SMS to your Registered Mobile Number.",
                      style: CommonStyles.textw400BlueS14(),
                    ),
                  )),
              Utils.getSizedBox(height: 25),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Enter OTP".toUpperCase(),
                  style: TextStyle(
                      color: Colors.yellow[900]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Utils.getSizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: otpKey,
                  child: TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (!_isOtpSent) {
                        return ' OTP not yet send. ';
                      }
                      if (_isOtpSent) {
                        if (forgetPasswordApiProvider.forgetPasswordResponse !=
                            null) {
                          if (value!.isEmpty ||
                              value.length < 4 ||
                              value.toString() !=
                                  forgetPasswordApiProvider
                                      .forgetPasswordResponse!.otp) {
                            return 'Please Enter Valid OTP.';
                          }
                        }
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please Enter Valid OTP.';
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your One Time Password",
                      hintStyle: const TextStyle(color: Colors.black26),
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[600]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[900]!,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                    ),
                  ),
                ),
              ),
              Utils.getSizedBox(height: 25),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Password".toUpperCase(),
                  style: TextStyle(
                      color: Colors.yellow[900]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Utils.getSizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: newPasswordKey,
                  child: TextFormField(
                    controller: newPassowrdController,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return "Password Length Minimum 5";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      hintStyle: const TextStyle(color: Colors.black26),
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[600]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[900]!,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? const Icon(
                                FontAwesomeIcons.eye,
                                size: 15,
                                color: Colors.blue,
                              )
                            : const Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 15,
                              ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Utils.getSizedBox(height: 25),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Confirm Password".toUpperCase(),
                  style: TextStyle(
                      color: Colors.yellow[900]!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Utils.getSizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: confirmPasswordKey,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return "Password Length Minimum 5";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      hintStyle: const TextStyle(color: Colors.black26),
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[600]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow[900]!,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? const Icon(
                                FontAwesomeIcons.eye,
                                size: 15,
                                color: Colors.blue,
                              )
                            : const Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 15,
                              ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Utils.getSizedBox(height: 25),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (otpKey.currentState!.validate() &&
                        confirmPasswordKey.currentState!.validate() &&
                        newPasswordKey.currentState!.validate()) {
                      showLoadingWithCustomText(
                          context, "Changing Your Password!");
                      await changePasswordApiProvider.changePasswordRequest(
                          forgetPasswordApiProvider
                              .forgetPasswordResponse!.userId,
                          newPassowrdController.text);
                      if (changePasswordApiProvider
                              .changePasswordResponse!.status ==
                          "1") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Successfully Changed Password!",
                              style: CommonStyles.textDataWhite13(),
                            )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Oops! Something Went Wrong!",
                              style: CommonStyles.textDataWhite13(),
                            )));
                      }
                      Navigator.of(context).pop();

                      otpController.clear();
                      newPassowrdController.clear();
                      phoneNumberController.clear();
                      confirmPasswordController.clear();
                      setState(() {
                        _isOtpSent = false;
                      });
                    }
                  },
                  child: const Text("Reset",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellow[900]!),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ),
              ),
              Utils.getSizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Remember Password? ",
                      style: TextStyle(
                        color: Colors.yellow[900]!,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Utils.getSizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Go Back",
                        style: TextStyle(
                            color: Colors.yellow[900],
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Utils.getSizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
