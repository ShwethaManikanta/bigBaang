import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String mrp, salePrice;
  const PriceTag({Key? key, required this.mrp, required this.salePrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "₹",
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: " $salePrice  ",
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: " ₹ $mrp",
            style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}
