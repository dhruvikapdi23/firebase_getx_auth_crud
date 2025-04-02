
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_getx_auth_crud/assets/index.dart';
import 'package:firebase_getx_auth_crud/extension/widget_extension.dart';
import 'package:firebase_getx_auth_crud/utils/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_fonts.dart';
import 'app_dialogs.dart';

class AppWidgets {
  static Widget getLoadingView() => Center(
          child: CircularProgressIndicator()).backgroundColor(appTheme.textField.withValues(alpha: .40));

  static Widget getDataNotFoundView({String? msg}) => Center(
          child: Text(
        msg ?? Fonts.dataNotFound,
        style: Get.theme.textTheme.labelLarge,
      ));

  static Widget getNetworkImage(String path,
          {double? width,
          double? height,
          BoxFit? fit,
          bool isLoading = true}) =>
      CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            isLoading ? getLoadingView() : const SizedBox(),
        errorWidget: (context, url, error) => Image.asset(
          imgAssets.userIcon,
          height: height,
          width: width,
        ),
      );



static Widget getDialogView(String title, String msg) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.theme.textTheme.displayLarge
                ?.copyWith(color: Get.theme.dividerColor),
          ),
          Text(
            msg,
            style: Get.theme.textTheme.titleSmall,
          ).paddingSymmetric(vertical: 30),
        ],
      );

  static exitDialog() => AppDialogs.showCommonDialog(
        AppWidgets.getDialogView(Fonts.exit.tr, Fonts.exitMsg.tr),
        isbottom: true,
        onTap: () => SystemNavigator.pop(),
      );

  static Widget get devider => Container(
        color: Get.theme.dividerColor,
        width: double.infinity,
        height: 1,
      );

  PopupMenuItem buildPopupMenuItem({list,index}) {
    return PopupMenuItem(
        value: index,
        height: 20,
        child:list);
  }


}
