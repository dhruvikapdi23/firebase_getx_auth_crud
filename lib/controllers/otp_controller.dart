import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx_auth_crud/routes/route_name.dart';
import 'package:firebase_getx_auth_crud/utils/app_function.dart';
import 'package:firebase_getx_auth_crud/utils/common_app_layout.dart';
import 'package:firebase_getx_auth_crud/widgets/app_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';

import '../utils/collection_name.dart';
import '../utils/session.dart';
import '../utils/theme_service.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpGlobalKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? userName, verificationCode, resendCodeID, number;
  FirebaseAuth auth = FirebaseAuth.instance;
  String dialCode = '+91';
  GetStorage storage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    dynamic data = Get.arguments;
    number = data['number'];
    dialCode = data['dialCode'];
    verificationCode = data['verificationCode'];
    update();

    super.onInit();
  }

  resendCode() async {
    isLoading = true;
    update();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${dialCode ?? "+91"}${number.toString()}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        resendCodeID = verificationId;
        verificationCode = verificationId;
        debugPrint("log 2 $resendCodeID");
        var phoneUser = FirebaseAuth.instance.currentUser;
        debugPrint("log 3 $phoneUser");
        userName = phoneUser?.phoneNumber;
        isLoading = false;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    update();
  }

  //on form submit
  void onFormSubmitted() async {
    log("otpGlobalKey.currentState!.validate() : ${otpGlobalKey.currentState!.validate()}");

    if (otpGlobalKey.currentState!.validate()) {
      isLoading = true;
      update();

      debugPrint("verificationCode : $verificationCode");
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationCode!, smsCode: otpController.text);

      auth
          .signInWithCredential(authCredential)
          .then((UserCredential value) async {
        debugPrint("value : ${value.user}");
        if (value.user != null) {
          User authUser = value.user!;
          dynamic user;
          update();

          FirebaseFirestore.instance
              .collection(CollectionName.users)
              .where("id", isEqualTo: authUser.uid)
              .limit(1)
              .get()
              .then((value) async {
            dynamic resultData = await getUserData(authUser);
            debugPrint("checkkkkkk : ${value.docs.isEmpty}");
            if (value.docs.isNotEmpty) {
              debugPrint("NAME : ${value.docs[0].data()}");
              if (value.docs[0].data()["name"] == "") {
                await storage.write(Session.user, resultData);

                Get.offAllNamed(RouteName().profileSetupScreen,
                    arguments: {'dialCode': dialCode, 'phone': number});
              } else {
                await storage.write(Session.user, value.docs[0].data());

                storage.write(Session.id, value.docs[0].data()["id"]);
                user = value.docs[0].data();
                update();
                homeNavigation(value.docs[0].data());
              }
            } else {
              await userRegister(authUser);
              dynamic resultData = await getUserData(authUser);

              if (resultData["name"] == "") {
                user = resultData;
                update();
                await storage.write(Session.user, resultData);
                Get.offAllNamed(RouteName().profileSetupScreen,
                    arguments: {"resultData": resultData});

                update();
              } else {
                debugPrint("DATA NAME READ");
                await storage.write(Session.user, value.docs[0].data());
                storage.write(Session.id, value.docs[0].data()["id"]);
                user = value.docs[0].data();
                update();
                homeNavigation(resultData);
              }
            }
            isLoading = false;
            update();
          }).catchError((err) {
            isLoading = false;
            update();
            debugPrint("err : ${err.toString()}");
            String? errorMessage;
            if (err is FirebaseException) {
              log("err.code :${err.code}");
              if (err.code == 'permission-denied') {
                errorMessage =
                    err.message;
              } else {
                errorMessage = "An error occurred. Please try again.";
              }
              AppDialogs.errorSnackBar(errorMessage!);
            }
          });
        } else {
          isLoading = false;
          update();
          AppDialogs.errorSnackBar("SOMETHING WENT WRONG");
        }
      }).catchError((e) {
        isLoading = false;
        update();
        debugPrint("err : ${e.toString()}");
        String? errorMessage;
        if (e is FirebaseAuthException) {
          if (e.code == 'invalid-verification-code') {
            errorMessage =
                "The OTP entered is incorrect. Please check and try again.";
          } else if (e.code == 'session-expired') {
            errorMessage =
                "The OTP session has expired. Please request a new OTP.";
          } else {
            errorMessage = "An error occurred. Please try again.";
          }
        }
        AppDialogs.errorSnackBar(errorMessage!);
      });
    }

    update();
  }

  Future<Object?> getUserData(User user) async {
    final result = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(user.uid)
        .get();
    dynamic resultData;
    if (result.exists) {
      Map<String, dynamic>? data = result.data();
      resultData = data;
      return resultData;
    }
    return resultData;
  }

  homeNavigation(user) async {
    await storage.write(Session.user, user);
    Get.forceAppUpdate();
    Get.offAllNamed(RouteName().dashboard);
  }

  //user register
  userRegister(User user) async {
    log(" : $user");
    try {
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(user.uid)
          .set({
        'id': user.uid,
        'image': "",
        'name': "",
        'dialCode': dialCode,
        "email": user.email,
        'phone': "$dialCode$number",
        "createdDate": DateTime.now().millisecondsSinceEpoch
      }).catchError((err) {
        debugPrint("fir : $err");
      });
    } on FirebaseAuthException catch (e) {
      debugPrint("firebase : $e");
    }
  }

  final defaultPinTheme = PinTheme(
      textStyle: AppCommonLayout().poppinsTextStyle(
          color: appTheme.greyText, fontSize: 18, fontWeight: FontWeight.bold),
      width: 55,
      height: 48,
      decoration: BoxDecoration(
          color: appTheme.greyText.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appTheme.greyText.withOpacity(0.15))));

  @override
  void onReady() async {
    // pref = Get.arguments;

    super.onReady();
  }
}
