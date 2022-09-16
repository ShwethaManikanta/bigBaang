import 'dart:io';

import 'package:bigbaang/FrontEnd/CommonWidgets/loading_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/Models/image_upload_response_model.dart';
import 'package:bigbaang/Models/signup_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/pick_image_provider.dart';
import 'package:bigbaang/service/signup_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../CommonWidgets/screen_width_and_height.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageState1 createState() {
    return SignupPageState1();
  }
}

class SignupPageState1 extends State<SignupPage> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final nameFormKey = GlobalKey<FormState>();
  final mobileNumFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confrimPasswordFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileNumController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimPasswordController = TextEditingController();

  File holdImageFile = File('');

  @override
  Widget build(BuildContext context) {
    final signUpApiProvider = Provider.of<SignupAPIProvider>(context);
    final imagePickProvider =
        Provider.of<ImagePickerService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: deviceWidth(context),
            child: Column(
              // physics: const BouncingScrollPhysics(),
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                holdImageFile.path == File('').path
                    ? GestureDetector(
                        onTap: () async {
                          holdImageFile =
                              await imagePickProvider.chooseImageFile(context);
                          setState(() {});
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black54)),
                            child: const Icon(
                              FontAwesomeIcons.camera,
                              color: Colors.black54,
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          holdImageFile =
                              await imagePickProvider.chooseImageFile(context);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(holdImageFile))),
                          ),
                        ),
                      ),
                Utils.getSizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "User Name".toUpperCase(),
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
                    key: nameFormKey,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return "Please Enter Valid Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Your Name",
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
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
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
                    key: mobileNumFormKey,
                    child: TextFormField(
                      controller: mobileNumController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || value.length != 10) {
                          return "Enter 10 digit phone number";
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: "",
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
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Email".toUpperCase(),
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
                    key: emailFormKey,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value!)) {
                          return "Enter Valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
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
                    key: passwordFormKey,
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      cursorColor: Colors.black,
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
                                  color: Colors.blue,
                                  size: 15,
                                )
                              : const Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  color: Colors.black54,
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
                    key: confrimPasswordFormKey,
                    child: TextFormField(
                      controller: confrimPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (passwordController.text != value!) {
                          return "Please Confirm your Password Again";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Your Password",
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
                                  color: Colors.blue,
                                  size: 15,
                                )
                              : const Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  color: Colors.black54,
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
                Utils.getSizedBox(height: 30),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      showLoading(context);
                      ImageResponse? imageUploadResponse;
                      if (holdImageFile.path != File('').path) {
                        ImageUploadModel imageUploadModel = ImageUploadModel(
                            fileName: holdImageFile, fileType: "profile");

                        imageUploadResponse =
                            await apiServices.uploadImages(imageUploadModel);
                      }
                      if (nameFormKey.currentState!.validate() &&
                          mobileNumFormKey.currentState!.validate() &&
                          emailFormKey.currentState!.validate() &&
                          passwordFormKey.currentState!.validate() &&
                          confrimPasswordFormKey.currentState!.validate()) {
                        SignUpRequestModel signUpRequest = SignUpRequestModel(
                            customerName: nameController.text,
                            mobile: '+91 ' + mobileNumController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            deviceType: "customer_app",
                            deviceToken: "25526ewyhsudrye8246dyshx",
                            profileImage: imageUploadResponse == null
                                ? ""
                                : imageUploadResponse.fileName);

                        await signUpApiProvider.fetchSignUp(signUpRequest);

                        if (signUpApiProvider.error) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Something Went Wrong!")));
                        } else if (signUpApiProvider.error == false &&
                            signUpApiProvider.signUpResponseModel!.status ==
                                "0") {
                          Navigator.of(context).pop();
                          showErrorMessage(context,
                              signUpApiProvider.signUpResponseModel!.message,
                              () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Registration Successful ${nameController.text} ")));
                          nameController.clear();
                          emailController.clear();
                          mobileNumController.clear();
                          passwordController.clear();
                          confrimPasswordController.clear();
                          holdImageFile = File('');
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text("Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.yellow[900]!),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ),
                ),
                Utils.getSizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.yellow[900],
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
                      child: Text("Log In",
                          style: TextStyle(
                              color: Colors.yellow[900],
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                // Utils.getSizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
