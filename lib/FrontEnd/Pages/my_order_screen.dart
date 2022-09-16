import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/home_page.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/home_bottom.dart';
import 'package:bigbaang/Models/place_order_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/order_history_api_provider.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  initilaize() {
    if (context.read<OrderHistoryAPIProvider>().orderHistoryModel == null) {
      context.read<OrderHistoryAPIProvider>().getOrderHistory();
    }
  }

  PlaceOrderModel _cancelOrder = PlaceOrderModel();

  @override
  void initState() {
    initilaize();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AppBarProductPage(
                    appBartext: "My Orders",
                    scaffoldKey: scaffoldKey,
                    onlySearch: true,
                  ),
                ],
              ),
              orderHistoryAPIProvider.orderHistoryModel == null ||
                      orderHistoryAPIProvider.orderHistoryModel!.orderHistory ==
                          null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          "assets/images/no_order.jpg",
                          height: 150,
                        ),
                        Utils.getSizedBox(height: 20),
                        Text(
                          "We are waiting to deliver your first order.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Utils.getSizedBox(height: 15),
                        Text(
                          "Shop product from BigBaang online Supermarket",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Utils.getSizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.deepPurple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeBottomScreen()));
                                  },
                                  child: Text(
                                    "Start Shopping",
                                    style: TextStyle(fontSize: 18),
                                  ))),
                        )
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: orderHistoryAPIProvider
                          .orderHistoryModel!.orderHistory!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              color: Colors.white,
                              intensity: 50,
                              depth: 5,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Order ID   :    ${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].id}",
                                    style: CommonStyles.blackText14BoldW500(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: orderHistoryAPIProvider
                                        .orderHistoryModel!
                                        .orderHistory![index]
                                        .productDetails!
                                        .length,
                                    itemBuilder: (context, productIndex) {
                                      return Card(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        elevation: 15,
                                        shadowColor: Colors.lightBlue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                orderHistoryAPIProvider
                                                    .orderHistoryModel!
                                                    .orderHistory![index]
                                                    .productDetails![
                                                        productIndex]
                                                    .productName!,
                                                style: CommonStyles
                                                    .textw400BlueS14(),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Quantity   :  ",
                                                    style: CommonStyles
                                                        .blackText12BoldW400(),
                                                  ),
                                                  Text(
                                                    "${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].productDetails![productIndex].qty}",
                                                    style: CommonStyles
                                                        .blackText14BoldW500Color(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Qty Price   :  ",
                                                    style: CommonStyles
                                                        .textw300BlackS13(),
                                                  ),
                                                  Text(
                                                    "${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].productDetails![productIndex].price}",
                                                    style: CommonStyles
                                                        .blackText14thinW500(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Item Total   :  ₹ ",
                                              style: CommonStyles
                                                  .blackText14BoldW500(),
                                            ),
                                            Text(
                                              " ${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].itemTotal}",
                                              style: CommonStyles.blueBold(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Total   :  ₹ ",
                                              style: CommonStyles
                                                  .blackText14BoldW500(),
                                            ),
                                            Text(
                                              " ${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].total}",
                                              style: CommonStyles.blueBold(),
                                            ),
                                            Text(
                                              "  (Inclusive of Tax)",
                                              style: CommonStyles
                                                  .blackText10BoldW500(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].address}",
                                    style: CommonStyles.blackText14BoldW500(),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (orderHistoryAPIProvider
                                              .orderHistoryModel!
                                              .orderHistory![index]
                                              .status !=
                                          "Canceled")
                                        InkWell(
                                          onTap: () async {
                                            showAlertDialog(context,
                                                orderHistoryAPIProvider, index);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Center(
                                              child: Text(
                                                "Cancel Order",
                                                style: CommonStyles
                                                    .whiteText15BoldW500(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Row(
                                        children: [
                                          Text(
                                            "Order Status  :",
                                            style: CommonStyles
                                                .blackText10BoldW500(),
                                          ),
                                          Text(
                                            "  ${orderHistoryAPIProvider.orderHistoryModel!.orderHistory![index].status}",
                                            style: CommonStyles.greenBold(),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              Utils.getSizedBox(height: 50)
            ],
          ),
        )),
      ),
    );
  }

  showAlertDialog(BuildContext context, orderHistoryAPIProvider, index) {
    // set up the button
    Widget noButton = TextButton(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Text(
            "No",
            style: CommonStyles.textDataWhite12Bold(),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Text(
            "Yes",
            style: CommonStyles.textDataWhite12Bold(),
          ),
        ),
      ),
      onPressed: () async {
        await apiServices
            .deleteOrder(orderHistoryAPIProvider
                .orderHistoryModel!.orderHistory![index].id!)
            .then((value) {
          _cancelOrder = value!;
        });
        if (_cancelOrder.status == "1") {
          Utils.showSnackBar(context: context, text: _cancelOrder.message!);
          await context.read<OrderHistoryAPIProvider>().getOrderHistory();
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Order Cancellation !!\n",
        style: CommonStyles.greenBold(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Are you sure \n Do you want to Cancel your Order ??",
        style: CommonStyles.textw200RedS16(),
        textAlign: TextAlign.center,
      ),
      actions: [noButton, okButton],
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
}
