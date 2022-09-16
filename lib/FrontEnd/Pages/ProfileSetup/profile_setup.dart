import 'dart:io';

import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/loading_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/Models/image_upload_response_model.dart';
import 'package:bigbaang/Models/signup_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/pick_image_provider.dart';
import 'package:bigbaang/service/signup_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String? mobileNumber;

  const ProfileSetupScreen({Key? key, this.mobileNumber}) : super(key: key);

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final mobileNumFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileNumController = TextEditingController();
  final emailController = TextEditingController();

  File holdImageFile = File('');
  @override
  Widget build(BuildContext context) {
    final signUpApiProvider = Provider.of<SignupAPIProvider>(context);

    final imagePickProvider =
        Provider.of<ImagePickerService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
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
                          child: Neumorphic(
                            padding: EdgeInsets.all(20),
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              depth: NeumorphicTheme.embossDepth(context),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 130,
                                width: 130,
                                /*  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black54)),*/
                                child: const Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.indigo,
                                  size: 24,
                                ),
                              ),
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
                          child: Neumorphic(
                            padding: EdgeInsets.all(20),
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              depth: NeumorphicTheme.embossDepth(context),
                            ),
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(holdImageFile))),
                            ),
                          ),
                        ),
                      ),
                Utils.getSizedBox(height: 25),
                Utils.getSizedBox(height: 20),
                Neumorphic(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
                  style: NeumorphicStyle(
                    intensity: 30,
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Form(
                    key: nameFormKey,
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      // onChanged: this.widget.onChanged,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return "Please Enter Valid Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        //   enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        //       disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.indigo,
                          size: 20,
                        ),
                        counterText: "",
                        hintText: "   Enter  Name",
                      ),
                      style: CommonStyles.blackBold12(),
                    ),
                  ),
                ),
                Utils.getSizedBox(height: 20),
                Neumorphic(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
                  style: NeumorphicStyle(
                    intensity: 30,
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Form(
                    key: mobileNumFormKey,
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      // onChanged: this.widget.onChanged,
                      controller: mobileNumController,
                      validator: (value) {
                        if (value!.isEmpty || value.length != 10) {
                          return "Enter 10 digit phone number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        //   enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        //       disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.indigo,
                          size: 20,
                        ),
                        counterText: "",
                        hintText: "   Enter Mobile Number",
                      ),
                      style: CommonStyles.blackBold12(),
                    ),
                  ),
                ),
                Utils.getSizedBox(height: 20),
                Neumorphic(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
                  style: NeumorphicStyle(
                    intensity: 30,
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Form(
                    key: emailFormKey,
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      // onChanged: this.widget.onChanged,
                      controller: emailController,
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
                        //   enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        //       disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.indigo,
                          size: 20,
                        ),
                        counterText: "",
                        hintText: "   Enter  E Mail",
                      ),
                      style: CommonStyles.blackBold12(),
                    ),
                  ),
                ),
                Utils.getSizedBox(height: 70),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                          emailFormKey.currentState!.validate()) {
                        SignUpRequestModel signUpRequest = SignUpRequestModel(
                            customerName: nameController.text,
                            mobile: '+91 ' + mobileNumController.text,
                            email: emailController.text,
                            password: "password",
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
                          holdImageFile = File('');
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text("Update",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.indigo),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        )),
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
