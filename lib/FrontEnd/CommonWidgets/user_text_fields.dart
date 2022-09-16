import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/search_delgate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserTextField extends StatelessWidget {
  final String titleLabel;
  final IconData icon;

  final TextEditingController controller;
  final TextInputType inputType;

  const UserTextField(
      {Key? key,
      required this.titleLabel,
      required this.icon,
      required this.controller,
      required this.inputType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          // if (value.length != maxLength) {
          //   if (maxLength == 6) {
          //     return "Minimum 6 Digits Required";
          //   } else {
          //     return "Minimum 10 Digits Required";
          //   }
          // }
          return null;
        },
      ),
    );
  }
}

Widget searchTextField(
  TextEditingController textEditingController,
  String hintText,
  String labelText,
  String pickerData,
  String confirmText,
  String title,
  BuildContext context,
) {
  // return TextFormField(
  //     controller: textEditingController,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       labelText: labelText,
  //       hintStyle: CommonStyles.labelTextSyleWhite(),
  //       filled: true,
  //       suffix: const Icon(FontAwesomeIcons.search),
  //       fillColor: Colors.white,
  //       contentPadding:
  //           const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
  //       border: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4)),
  //           borderSide: BorderSide(width: 1, color: Colors.white)),
  //     ),
  //     validator: (value) {
  //       var name = value.toString();
  //       if (name.isEmpty) {
  //         return "Item Name";
  //       }
  //       return null;
  //     },
  //     onTap: () async {
  //       FocusScope.of(context).requestFocus(FocusNode());
  //       var value = await showSearch(
  //           context: context,
  //           delegate: DataSearch(
  //               controller: textEditingController,
  //               productNameList: nameList,
  //               productCategoryList: categoryList));
  //       print(value);
  //     });

  return TextFormField(
      style: CommonStyles.labelTextSyle(),
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: "Search for Products",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: const Icon(
          FontAwesomeIcons.search,
          size: 20,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        var value = await showSearch(
            context: context,
            delegate: DataSearch(
              controller: textEditingController,
            ));
      });
}
