import 'package:avatar_glow/avatar_glow.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/my_order_screen.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerService extends StatefulWidget {
  final String userName;
  CustomerService({required this.userName});
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final descriptiomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarProductPage(
                scaffoldKey: scaffoldKey,
                appBartext: "Customer Service",
                onlySearch: true,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Hii , How can we help You .. !!",
                        style: CommonStyles.blueBold14(),
                      ),
                    ),
                    Utils.getSizedBox(height: 20),
                    CachedNetworkImage(
                      imageUrl:
                          "https://bzolutions.com/wp-content/uploads/2019/07/contactus.gif",
                      height: 110,
                    ),
                    Utils.getSizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Center(
                            child: Text(
                              "Please write to us for any queries",
                              style: CommonStyles.greenBold(),
                            ),
                          ),
                          Utils.getSizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: titleController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  label: Text(
                                "Title",
                                style: CommonStyles.blueBold12(),
                              )),
                              style: CommonStyles.blackBold12(),
                            ),
                          ),
                          Utils.getSizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: descriptiomController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  label: Text(
                                "Description",
                                style: CommonStyles.blueBold12(),
                              )),
                              style: CommonStyles.blackBold12(),
                            ),
                          ),
                          Utils.getSizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: 80),
                              /* onPressed: () async {
                                await apiService
                                    .getSupport(titleController.text,
                                    descriptiomController.text)
                                    .then((value) => _supportModel = value!);
                                print("Order Placed ---- " +
                                    _supportModel.message.toString() +
                                    _supportModel.status.toString());

                                if (_supportModel.status == "1") {
                                  Utils.showSnackBar(
                                      context: context,
                                      text: "${_supportModel.message.toString()}");
                                }
                                if (_supportModel.status == "0") {
                                  Navigator.of(context).pop();
                                  Utils.showSnackBar(
                                      context: context,
                                      text: "${_supportModel.message.toString()}");
                                }
                              },*/
                              elevation: 20,
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: CommonStyles.greenBold(),
                                ),
                              ),
                            ),
                          ),
                          Utils.getSizedBox(height: 50),
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Text("Address",
                                      style: CommonStyles.blueBold12()),
                                  Utils.getSizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 18,
                                              color: Colors.indigo,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "West Cross Road, Veena Complex, Basawaeshwara Nagar, Bangalore",
                                                style:
                                                    CommonStyles.blackBold12(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              openMap(double.parse("72.67654"),
                                                  double.parse("12.4556756"));
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Direction From Map",
                                                style: CommonStyles.greenBold(),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              AvatarGlow(
                                                endRadius: 20,
                                                glowColor: Colors.indigo,
                                                child: Icon(
                                                  Icons.directions,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Utils.getSizedBox(height: 20),
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Text("E-Mail Contact",
                                      style: CommonStyles.blueBold12()),
                                  Utils.getSizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mail,
                                              size: 18,
                                              color: Colors.indigo,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "bigbaang@gmail.com",
                                              style: CommonStyles.blackBold12(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _launchEmail("service@gmail.com");
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Send to Mail ",
                                                style: CommonStyles.greenBold(),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              AvatarGlow(
                                                endRadius: 20,
                                                glowColor: Colors.indigo,
                                                child: Icon(
                                                  Icons.outgoing_mail,
                                                  size: 20,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Utils.getSizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _launchEmail(String email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
