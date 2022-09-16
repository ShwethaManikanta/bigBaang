import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:flutter/material.dart';

mobileNumberTextFormField(GlobalKey<FormState> mobileKey,
    TextEditingController mobileController, bool enabled) {
  return Form(
    key: mobileKey,
    child: TextFormField(
      controller: mobileController,
      enabled: enabled,
      keyboardType: TextInputType.number,
      maxLength: 14,
      style: CommonStyles.textDataWhite14(),
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Mobile Number'.toUpperCase(),
        prefixStyle: const TextStyle(color: Colors.black),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        disabledBorder: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}

class MobileNoTextField extends StatelessWidget {
  const MobileNoTextField(
      {Key? key,
      required this.enabled,
      required this.mobileController,
      required this.mobileKey})
      : super(key: key);
  final GlobalKey<FormState> mobileKey;
  final TextEditingController mobileController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: mobileKey,
      child: TextFormField(
        controller: mobileController,
        enabled: enabled,
        keyboardType: TextInputType.number,
        maxLength: 10,
        style: CommonStyles.textDataWhite14(),
        validator: (value) {
          if (value!.length != 10) {
            return "Must have 10 digits.";
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: CommonStyles.textDataWhite8Bold(),
          isDense: true,
          prefix: Text(
            "+91 ",
            style: CommonStyles.textDataWhite12Bold(),
          ),
          labelText: 'Mobile Number'.toUpperCase(),
          helperText: "",
          counterText: "",
          helperStyle: CommonStyles.textDataWhite8Bold(),
          prefixStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          disabledBorder: InputBorder.none,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NameTextForm extends StatelessWidget {
  const NameTextForm(
      {Key? key,
      required this.nameController,
      required this.nameKey,
      required this.edit})
      : super(key: key);
  final TextEditingController nameController;
  final GlobalKey<FormState> nameKey;
  final bool edit;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: nameKey,
      child: TextFormField(
        controller: nameController,
        enabled: edit,
        keyboardType: TextInputType.name,
        style: CommonStyles.textDataWhite14(),
        validator: (value) {
          if (value!.length < 3) {
            return "Enter a valid name";
          }
          return null;
        },
        // initialValue: vendorProfile.retailerName,
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Name'.toUpperCase(),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          disabledBorder: InputBorder.none,
          errorStyle: CommonStyles.textDataWhite8Bold(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class EmailTextForm extends StatelessWidget {
  const EmailTextForm(
      {Key? key,
      required this.emailController,
      required this.emailKey,
      required this.edit})
      : super(key: key);
  final TextEditingController emailController;
  final GlobalKey<FormState> emailKey;
  final bool edit;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: emailKey,
      child: TextFormField(
        controller: emailController,
        enabled: edit,
        keyboardType: TextInputType.emailAddress,
        style: CommonStyles.textDataWhite14(),

        validator: (value) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value!)) {
            return "Enter Valid email";
          }
          return null;
        },
        // initialValue: vendorProfile.email,
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Email'.toUpperCase(),
          errorStyle: CommonStyles.textDataWhite8Bold(),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          disabledBorder: InputBorder.none,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
