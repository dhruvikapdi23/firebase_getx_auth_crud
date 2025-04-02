import 'package:firebase_getx_auth_crud/utils/theme_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCommonLayout {

  //mulish text style
  TextStyle mulishFW400Or500TextStyle(
          {double? fontSize, FontWeight? fontWeight, Color? color,TextOverflow? overflow}) =>
      Get.theme.textTheme.labelMedium!.copyWith(
          color: color ?? appTheme.black,
          fontSize: fontSize ?? 14,
          overflow:overflow?? TextOverflow.ellipsis,
          fontFamily: GoogleFonts.mulish().fontFamily,
          fontWeight: fontWeight ?? FontWeight.w400);

  //mulish text style
  TextStyle poppinsTextStyle(
          {double? fontSize, FontWeight? fontWeight, Color? color}) =>
      GoogleFonts.poppins(
          fontSize: fontSize?? 14,
          color: color?? appTheme.black,
          fontWeight: fontWeight?? FontWeight.w600);
}
