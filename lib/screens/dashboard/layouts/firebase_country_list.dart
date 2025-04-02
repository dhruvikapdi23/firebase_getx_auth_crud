import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx_auth_crud/controllers/dashboard_controller.dart';
import 'package:firebase_getx_auth_crud/utils/collection_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../config.dart';
import '../../../models/country_model.dart';

class FirebaseCountryList extends StatelessWidget {
  const FirebaseCountryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dash) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(CollectionName.customCountries)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              physics: NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                dynamic data = snapshot.data!.docs[index].data();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['name']),
                    Text("Population : ${data['population']}"),
                    Text("Capital : ${data['capital']}"),
                    Text("Region : ${data['region']}"),
                  ],
                ).marginOnly(bottom: 20);
              },
            );
          } else {
            return Container();
          }
        },
      ).paddingSymmetric(horizontal: 20);
    });
  }
}
