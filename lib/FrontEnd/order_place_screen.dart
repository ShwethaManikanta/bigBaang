import 'dart:convert';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/home_page.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/home_bottom.dart';
import 'package:bigbaang/FrontEnd/Pages/payment_success.dart';
import 'package:bigbaang/Models/place_order_model.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/clear_cart_api_provider.dart';
import 'package:bigbaang/service/order_history_api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paytm/paytm.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderPlaceScreen extends StatefulWidget {
  final String retailerID;
  final String itemTotal;
  final String taxes;
  final String deliveryFee;
  final String address;
  final String email, phoneNumber;
  final String lat;
  final String long;
  final String toPay;
  const OrderPlaceScreen({
    Key? key,
    required this.retailerID,
    required this.itemTotal,
    required this.taxes,
    required this.deliveryFee,
    required this.address,
    required this.lat,
    required this.phoneNumber,
    required this.email,
    required this.long,
    required this.toPay,
  }) : super(key: key);

  @override
  _OrderPlaceScreenState createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {
  PlaceOrderModel _placeOrderModel = PlaceOrderModel();

  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  void openCheckout() async {
    print("to pay --------   - ----" + widget.toPay);
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': (int.parse(widget.toPay) * 100).toString(),
      'name': 'Big Baang',
      'description': 'Grocery Items',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': widget.phoneNumber, 'email': widget.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
  // var options = {
  //   'key': 'rzp_test_WRm1TRHOjibuFk',
  //   'amount': widget.toPay, //in the smallest currency sub-unit.
  //   "currency": "INR",
  //   "amount_paid": 0,
  //   "amount_due": 233.3,
  //   'name': 'Big Baang',
  //   'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
  //   'description': 'Paneer Tikka with Extra Rice',
  //   'timeout': 60, // in seconds
  //   'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  // };

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
    var order_id;
    setState(() {
      // payment_response_status =response.orderId;
      // order_id = value['response']['ORDERID'];
      // tax_amount = value['response']['TXNAMOUNT'];
      // tax_date_time = value['response']['TXNDATE'];
      // reference_no = value['response']['BANKTXNID'];

      if (payment_response_status == 'TXN_FAILURE') {
        print("TXN_FAILUREresponse +${payment_response_status}");
        Navigator.pushReplacementNamed(context, 'PaymentFailure');
      } else if (payment_response_status == 'TXN_SUCCESS') {
        transactionSuccess(response);
      }
      // (payment_response_status == 'TXNFAILURE') ? print("tacfailure") : Navigator.pushReplacementNamed(context, 'PaymentFailure');
    });
    // if (value['response'] != null) {
    //   payment_response = value['response']['STATUS'];
    // }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  transactionSuccess(response) async {
    print("TXN_SUCCESSresponse +${payment_response_status}");
    PlaceOrderModel? placeOrderModel = await apiServices.getOrders(
        widget.retailerID,
        widget.itemTotal,
        widget.taxes,
        widget.deliveryFee,
        widget.address,
        widget.lat,
        widget.long,
        widget.toPay,
        response.orderId!);
    print("Order Placed ---- " +
        placeOrderModel!.message.toString() +
        placeOrderModel.status.toString());

    if (placeOrderModel.status == "1") {
      Utils.showSnackBar(
          context: context, text: "${placeOrderModel.message.toString()}");
      Navigator.of(context).pop();

      context.read<ClearCartAPIProvider>().getClearCart();
      context.read<OrderHistoryAPIProvider>().getOrderHistory();
      context.read<CartListAPIProvider>().getCartList;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PaymentSuccess()));
    }

    if (placeOrderModel.status == "0") {
      Navigator.of(context).pop();
      Utils.showSnackBar(
          context: context, text: "${placeOrderModel.message.toString()}");
    }

    // apiServices.orderClearCart();
    // apiServices
    //     .buyProduct(
    //   context,
    //   data.subTotal,
    //   data.deliveryFee,
    //   data.taxes,
    //   data.total.toString(),
    //   data.getAllAddressCustomer.address,
    //   data.retailerDetails.id,
    //   SharedPreference.latitudeValue,
    //   SharedPreference.longitudeValue,
    // )
    //     .then((value) {
    //   setState(() {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => PaymentSuccess()),
    //     );
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final clearCartAPIProvider = Provider.of<ClearCartAPIProvider>(context);
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
                        "Payment",
                        style: HomePageStyles.loginTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
      bottomNavigationBar:
          SizedBox(height: 150, child: Image.asset("assets/images/bblogo.png")),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 250,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl:
                      "https://www.host.co.in/blog/wp-content/uploads/2019/03/cms-and-ecommerce.gif",
                ),
              ),
              InkWell(
                onTap: () async {
                  await showAlertDialog(context);
                },
                child: SizedBox(
                  height: 100,
                  child: Neumorphic(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    style: NeumorphicStyle(
                        intensity: 30,
                        lightSource: LightSource.bottomRight,
                        shadowLightColorEmboss: Colors.indigo,
                        shadowLightColor: Colors.indigo,
                        surfaceIntensity: 0.25,
                        depth: 10,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                "Cash On Delivery",
                                style: CommonStyles.blueBold14(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {
                  // generateTxnToken(2);
                  openCheckout();
                },
                child: SizedBox(
                  height: 100,
                  child: Neumorphic(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    style: NeumorphicStyle(
                        intensity: 30,
                        lightSource: LightSource.bottomRight,
                        shadowLightColorEmboss: Colors.indigo,
                        shadowLightColor: Colors.indigo,
                        surfaceIntensity: 0.25,
                        depth: 10,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                "Pay Online",
                                style: CommonStyles.blueBold14(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Neumorphic(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        style: NeumorphicStyle(color: Colors.red),
        child: Text(
          "Cancel",
          style: CommonStyles.textDataWhite13(),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Neumorphic(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        style: NeumorphicStyle(color: Colors.green),
        child: Text(
          "Confirm",
          style: CommonStyles.textDataWhite13(),
        ),
      ),
      onPressed: () async {
        print("retailerID ----------" + widget.retailerID);
        print("Item Total ----------" + widget.itemTotal);
        print("Item taxes ----------" + widget.taxes);
        print("deliveryFee ----------" + widget.deliveryFee);
        print("address ----------" + widget.address);
        print("Item lat ----------" + widget.lat);
        print("Item long ----------" + widget.long);
        print(" toPay ----------" + widget.toPay);

        await apiServices
            .getOrders(
                widget.retailerID,
                widget.itemTotal,
                widget.taxes,
                widget.deliveryFee,
                widget.address,
                widget.lat,
                widget.long,
                widget.toPay,
                "")
            .then((value) => _placeOrderModel = value!);
        print("Order Placed ---- " +
            _placeOrderModel.message.toString() +
            _placeOrderModel.status.toString());

        if (_placeOrderModel.status == "1") {
          Utils.showSnackBar(
              context: context, text: "${_placeOrderModel.message.toString()}");
          Navigator.of(context).pop();
          await context.read<ClearCartAPIProvider>().getClearCart();

          //   await context.read<OrderListAPIProvider>().getOrderHistory();
          await context.read<CartListAPIProvider>().getCartList;
          await context.read<OrderHistoryAPIProvider>().getOrderHistory();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomeBottomScreen()));
        }

        if (_placeOrderModel.status == "0") {
          Navigator.of(context).pop();
          Utils.showSnackBar(
              context: context, text: "${_placeOrderModel.message.toString()}");
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Bigg Bang",
        style: CommonStyles.blueBold(),
      ),
      content: Text(
        "Confirm to Place a Order !!",
        style: CommonStyles.blackBold12(),
      ),
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

  // // PayTm

  bool loading = false;
  String mid = "EOHYbG81009323396385";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  dynamic payment_response;
  dynamic payment_response_status;
  dynamic tax_amount;
  dynamic tax_date_time;
  dynamic reference_no;

  bool testing = false;

  void generateTxnToken(int mode) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": mid,
      "key_secret": "4m5UcF3CC3usM6ZwA",
      "website": "WEBSTAGING",
      "orderId": orderId,
      "amount": widget.toPay,
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });
      print("Txn Am+ ${txnToken}");

      var paytmResponse = Paytm.payWithPaytm(
          callBackUrl: callbackUrl,
          mId: mid,
          orderId: orderId,
          staging: testing,
          txnAmount: widget.toPay,
          txnToken: payment_response);
      print("paytmResponse+ ${txnToken}");
      paytmResponse.then((value) {
        print(value);
        setState(() {
          loading = false;
          print("Value is ");
          print(value);
          if (value['error']) {
            payment_response = value['errorMessage'];
          } else {
            var order_id;
            setState(() {
              payment_response_status = value['response']['STATUS'];
              order_id = value['response']['ORDERID'];
              tax_amount = value['response']['TXNAMOUNT'];
              tax_date_time = value['response']['TXNDATE'];
              reference_no = value['response']['BANKTXNID'];

              if (payment_response_status == 'TXN_FAILURE') {
                print("TXN_FAILUREresponse +${payment_response_status}");
                Navigator.pushReplacementNamed(context, 'PaymentFailure');
              } else if (payment_response_status == 'TXN_SUCCESS') {
                print("TXN_SUCCESSresponse +${payment_response_status}");
                apiServices
                    .getOrders(
                        widget.retailerID,
                        widget.itemTotal,
                        widget.taxes,
                        widget.deliveryFee,
                        widget.address,
                        widget.lat,
                        widget.long,
                        widget.toPay,
                        txnToken)
                    .then((value) => _placeOrderModel = value!);
                print("Order Placed ---- " +
                    _placeOrderModel.message.toString() +
                    _placeOrderModel.status.toString());

                if (_placeOrderModel.status == "1") {
                  Utils.showSnackBar(
                      context: context,
                      text: "${_placeOrderModel.message.toString()}");
                  Navigator.of(context).pop();
                  context.read<ClearCartAPIProvider>().getClearCart();

                  //   await context.read<OrderListAPIProvider>().getOrderHistory();
                  context.read<CartListAPIProvider>().getCartList;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentSuccess()));
                }

                if (_placeOrderModel.status == "0") {
                  Navigator.of(context).pop();
                  Utils.showSnackBar(
                      context: context,
                      text: "${_placeOrderModel.message.toString()}");
                }

                // apiServices.orderClearCart();
                // apiServices
                //     .buyProduct(
                //   context,
                //   data.subTotal,
                //   data.deliveryFee,
                //   data.taxes,
                //   data.total.toString(),
                //   data.getAllAddressCustomer.address,
                //   data.retailerDetails.id,
                //   SharedPreference.latitudeValue,
                //   SharedPreference.longitudeValue,
                // )
                //     .then((value) {
                //   setState(() {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => PaymentSuccess()),
                //     );
                //   });
                // });
              }
              // (payment_response_status == 'TXNFAILURE') ? print("tacfailure") : Navigator.pushReplacementNamed(context, 'PaymentFailure');
            });
            // if (value['response'] != null) {
            //   payment_response = value['response']['STATUS'];
            // }
          }
          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
