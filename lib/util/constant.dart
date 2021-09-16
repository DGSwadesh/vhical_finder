import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customizeTextStyle(fontWeight, fontSize, fontColor) =>
    GoogleFonts.roboto(
        textStyle: TextStyle(
            fontWeight: fontWeight,
            // fontFamily: 'Poppins',
            wordSpacing: 3,
            color: fontColor,
            fontSize: fontSize));

TextStyle customizeTextStyleSmallerSpace(fontWeight, fontSize, fontColor) =>
    GoogleFonts.nunito(
        textStyle: TextStyle(
            fontWeight: fontWeight,
            // fontFamily: 'Poppins',
            wordSpacing: 1,
            letterSpacing: 0.3,
            color: fontColor,
            fontSize: fontSize));

showToast(msg, color) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    
//=================================Color Code====================================
final Color red = Color(0xffff1a1a);

//=================================BASE URL====================================
final String BASE_URL = "https://laravel.";
// final String BASE_URL = "https://";

//========================================sharedpreference======================

//==========================Text============================================
final String INTERNET_ERROR = "We are faceing an error";
final String SUCCESS = "success";
final String FAILED = "failed";

//========================assets======================
final String googleImg = 'assets/google.svg';
final themeColor = Color(0xfff5a623);
final primaryColor = Color(0xff203152);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);