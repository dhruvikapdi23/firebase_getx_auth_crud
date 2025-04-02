
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDecoration {
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(20));
  }

  static BoxDecoration textBoxDecoration({color, bColor, radius}) {
    return BoxDecoration(
        color: color,
        border: Border.all(color: bColor),
        borderRadius: BorderRadius.circular(radius));
  }
}
