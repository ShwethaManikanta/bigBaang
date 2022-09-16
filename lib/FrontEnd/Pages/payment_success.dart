import 'dart:async';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
    //   setState(() {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeBottomNavigationScreen()));
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, 'Home');
                    },
                    icon: Icon(Icons.arrow_back))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://icon-library.com/images/4631f6529c.png"),
                    fit: BoxFit.fitHeight)),
          ),
          Text(
            "Payment Success",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.green),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Yay! Order Recieved",
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Your order will be delivered shortly. Keep foodieing!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
