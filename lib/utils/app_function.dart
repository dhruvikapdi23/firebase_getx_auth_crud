import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_getx_auth_crud/utils/session.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

class AppFunctions {
  // static String timestampToDateTime(String timestamp) {
  //   var date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
  //   final f = DateFormat('dd MMM yyyy hh:mm a');
  //   return f.format(date).toString();
  // }

  GetStorage storage = GetStorage();

  static Future<bool> checkInternet() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return true;
    }
    return false;
  }

  getLoggedUserId() {
    dynamic user = storage.read(Session.user);
    return user != null ? user['user_id'] : null;
  }

  getLoggedUser() {
    dynamic user = storage.read(Session.user);
    return user;
  }

  getLoggedUserImage() {
    dynamic user = storage.read(Session.user);
    return user != null ? user['profile_image'] : null;
  }


  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString';
  }

  // Method to format the seconds into minutes and seconds
  static String getFormattedTime(seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  removeSession() {
    storage.remove(Session.user);
    Get.forceAppUpdate();
  }


  List phoneList({
    String? phone,
    String? dialCode,
  }) {
    List list = [
      '+${dialCode!.substring(1)}$phone',
      '+${dialCode.substring(1)}-$phone',
      '${dialCode.substring(1)}-$phone',
      '${dialCode.substring(1)}$phone',
      '0${dialCode.substring(1)}$phone',
      '0$phone',
      '$phone',
      '+$phone',
      '+${dialCode.substring(1)}--$phone',
      '00$phone',
      '00${dialCode.substring(1)}$phone',
      '+${dialCode.substring(1)}-0$phone',
      '+${dialCode.substring(1)}0$phone',
      '${dialCode.substring(1)}0$phone',
    ];
    return list;
  }

}
