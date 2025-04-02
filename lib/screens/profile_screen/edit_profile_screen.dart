import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';
import 'edit_profile_controller.dart';
import 'layouts/common_circle_image_layout.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenController signInCtrl =
        Get.put(ProfileScreenController());

    return GetBuilder<ProfileScreenController>(builder: (_) {
      return PopScope(
        canPop: false,
        child: Stack(
          children: [
            Scaffold(
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                appBar: AppBar(
                  centerTitle: true,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  title: Text(
                      Fonts.updateProfile.tr,
                      style: Get.theme.textTheme.displaySmall!
                          .copyWith(fontSize: 22)),
                  leadingWidth: 60,

                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: signInCtrl.signUpKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(Fonts.updateProfile.tr,style: AppCommonLayout().mulishFW400Or500TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appTheme.black,
                            fontSize: 15
                          ),),
                          VSpace(15),
                          CommonCircleImageLayout(
                              height: 111,
                              width: 111,
                              isImage: true,
                              isCircle: true,
                              networkImage: signInCtrl.image,
                              fileImage: signInCtrl.imageFile != null
                                  ? File(signInCtrl.imageFile!.path)
                                  : null).inkWell(onTap: () => signInCtrl.pickImage())
                              .center(),
                          VSpace(35),
                          TextFieldCommon(hintText: Fonts.name.tr,
                            controller: signInCtrl.nameCtrl,
                            validator: (p0) => Validation().nameValidation(p0),
                          ),
                          VSpace(20),
                          TextFieldCommon(
                            hintText: Fonts.email.tr,
                            controller: signInCtrl.emailCtrl,
                            validator: (p0) => Validation().emailValidation(p0),
                          ),


                          VSpace(60),
                          appButton(Fonts.updateProfile.tr,
onTap: ()=> signInCtrl.uploadFile(),
                              color: Get.theme.primaryColor,
                              height: 60,
                              style: AppCommonLayout().poppinsTextStyle(
                                  color: appTheme.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          VSpace(16)
                        ]).paddingSymmetric(
                        horizontal: 20,
                        vertical: 12),
                  ),
                )),
            if (signInCtrl.isLoading)
              AppWidgets.getLoadingView()
                  .backgroundColor(appTheme.greyText.withValues(alpha: .30))
          ],
        ),
      );
    });
  }
}
