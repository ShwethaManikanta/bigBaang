import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:flutter/material.dart';

class Utils {
  static getSizedBox({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static showSnackBar({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.lightBlue,
      content: Text(
        text,
        style: CommonStyles.textDataWhite14(),
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static getFloatingSnackBar(
      {required BuildContext context, required String snackBarText}) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Text(
          snackBarText,
          style: CommonStyles.textDataWhite14W400(),
        )));
  }

  static Widget loadingWidget() {
    return const Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              padding: EdgeInsets.only(left: 10), child: Text("Loading...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSendingOTP(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Sending OTP...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showBookingVehicle(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Booking Vehicle...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget dividerThin() {
    return const Divider(
      color: Colors.black54,
      height: 5,
      thickness: 0.5,
    );
  }

  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Error Occured',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
        content: Text(
          message,
          style: CommonStyles.errorTextStyleStyle(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK!'),
          )
        ],
      ),
    );
  }
}

showLoadDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text("Loading...")),
      ],
    ),
  );
  return showDialog(
    barrierDismissible: false,
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
