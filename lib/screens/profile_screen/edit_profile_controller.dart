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

class ProfileScreenController extends GetxController {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  XFile? imageFile;
  String? image;
  dynamic user;
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GetStorage storage = GetStorage();
  bool isObscureText = true, isConfirmObscureText = true;

  passwordHideShow() {
    isObscureText = !isObscureText;
    update();
  }

  bool isLoading = false;

  pickImage() {
    AppDialogs().showLayout(onTap: (p0) {
      if (p0 == Fonts.chooseFromGallery) {
        getImage(ImageSource.gallery);
      } else {
        getImage(ImageSource.camera);
      }
    });
  }

// GET IMAGE FROM GALLERY
  Future getImage(source) async {
    final ImagePicker picker = ImagePicker();
    imageFile = (await picker.pickImage(source: source))!;
    log("imageFile :$imageFile");
    update();
    if (imageFile != null) {
      // updateProfile(context);
      Get.back();
    }
  }

  // UPLOAD SELECTED IMAGE TO FIREBASE
  Future uploadFile() async {
    if (signUpKey.currentState!.validate()) {
     if(imageFile !=null){
       isLoading = true;
       update();
       String fileName = DateTime
           .now()
           .millisecondsSinceEpoch
           .toString();
       Reference reference = FirebaseStorage.instance.ref().child(fileName);
       log("reference : $reference");
       var file = File(imageFile!.path);
       UploadTask uploadTask = reference.putFile(file);

       uploadTask.then((res) {
         log("res : $res");
         res.ref.getDownloadURL().then((downloadUrl) async {
           user['image'] = downloadUrl;
           await storage.write(Session.user, user);
           image = downloadUrl;
           log(user["id"]);
           updateProfile();
           isLoading = false;
           update();
           log("IMAGE $image");

           update();
         }, onError: (err) {
           update();
           AppDialogs.errorSnackBar('Image is Not Valid');
         });
       });
     }else{
       AppDialogs.errorSnackBar("Please Select Image");
     }
    }
  }

  updateProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(user["id"])
          .update(
              {"name": nameCtrl.text, "email": emailCtrl.text, "photo": image});
      Get.offAllNamed(RouteName().dashboard);
    } catch (e) {
      AppDialogs.errorSnackBar(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    user = storage.read(Session.user);
    log("USER:$user");

    super.onInit();
  }
}
