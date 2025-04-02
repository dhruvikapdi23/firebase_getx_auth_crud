
import 'package:firebase_getx_auth_crud/utils/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';
import '../screens/profile_screen/layouts/selection_option_layout.dart';
import 'app_decoration.dart';


class AppDialogs {

  static successSnackBar(String msg, {Function? onThenCall}) {
    if (msg.isNotEmpty) {
      return Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          isDismissible: true,
          duration: Duration(seconds: 3), // Auto dismiss after 3 seconds

          messageText: Text(
            msg,
            style: TextStyle(
                fontSize: 14, color: appTheme.sameWhite),
          )))
          .close()
          .then((value) => onThenCall!());
    }
  }

  /*static errorSnackBar(String msg) {
    if (msg.isNotEmpty) {
      return ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: appTheme.redColor,
            content: Text(
              msg,
              style: TextStyle(
                  fontSize: 14, color: appTheme.sameWhite),
            )),
      );
    }
  }*/

  static errorSnackBar(String msg) {
    if (msg.isNotEmpty) {
      return Get.showSnackbar(GetSnackBar(
          backgroundColor: appTheme.redColor,
          isDismissible: true,
          duration: Duration(seconds: 3), // Auto dismiss after 3 seconds
          messageText: Text(
            msg,
            style: TextStyle(
                fontSize: 14, color: appTheme.sameWhite),
          )));
    }
  }

  static showProcess() {
    return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: PopScope(canPop: false, child: AppWidgets.getLoadingView())),
    );
  }

  static showCommonDialog(Widget child,
      {bool isbottom = false, Function()? onTap}) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
                decoration: AppDecoration.cardDecoration(),
                padding: EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (!isbottom)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.close,
                              color: Get.theme.dividerColor,
                            )),
                      ),
                    child,
                    if (isbottom)
                      Row(
                        children: [
                          Expanded(
                              child: appButton(
                            Fonts.no.tr,
                            height: 50,
                            color: appTheme.primary,
                            textColor: appTheme.white,
                            onTap: () => Get.back(),
                          ).paddingSymmetric(horizontal: 40)),
                          Expanded(
                              child: appButton(
                            Fonts.yes.tr,
                            height: 50,
                            onTap: () {
                              Get.back();
                              onTap?.call();
                            },
                          ).paddingSymmetric(horizontal: 40)),
                        ],
                      )
                  ],
                )),
          ),
        );
      },
    );
  }

  showLayout({Function(String)? onTap}) async {
    showDialog(
      context: Get.context!,
      builder: (context1) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          surfaceTintColor: Get.theme.scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...AppArray().selectList.asMap().entries.map((e) =>
                  SelectOptionLayout(
                      data: e.value,
                      index: e.key,
                      list: AppArray().selectList,
                      onTap: () => onTap!(e.value['title'])))
            ],
          ),
        );
      },
    );
  }
}
