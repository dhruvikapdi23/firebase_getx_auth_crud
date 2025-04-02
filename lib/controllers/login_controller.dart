import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx_auth_crud/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> mobileGlobalKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpGlobalKey = GlobalKey<FormState>();
  bool isLoading = false, isContactLoad = false;
  String? userName, verificationCode, resendCodeID;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> contactsData = [];
  List<Map<String, dynamic>> unRegisterContactData = [];
  String dialCode = '+91';
  GetStorage storage = GetStorage();

  onTapOtp() async {
    if (mobileGlobalKey.currentState!.validate()) {
      // Otp Method
      isLoading = true;
      update();
      debugPrint("log 1 ${numberController.text.toString()}");
      update();

      debugPrint(
          "NUMBER : '${dialCode ?? "+91"}${numberController.text.toString()}'");
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$dialCode${numberController.text.toString()}',
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint("log 4 $credential");
          isLoading = false;
          update();
        },
        timeout: const Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("log 5 $e");
          isLoading = false;
          update();
          /*snackBar(
              e.message,
              context: Get.context!,
            );*/
        },
        codeSent: (String verificationId, int? resendToken) async {
          resendCodeID = verificationId;
          verificationCode = verificationId;
          debugPrint("log 2 $verificationId");
          var phoneUser = FirebaseAuth.instance.currentUser;
          debugPrint("log 3 $phoneUser");
          userName = phoneUser?.phoneNumber;
          isLoading = false;
          update();
          Get.toNamed(RouteName().otpScreen,arguments: {
            "number":numberController.text,
            "dialCode":dialCode,
            "verificationCode":verificationCode
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading = false;
          update();
          log("SOMETHING");
        },
      );
    }
  }
}
