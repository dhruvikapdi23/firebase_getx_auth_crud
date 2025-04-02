

import 'package:firebase_getx_auth_crud/utils/common_app_layout.dart';
import 'package:firebase_getx_auth_crud/utils/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../extension/spacing.dart';

Widget appButton(String title,
    {Color? color,bColor,
    Color? textColor,
    double? width,
    double? height,
    Function()? onTap,
    TextStyle? style,
    BorderRadiusGeometry? borderRadius,
      Widget? icon,
    bool isShowBottom = true}) {
  return SizedBox(
    width: width ?? double.infinity,
    height: height ?? 55,
    child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: bColor?? Colors.transparent),
              borderRadius: borderRadius ??
                  BorderRadius.circular(8), // <-- Radius
            ),
            disabledBackgroundColor: color ?? appTheme.primary,
            backgroundColor: color ?? appTheme.primary),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon !=null)
            Row(
              children: [icon,const HSpace(9)],
            ),
            Text(
              title,
              style: style ??
                  AppCommonLayout().poppinsTextStyle(color: appTheme.sameWhite,fontSize: 16),
            ),
          ],
        )),
  );
}
