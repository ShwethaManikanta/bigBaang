import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> paymentMethod = ["Paytm", "Free Recharge", "Phonepe"];
  List<String> paymentIcon = [
    "assets/images/paytm.jpg",
    "assets/images/freeRe.jpg",
    "assets/images/phonepel.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          AppBarProductPage(
            appBartext: "My Payments",
            scaffoldKey: scaffoldKey,
            onlySearch: true,
            noIcon: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              child: Column(
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              paymentIcon[index],
                              height: 30,
                            ),
                          ),
                          Utils.getSizedBox(width: 10),
                          Expanded(
                            flex: 6,
                            child: Text(
                              paymentMethod[index],
                              style: CommonStyles.submitTextStyle(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "Link",
                            style: TextStyle(color: Colors.blue),
                          ))
                        ],
                      ),
                      if (index != 2)
                        Divider(
                          height: 30,
                        )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
