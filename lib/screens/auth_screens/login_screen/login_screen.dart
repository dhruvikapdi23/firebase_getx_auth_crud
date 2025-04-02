import 'package:country_list_pick/support/code_country.dart';
import 'package:firebase_getx_auth_crud/assets/index.dart';
import 'package:firebase_getx_auth_crud/extension/text_style_extensions.dart';
import 'package:firebase_getx_auth_crud/extension/widget_extension.dart';
import 'package:firebase_getx_auth_crud/utils/common_app_layout.dart';

import 'package:firebase_getx_auth_crud/utils/theme_service.dart';
import 'package:firebase_getx_auth_crud/widgets/app_btn.dart';
import 'package:firebase_getx_auth_crud/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controllers/login_controller.dart';
import '../../../extension/spacing.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/text_field_common.dart';
import '../../../widgets/validation.dart';
import 'layouts/country_list_layout.dart';
import 'layouts/otp_layout.dart';

class LoginScreen extends StatelessWidget {
  final loginCtrl = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          if (loginCtrl.verificationCode != null) {
            loginCtrl.verificationCode = null;
            loginCtrl.update();
            Get.back();
          } else {
            SystemNavigator.pop();
          }
        },
        child: Container(
          color: Colors.transparent,
          child: SafeArea(
            top: false,
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(imgAssets.loginImage),
                            if (loginCtrl.verificationCode != null)
                              BackButton(
                                      color: appTheme.black,
                                      onPressed: () {
                                        if (loginCtrl.verificationCode !=
                                            null) {
                                          loginCtrl.verificationCode = null;
                                          loginCtrl.update();
                                          Get.back();
                                        }
                                      })
                                  .paddingSymmetric(
                                      vertical: 55, horizontal: 15),
                          ],
                        ),
                        const VSpace(20),
                        Form(
                            key: loginCtrl.mobileGlobalKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Fonts.login.tr,
                                      style: AppCommonLayout().poppinsTextStyle(
                                          fontSize: 18,
                                          color: appTheme.primary)),
                                  VSpace(8),
                                  Text(Fonts.phoneNumber.tr,
                                      style: AppCommonLayout().poppinsTextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const VSpace(8),
                                  IntrinsicHeight(
                                    child: Row(children: [
                                      CountryListLayout(
                                          dialCode: loginCtrl.dialCode,
                                          onChanged: (CountryCode? code) {
                                            loginCtrl.dialCode =
                                                code!.dialCode!;
                                            loginCtrl.update();
                                          }),
                                      const HSpace(10),
                                      Expanded(
                                          child: TextFieldCommon(
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (phone) => Validation()
                                                  .phoneValidation(phone),
                                              controller:
                                                  loginCtrl.numberController,
                                              hintText: Fonts.phoneNumber.tr))
                                    ]),
                                  ),
                                  const VSpace(50),
                                  appButton(Fonts.getOtp.tr).inkWell(
                                      onTap: () => loginCtrl.onTapOtp())
                                ]).paddingSymmetric(horizontal: 20).height(
                                Get.height))
                      ],
                    ),
                  ),
                  if (loginCtrl.isLoading) AppWidgets.getLoadingView(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
