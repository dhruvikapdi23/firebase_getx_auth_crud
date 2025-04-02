import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../config.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkData();
    super.onInit();
  }

  void checkData() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        final storage = GetStorage();


        dynamic user = storage.read(Session.user);

        if (user != null) {
          Get.offAndToNamed(RouteName().dashboard);
        } else {
          Get.offAndToNamed(RouteName().loginScreen);
        }
      },
    );
  }
}
