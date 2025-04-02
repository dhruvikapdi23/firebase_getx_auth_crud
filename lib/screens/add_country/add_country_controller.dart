import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/utils/collection_name.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddCountryScreenController extends GetxController {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController capitalCtrl = TextEditingController();
  TextEditingController regionCtrl = TextEditingController();
  TextEditingController populationCtrl = TextEditingController();
bool isLoading =false;
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GetStorage storage = GetStorage();

  addData() async {
    try {
      isLoading =true;
      update();
      await FirebaseFirestore.instance
          .collection(CollectionName.customCountries)
          .add({
        "name": nameCtrl.text,
        "capital": capitalCtrl.text,
        "region": regionCtrl.text,
        "population": populationCtrl.text
      });
      isLoading =false;
      update();
      Get.back();
    } on FirebaseException catch (e) {
      AppDialogs.errorSnackBar(e.toString());
    }
  }
}
