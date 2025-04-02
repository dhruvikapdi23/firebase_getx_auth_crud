
import 'package:firebase_getx_auth_crud/controllers/otp_controller.dart';
import 'package:firebase_getx_auth_crud/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../controllers/login_controller.dart';
import '../login_screen/layouts/otp_layout.dart';

class OtpScreen extends StatelessWidget {
  final otpCtrl = Get.put(OtpController());

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (_) {
      return Container(
          color: Colors.transparent,
          child: SafeArea(
              top: false,
              child: Scaffold(
                  body: Stack(children: [
                SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Stack(
                        children: [
                          Image.asset(imgAssets.loginImage),
                          if (otpCtrl.verificationCode != null)
                            BackButton(
                                    color: appTheme.black,
                                    onPressed: () {
                                      if (otpCtrl.verificationCode !=
                                          null) {
                                        otpCtrl.verificationCode = null;
                                        otpCtrl.update();
                                        Get.back();
                                      }
                                    })
                                .paddingSymmetric(
                                    vertical: 55, horizontal: 15),
                        ],
                      ),
                      const VSpace(20),
                      Form(
                        key: otpCtrl.otpGlobalKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Fonts.otpVerification.tr,
                                style: AppCommonLayout().poppinsTextStyle(
                                    color: appTheme.primary)),
                            const VSpace(8),
                            Row(children: [
                              Text(Fonts.otpSentTo.tr,
                                  style: AppCommonLayout().poppinsTextStyle(
                                      color: appTheme.greyText)),
                              Text(
                                  "${otpCtrl.dialCode} ${otpCtrl.number.toString()}",
                                  style: AppCommonLayout().poppinsTextStyle(
                                      color: appTheme.greyText))
                            ]),
                            const VSpace(25),
                            Text(Fonts.otp.tr,
                                style: AppCommonLayout().poppinsTextStyle(
                                    color: appTheme.darkText)),
                            const VSpace(10),
                            OtpLayout(
                                controller: otpCtrl.otpController,
                                validator: (value) => Validation()
                                    .otpValidation(value),
                                onSubmitted: (val) {
                                  otpCtrl.otpController.text = val;
                                },
                                defaultPinTheme: otpCtrl.defaultPinTheme,
                                errorPinTheme: otpCtrl.defaultPinTheme
                                    .copyWith(
                                        decoration: BoxDecoration(
                                            color: appTheme.white,
                                            border:
                                                Border.all(
                                                    color: appTheme.redColor),
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                focusedPinTheme: otpCtrl.defaultPinTheme
                                    .copyWith(
                                        height: 48,
                                        width: 55,
                                        decoration: otpCtrl
                                            .defaultPinTheme.decoration!
                                            .copyWith(
                                                color: appTheme.greyText
                                                    .withValues(alpha: 0.05),
                                                border: Border.all(
                                                    color:
                                                        appTheme.primary)))),
                            const VSpace(55),
                            appButton(Fonts.verify.tr,
                                onTap: () => otpCtrl.onFormSubmitted()),
                            const VSpace(12),
                            RichText(
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: Fonts.notReceived.tr,
                                        style: AppCommonLayout()
                                            .poppinsTextStyle(
                                                color: appTheme.greyText)
                                            .textHeight(1.3),
                                        children: [
                                          TextSpan(
                                              text: Fonts.resendIt.tr,
                                              style: AppCommonLayout()
                                                  .poppinsTextStyle(
                                                      color:
                                                          appTheme.darkText)
                                                  .textHeight(1.3))
                                        ]))
                                .alignment(Alignment.center)
                                .inkWell(onTap: () => otpCtrl.resendCode())
                          ],
                        ).paddingSymmetric(horizontal: 20),
                      )
                    ])),
                if (otpCtrl.isLoading) AppWidgets.getLoadingView(),
              ]))));
    });
  }
}
