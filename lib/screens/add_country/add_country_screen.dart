import 'dart:io';

import 'package:firebase_getx_auth_crud/screens/add_country/add_country_controller.dart';
import 'package:firebase_getx_auth_crud/screens/add_country/add_country_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';

class AddCountryScreen extends StatelessWidget {
  const AddCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddCountryScreenController addCountryCtrl =
        Get.put(AddCountryScreenController());

    return GetBuilder<AddCountryScreenController>(builder: (_) {
      return Stack(
        children: [
          Scaffold(
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,

                surfaceTintColor: Colors.transparent,
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                title: Text(Fonts.addCountry.tr,
                    style: Get.theme.textTheme.displaySmall!
                        .copyWith(fontSize: 22)),
                leadingWidth: 60,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: addCountryCtrl.signUpKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldCommon(
                          hintText: Fonts.name.tr,
                          controller: addCountryCtrl.nameCtrl,
                          validator: (p0) => Validation().nameValidation(p0),
                        ),
                        VSpace(20),
                        TextFieldCommon(
                          hintText: Fonts.capital.tr,
                          controller: addCountryCtrl.capitalCtrl,
                        ),
                        VSpace(20),
                        TextFieldCommon(
                          hintText: Fonts.region.tr,
                          controller: addCountryCtrl.regionCtrl,
                        ),
                        VSpace(20),
                        TextFieldCommon(
                          hintText: Fonts.population.tr,
                          keyboardType: TextInputType.number,
                          controller: addCountryCtrl.populationCtrl,
                        ),
                        VSpace(60),
                        appButton(Fonts.addCountry.tr,
                            color: Get.theme.primaryColor,
                            onTap: ()=> addCountryCtrl.addData(),
                            height: 60,
                            style: AppCommonLayout().poppinsTextStyle(
                                color: appTheme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        VSpace(16)
                      ]).paddingSymmetric(horizontal: 20, vertical: 12),
                ),
              )),
          if (addCountryCtrl.isLoading)
            AppWidgets.getLoadingView()
                .backgroundColor(appTheme.greyText.withValues(alpha: .30))
        ],
      );
    });
  }
}
