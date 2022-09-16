import 'package:avatar_glow/avatar_glow.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_text_form_fields.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/loading_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/phoneVerification/phone_verification.dart';
import 'package:bigbaang/FrontEnd/Pages/customer_service.dart';
import 'package:bigbaang/FrontEnd/Pages/my_order_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/notification_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/payment_screen.dart';
import 'package:bigbaang/Models/profile_model.dart';
import 'package:bigbaang/backend/service/firebase_auth_service.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/login_provider.dart';
import 'package:bigbaang/service/profile_api_provider.dart';
import 'package:bigbaang/widgets/current_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../CommonWidgets/drawer_widget.dart';
import '../CommonWidgets/screen_width_and_height.dart';
import 'HomePage/styles/home_page_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;

  final nameKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final emailKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final phoneNumberKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();

  bool edit = false;

  Future getProfile() async {
    if (context.read<ProfileApiProvder>().profileModel == null) {
      context.read<ProfileApiProvder>().fetchProfileDetails().then((value) {
        nameController.text = context
            .read<ProfileApiProvder>()
            .profileModel!
            .userDetails!
            .username;
        emailController.text =
            context.read<ProfileApiProvder>().profileModel!.userDetails!.email;
        phoneNumberController.text = context
            .read<ProfileApiProvder>()
            .profileModel!
            .userDetails!
            .mobileNo;
      });
    } else {
      nameController.text =
          context.read<ProfileApiProvder>().profileModel!.userDetails!.username;
      emailController.text =
          context.read<ProfileApiProvder>().profileModel!.userDetails!.email;
      print("----------------------" +
          context
              .read<ProfileApiProvder>()
              .profileModel!
              .userDetails!
              .mobileNo
              .split(" ")
              .last);
      phoneNumberController.text = context
          .read<ProfileApiProvder>()
          .profileModel!
          .userDetails!
          .mobileNo
          .split(" ")
          .last;
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileApiProvider = Provider.of<ProfileApiProvder>(context);
    final profileUpdateAPIProvider =
        Provider.of<ProfileUpdateApiProvder>(context);
    final sharedPreferencesProvider =
        Provider.of<SharedPreferencesProvider>(context);
    return Scaffold(
      appBar: appBarProfilePage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            profileApiProvider.ifLoading
                ? Container(
                    height: 200,
                    width: deviceWidth(context),
                    color: Colors.deepPurple,
                    child: const Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    ),
                  )
                : Card(
                    color: Colors.indigo,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: /*profileApiProvider.profileModel!
                                          .userDetails!.profileImage.isNotEmpty
                                      ? Hero(
                                          tag: "ProfilePicture",
                                          child: circularCachedNetworkImage(
                                            height: 80,
                                            width: 80,
                                            imageUrl: profileApiProvider
                                                    .profileModel!
                                                    .profileBaseurl! +
                                                profileApiProvider.profileModel!
                                                    .userDetails!.profileImage,
                                          ),
                                        )
                                      :*/
                                      Image.asset(
                                    "assets/images/bblogo.png",
                                    height: 80,
                                    width: 100,
                                  ),
                                ),
                                Utils.getSizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        NameTextForm(
                                            nameController: nameController,
                                            nameKey: nameKey,
                                            edit: edit),
                                        EmailTextForm(
                                            emailController: emailController,
                                            emailKey: emailKey,
                                            edit: edit),
                                        MobileNoTextField(
                                            enabled: edit,
                                            mobileController:
                                                phoneNumberController,
                                            mobileKey: phoneNumberKey),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        edit = !edit;
                                      });
                                      print(edit);
                                      if (!edit) {
                                        print("----" + edit.toString());
                                        print(nameKey.currentState!
                                            .validate()
                                            .toString());
                                        print(emailKey.currentState!
                                            .validate()
                                            .toString());
                                        print(phoneNumberKey.currentState!
                                            .validate()
                                            .toString());
                                        if (nameKey.currentState!.validate() &&
                                            emailKey.currentState!.validate() &&
                                            phoneNumberKey.currentState!
                                                .validate()) {
                                          print("Validating  --------------");
                                          if (nameController.text !=
                                                  profileApiProvider
                                                      .profileModel!
                                                      .userDetails!
                                                      .username ||
                                              emailController.text !=
                                                  profileApiProvider
                                                      .profileModel!
                                                      .userDetails!
                                                      .email ||
                                              phoneNumberController.text !=
                                                  profileApiProvider
                                                      .profileModel!
                                                      .userDetails!
                                                      .mobileNo) {
                                            print("Loading");
                                            showLoading(context);
                                            await profileUpdateAPIProvider
                                                .updateProfileDetails(
                                                    ProfileUpdateRequestModel(
                                                        userId:
                                                            ApiService.userID!,
                                                        email: emailController
                                                            .text,
                                                        customerName:
                                                            nameController.text,
                                                        mobile:
                                                            phoneNumberController
                                                                .text,
                                                        profileImage: "1es",
                                                        deviceToken:
                                                            "deviceToken"));
                                            Navigator.of(context).pop();

                                            if (profileUpdateAPIProvider
                                                .error) {
                                              Utils.getFloatingSnackBar(
                                                  context: context,
                                                  snackBarText:
                                                      profileUpdateAPIProvider
                                                          .errorMessage);
                                            } else {
                                              Utils.getFloatingSnackBar(
                                                  context: context,
                                                  snackBarText:
                                                      profileUpdateAPIProvider
                                                          .profileUpdateResponse!
                                                          .message);
                                              profileApiProvider
                                                  .fetchProfileDetails();
                                            }
                                          }
                                        }
                                      }
                                    },
                                    icon: !edit
                                        ? Icon(
                                            Icons.edit,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.check,
                                            size: 30,
                                            color: Colors.white,
                                          )),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Colors.white),
                          Utils.getSizedBox(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Address",
                                style: CommonStyles.textDataWhite10Bold(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SizedBox(
                                      width: 150,
                                      child: Text(
                                        profileApiProvider
                                            .profileModel!.userDetails!.address,
                                        style: CommonStyles.textDataWhite12Bold(),
                                      ),
                                    ),
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: MaterialButton(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        color: const Color.fromARGB(
                                            255, 167, 22, 155),
                                        onPressed: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8))),
                                              builder: (_) {
                                                return const BottomSheetAddLocation();
                                              });
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) => PlacePickGoogleMaps()));
                                        },
                                        child: profileApiProvider
                                                    .profileModel!
                                                    .userDetails!
                                                    .selectedAddress ==
                                                "0"
                                            ? Text(
                                                "Select Address",
                                                style: CommonStyles
                                                    .textDataWhite12Bold(),
                                              )
                                            : Text(
                                                "Change",
                                                style: CommonStyles
                                                    .textDataWhite12Bold(),
                                              )),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            Utils.getSizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: List.generate(
                  title.length,
                  (index) => Column(
                    children: [
                      NeumorphicButton(
                        pressed: true,
                        onPressed: () {
                          if (index == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyOrderScreen()));
                          }
                          /*  if (index == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentScreen()));
                          }*/

                          if (index == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                          }

                          if (index == 2) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CustomerService(
                                      userName: profileApiProvider
                                          .profileModel!.userDetails!.username,
                                    )));
                          }

                          /*if (index == 4) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyLocation()));
                          }*/

                          if (index == 3) {
                            showAlertDialog(context, sharedPreferencesProvider);
                          }
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        style: NeumorphicStyle(
                            intensity: 10,
                            depth: 5,
                            color: Colors.white,
                            shadowLightColor: Colors.indigo),
                        child: Row(
                          children: [
                            AvatarGlow(
                              endRadius: 20,
                              glowColor: Colors.lightBlue,
                              child: Icon(
                                icons[index],
                                size: 25,
                                color: Colors.indigo,
                              ),
                            ),
                            Utils.getSizedBox(width: 10),
                            Text(
                              title[index],
                              style: CommonStyles.blackText14BoldW500(),
                            ),
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 20),
                      Utils.getSizedBox(height: 5)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBarProfilePage() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        width: deviceWidth(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, 1),
            end: Alignment(1, -1),
            colors: <Color>[
              Color(0xff4158D0),
              Color(0xff4158D0),
              Color(0xff4158D0),
              /*  Color(0xffc850c0),
              Color(0xffffcc70)*/
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      "Profile",
                      style: HomePageStyles.loginTextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  List<String> title = [
    "My Orders",
    "Notification",
    "Customer Service",
    "Logout"
  ];
  List<IconData> icons = [
    Icons.star_border,
    Icons.payment_rounded,
    Icons.notifications_active,
    Icons.logout
  ];
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
      showLoadDialog(context);
      await firebaseAuthService.signOut();
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Big Baang", style: CommonStyles.blueBold14()),
    content: Text("Do you want to Logout ?",
        style: CommonStyles.blackText14BoldW500()),
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
