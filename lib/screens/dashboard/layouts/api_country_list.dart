import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_getx_auth_crud/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../config.dart';
import '../../../models/country_model.dart';

class ApiCountryList extends StatelessWidget {
  const ApiCountryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dash) {
      return PagingListener(
        controller: dash.pagingController!,
        builder: (context, state, fetchNextPage) =>
            PagedListView<int, CountryModel>(
          state: state,
              shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => Row(
              children: [
                CachedNetworkImage(
                  imageUrl: item.flags!.png!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill)),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                ),
                HSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name!.official!),
                      Text("Population : ${item.population!.toString()}"),
                      if (item.capital != null)
                        Text("Capital : ${item.capital!.toString()}"),
                      Text("Region : ${item.region!.toString()}"),
                    ],
                  ),
                )
              ],
            ).marginOnly(bottom: 20),
          ),
        ),
      ).paddingSymmetric(horizontal: 20);
    });
  }
}
