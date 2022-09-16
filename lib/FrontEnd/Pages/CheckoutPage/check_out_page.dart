import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_text_styles_1.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/drawer_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:bigbaang/FrontEnd/order_place_screen.dart';
import 'package:bigbaang/service/checkout_list_api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

/*  ApiService apiService = ApiService();

  bool isLoading = true;
  CheckOutModel? _checkOutModel;

  Future<void> getCheckOutList() async {
    await apiService.getCheckOutList("${ApiService.userID}").then((value) {
      setState(() {
        _checkOutModel = value;
        isLoading = false;
      });
    });
  }*/

  @override
  void initState() {
    //  getCheckOutList();
    initilaize();
    super.initState();
  }

  initilaize() {
    if (context.read<CheckOutListAPIProvider>().checkOutModel == null) {
      context.read<CheckOutListAPIProvider>().checkOutList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkOutListApiProvider =
        Provider.of<CheckOutListAPIProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        "Address",
                        style: HomePageStyles.loginTextStyle(),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     // IconButton(
                  //     //     onPressed: () async {
                  //     //       // await showSearch(
                  //     //       //     context: context,
                  //     //       //     delegate: DataSearch(
                  //     //       //         controller: textEditingController,
                  //     //       //         productNameList: nameList,
                  //     //       //         productCategoryList: categoryList));
                  //     //     },
                  //     //     icon: const Icon(
                  //     //       Icons.search,
                  //     //       size: 24,
                  //     //       color: Colors.white,
                  //     //     )),
                  //     // IconButton(
                  //     //   onPressed: () {},
                  //     //   icon: const Icon(Icons.more_vert,
                  //     //       size: 27, color: Colors.white),
                  //     // ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        )),
      ),
      body: checkOutListApiProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            )
          : Builder(builder: (context) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Card(
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Customer Address",
                                            style: CommonStyles
                                                .blackText14BoldW500()),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          child: (checkOutListApiProvider
                                                      .checkOutModel!
                                                      .getAllAddressCustomer !=
                                                  null)
                                              ? Text(
                                                  getAddressTypeText(
                                                      "${checkOutListApiProvider.checkOutModel!.getAllAddressCustomer!.addressTypeId}"),
                                                  style:
                                                      CommonStyles.blueBold14())
                                              : Text(""),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (checkOutListApiProvider.checkOutModel!
                                            .getAllAddressCustomer !=
                                        null)
                                      Text(
                                        "${checkOutListApiProvider.checkOutModel!.getAllAddressCustomer!.address}",
                                        style: CommonStyles.blueBold14(),
                                      ),
                                    if (checkOutListApiProvider.checkOutModel!
                                                .getAllAddressCustomer !=
                                            null &&
                                        checkOutListApiProvider
                                            .checkOutModel!
                                            .getAllAddressCustomer!
                                            .landmark!
                                            .isNotEmpty)
                                      Text(
                                        "LandMark   :   ${checkOutListApiProvider.checkOutModel!.getAllAddressCustomer!.landmark}",
                                        style:
                                            CommonStyles.blackText14BoldW500(),
                                      ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "Mobile         :    ",
                                            style: CommonStyles
                                                .blackText14BoldW500()),
                                        TextSpan(
                                            text:
                                                "${checkOutListApiProvider.checkOutModel!.userDetails!.mobileNo}",
                                            style: CommonStyles.blueBold14()),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      color: Colors.grey.shade300,
                                      height: 1,
                                      width: double.infinity,
                                    ),
                                    addressAction()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /*  Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    color: Colors.tealAccent.withOpacity(0.4),
                                    width: 1),
                                color: Colors.tealAccent.withOpacity(0.2)),
                            margin: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                  groupValue: 1,
                                  onChanged: (isChecked) {},
                                  activeColor: Colors.tealAccent.shade400,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Standard Delivery",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Duration  :  ${checkOutListApiProvider.checkOutModel!.retailerDetails!.duration}  Distance  :  ${checkOutListApiProvider.checkOutModel!.retailerDetails!.distance} ",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),*/
                          Card(
                            elevation: 10,
                            margin: EdgeInsets.all(4),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                /* border:
                                      Border.all(color: Colors.grey.shade200)*/
                              ),
                              padding: EdgeInsets.only(
                                  left: 12, top: 8, right: 12, bottom: 8),
                              child: ListView.builder(
                                itemCount: checkOutListApiProvider
                                    .checkOutModel!.checkoutDetails!.length,
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: <Widget>[
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: Colors.transparent,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "${checkOutListApiProvider.checkOutModel!.productImageUrl}${checkOutListApiProvider.checkOutModel!.checkoutDetails![index].productImage}",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "Product Name    :    ${checkOutListApiProvider.checkOutModel!.checkoutDetails![index].productName}\n",
                                                style: CommonStyles
                                                    .blackText10BoldW500()),
                                            TextSpan(
                                                text:
                                                    "Product Total      :   ₹ ${checkOutListApiProvider.checkOutModel!.checkoutDetails![index].productTotal}",
                                                style: CommonStyles
                                                    .blackText10BoldW500())
                                          ]),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              /*   decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border:
                                      Border.all(color: Colors.grey.shade200)),*/
                              padding: EdgeInsets.only(
                                  left: 12, top: 8, right: 12, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "PRICE DETAILS",
                                    style: CommonStyles.blackText14BoldW500(),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5,
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Item Total",
                                          style: CommonStyles
                                              .blackText12BoldW400(),
                                        ),
                                      ),
                                      // Text()
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "₹  ${checkOutListApiProvider.checkOutModel!.mrpTotal}",
                                          style: CommonStyles.blueBold(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Bag discount",
                                          style: CommonStyles
                                              .blackText12BoldW400(),
                                        ),
                                      ),
                                      // Text()
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "₹  ${checkOutListApiProvider.checkOutModel!.discountBag}",
                                          style: CommonStyles.blueBold(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Tax",
                                          style: CommonStyles
                                              .blackText12BoldW400(),
                                        ),
                                      ),
                                      // Text()
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "₹  ${checkOutListApiProvider.checkOutModel!.tax}",
                                          style: CommonStyles.blueBold(),
                                        ),
                                      )
                                    ],
                                  ),
                                  /*   Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Order Total",
                                          style: CustomTextStyle
                                              .textFormFieldMedium
                                              .copyWith(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      // Text()
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.rupeeSign,
                                              size: 12,
                                            ),
                                            Text(
                                              " ${_checkOutModel!.orderTotal}",
                                              style: CustomTextStyle
                                                  .textFormFieldMedium
                                                  .copyWith(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),*/
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Delivery Charges",
                                          style: CommonStyles
                                              .blackText12BoldW400(),
                                        ),
                                      ),
                                      // Text()
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "₹  ${checkOutListApiProvider.checkOutModel!.deliveryFee}",
                                          style: CommonStyles.blueBold(),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5,
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 10,
                                        child: Text(
                                          "Order Total",
                                          style: CommonStyles.greenBold(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "₹  ${checkOutListApiProvider.checkOutModel!.orderTotal}",
                                          style: CommonStyles.greenBold(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 98,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: MaterialButton(
                        onPressed: () {
                          if (checkOutListApiProvider
                                  .checkOutModel!.getAllAddressCustomer !=
                              null) {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => OrderPlaceScreen(
                                      retailerID: checkOutListApiProvider
                                          .checkOutModel!.retailerDetails!.id!,
                                      itemTotal: checkOutListApiProvider
                                          .checkOutModel!.mrpTotal!,
                                      taxes: checkOutListApiProvider
                                          .checkOutModel!.tax!,
                                      deliveryFee: checkOutListApiProvider
                                          .checkOutModel!.deliveryFee!,
                                      phoneNumber: checkOutListApiProvider
                                          .checkOutModel!
                                          .userDetails!
                                          .mobileNo!,
                                      email: checkOutListApiProvider
                                          .checkOutModel!.userDetails!.email!,
                                      address: checkOutListApiProvider
                                          .checkOutModel!
                                          .getAllAddressCustomer!
                                          .address!,
                                      lat: checkOutListApiProvider
                                          .checkOutModel!
                                          .getAllAddressCustomer!
                                          .lat!,
                                      long: checkOutListApiProvider
                                          .checkOutModel!
                                          .getAllAddressCustomer!
                                          .long!,
                                      toPay: checkOutListApiProvider
                                          .checkOutModel!.orderTotal!,
                                    )));
                            showThankYouBottomSheet(context);
                          } else {
                            Utils.showSnackBar(
                                context: context,
                                text: "Check Your Delivery Address !!");
                          }
                        },
                        child: Text(
                          "Confirm Order",
                          style: CommonStyles.whiteText15BoldW500(),
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                    flex: 10,
                  )
                ],
              );
            }),
    );
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: const Image(
                    image: AssetImage(
                      "assets/images/breakfast.webp",
                    ),
                    width: 30,
                    height: 20,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: CustomTextStyle.textFormFieldMedium.copyWith(
                                fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    const SizedBox(
                      height: 24,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Track Order",
                        style: CustomTextStyle.textFormFieldMedium
                            .copyWith(color: Colors.white),
                      ),
                      color: Colors.pink,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  /* selectedAddressSection() {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Customer Address",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                      style: CustomTextStyle.textFormFieldBlack.copyWith(
                          color: Colors.indigoAccent.shade200, fontSize: 8),
                    ),
                  )
                ],
              ),
              createAddressText(
                  "431, Commerce House, Nagindas Master, Fort", 16),
              createAddressText("Mumbai - 400023", 6),
              createAddressText("Maharashtra", 6),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: "02222673745",
                      style: CustomTextStyle.textFormFieldBold
                          .copyWith(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }*/

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*Spacer(
            flex: 2,
          ),*/
          // FlatButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //         context: context,
          //         shape: const RoundedRectangleBorder(
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(8),
          //                 topRight: Radius.circular(8))),
          //         builder: (_) {
          //           return const BottomSheetAddLocation();
          //         });
          //   },
          //   child: Text("Choose Delivery Address",
          //       style: CommonStyles.greenBold()),
          //   splashColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          // ),
          /*  Spacer(
            flex: 3,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Add New Address",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(fontSize: 12, color: Colors.indigo.shade700)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 2,
          ),*/
        ],
      ),
    );
  }

  standardDelivery() {}

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
}
