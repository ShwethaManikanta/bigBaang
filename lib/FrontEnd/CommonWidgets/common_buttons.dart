import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:flutter/material.dart';

import 'common_styles.dart';

Widget materialButtonCommon(
    {required VoidCallback fun, required String text, double? elevation}) {
  return MaterialButton(
    elevation: elevation,
    height: 30,
    minWidth: 60,
    child: Container(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          text,
          style: CommonStyles.textDataWhite14(),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 8, offset: Offset(1, -2))
          ]),
    ),
    onPressed: fun,
  );
}

class RoundedButton extends StatelessWidget {
  final String title;
  final Function() onpressed;

  const RoundedButton({required this.title, required this.onpressed, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MaterialButton(
        elevation: 3,
        minWidth: MediaQuery.of(context).size.width * 0.35,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onpressed,
        child: Text(
          title,
          style: CommonStyles.sendOTPButtonTextStyle(),
        ),
        color: Colors.blue,
        splashColor: Colors.green,
      ),
    );
  }
}

Widget materialButtonCommonWithIcon(
    {required VoidCallback fun,
    required String text,
    required IconData iconData,
    double? elevation}) {
  return MaterialButton(
    elevation: 0,
    padding: const EdgeInsets.all(0),
    height: 30,
    minWidth: 60,
    child: Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
            size: 15,
          ),
          Utils.getSizedBox(width: 10),
          Center(
            child: Text(
              text,
              style: CommonStyles.textDataWhite14(),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 8, offset: Offset(1, -2))
          ]),
    ),
    onPressed: fun,
  );
}

Widget materialButtonCommonWithAdditionSubtracition(
    {required VoidCallback fun,
    required IconData iconData,
    double? elevation}) {
  return MaterialButton(
    elevation: 0,
    padding: const EdgeInsets.all(0),
    height: 15,
    minWidth: 15,
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Icon(
        iconData,
        color: Colors.white,
        size: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 3, offset: Offset(1, 1))
          ]),
    ),
    onPressed: fun,
  );
}

Widget materialButtonCommonWithAdditionSubtracitionPlainText(
    {required VoidCallback fun,
    required IconData iconData,
    double? elevation}) {
  return MaterialButton(
    elevation: 0,
    padding: const EdgeInsets.all(0),
    height: 25,
    minWidth: 25,
    child: Icon(
      iconData,
      color: Colors.white,
      size: 24,
    ),
    onPressed: fun,
  );
}
