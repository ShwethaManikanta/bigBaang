import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsStyle {
  ProductDetailsStyle._();

  static textFieldStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.3,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ));
  }

  static textWhiteDelivery() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      letterSpacing: 0.1,
      color: Colors.brown[800],
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ));
  }

  static textFieldStyleWhite8() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.3,
      color: Colors.white,
      fontSize: 8,
      fontWeight: FontWeight.w800,
    ));
  }

  static textFieldStyleWhite10() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.3,
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ));
  }

  static whiteText13BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            backgroundColor: Colors.transparent,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat'));
  }

  static loginTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.15,
            color: Colors.white,
            backgroundColor: Colors.transparent,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat'));
  }

  static submitTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      backgroundColor: Colors.transparent,
      letterSpacing: 0.2,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ));
  }

  static genderTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[900],
      backgroundColor: Colors.transparent,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ));
  }

  static sendOTPButtonTextStyle() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 0.15,
      // backgroundColor: Colors.transparent,
      fontSize: 16,
      fontWeight: FontWeight.w900,
    ));
  }

  static errorTextStyleStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      backgroundColor: Colors.transparent,
      fontSize: 13,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static normalText() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static smallTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 10,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w600,
    ));
  }

  static smallTextSize13() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 13,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w800,
    ));
  }

  static smallTextSize12gray() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.grey,
      backgroundColor: Colors.transparent,
      fontSize: 12,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w700,
    ));
  }

  static smallTextSize12grayLineThrough() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.grey,
      backgroundColor: Colors.transparent,
      fontSize: 12,
      decoration: TextDecoration.lineThrough,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w700,
    ));
  }

  static smallTextSize14grayLineThrough() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.grey,
      backgroundColor: Colors.transparent,
      fontSize: 14,
      decoration: TextDecoration.lineThrough,
      letterSpacing: 0.05,
      fontWeight: FontWeight.w700,
    ));
  }

  static productHeaderTextSyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 19,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w600,
    ));
  }

  static aboutProductPageStyle() {
    return GoogleFonts.openSans(
        textStyle: const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 17,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w700,
    ));
  }

  static aboutProductPageStyleSmallSilver() {
    return GoogleFonts.openSans(
        textStyle: const TextStyle(
      color: Color(0xff757575),
      fontSize: 16,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w700,
    ));
  }

  static aboutProductPageStyleSmallSilverLight() {
    return GoogleFonts.openSans(
        textStyle: const TextStyle(
      color: Color(0xff757575),
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static aboutProductPageStyleS10mallSilverLight() {
    return GoogleFonts.openSans(
        textStyle: const TextStyle(
      color: Colors.black54,
      fontSize: 11,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w600,
    ));
  }

  static normalTextBlueColor() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.blue,
      backgroundColor: Colors.transparent,
      fontSize: 10,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w600,
    ));
  }

  static enterYourNumberTextStyle() {
    return GoogleFonts.montserrat(
        textStyle: TextStyle(
      color: Colors.brown[600],
      backgroundColor: Colors.transparent,
      fontSize: 14,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w300,
    ));
  }
}
