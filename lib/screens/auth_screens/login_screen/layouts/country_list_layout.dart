
import 'dart:developer';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_getx_auth_crud/extension/widget_extension.dart';
import 'package:firebase_getx_auth_crud/utils/common_app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../utils/theme_service.dart';

class CountryListLayout extends StatelessWidget {
  final String? dialCode;
  final ValueChanged<CountryCode?>? onChanged;
  const CountryListLayout({super.key,this.dialCode, this.onChanged});

  @override
  Widget build(BuildContext context) {
    log("dialCode:$dialCode");
    return SizedBox(
        height: 48,
        child: CountryListPick(
            useUiOverlay: false,
            appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading:
                Icon(Icons.arrow_back, color: appTheme.sameWhite)
                    .inkWell(onTap: () => Get.back()),
                title: Text(Fonts.selectCountry.tr,
                    style: AppCommonLayout().poppinsTextStyle(color:appTheme.sameWhite,fontSize: 18)),
                elevation: 0,
                backgroundColor: appTheme.primary),
            pickerBuilder: (context, CountryCode? countryCode) {
              return Row(children: [
                Text(dialCode ??"",
                    style: AppCommonLayout().poppinsTextStyle(color:appTheme.greyText))
                    .paddingSymmetric(horizontal: 5),
                Icon(CupertinoIcons.chevron_down,
                    size: 16, color: appTheme.greyText)
              ]);
            },
            theme: CountryTheme(
                alphabetSelectedBackgroundColor: appTheme.primary),
            initialSelection:dialCode ?? "+91",
            onChanged: onChanged)).decorated(
        color: appTheme.greyText.withValues(alpha:0.05),
        border:
        Border.all(color: appTheme.greyText.withValues(alpha:0.15)),
        borderRadius: const BorderRadius.all(Radius.circular(8)));
  }
}
