import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageStyles {
  HomePageStyles._();

  static textFieldStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      letterSpacing: 0.3,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ));
  }

  static whiteText15BoldW500() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
            letterSpacing: 0.1,
            color: Colors.white,
            backgroundColor: Colors.transparent,
            fontSize: 15,
            fontWeight: FontWeight.w600,
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

  static normalTextMetaData() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.transparent,
      fontSize: 15,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w600,
    ));
  }

  static normalTextBlueColor() {
    return GoogleFonts.roboto(
        textStyle: const TextStyle(
      color: Colors.blue,
      backgroundColor: Colors.transparent,
      fontSize: 14,
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
