import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:flutter/material.dart';

class OfferTag extends StatelessWidget {
  final String offerPercentage;
  const OfferTag({Key? key, required this.offerPercentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        width: 80,
        decoration: const BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )),
        child: Center(
          child: Text(
            "$offerPercentage% OFF",
            style: CommonStyles.labelTextSyleWhite10(),
          ),
        ),
      ),
    );
  }
}
