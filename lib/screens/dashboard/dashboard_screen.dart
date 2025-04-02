import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/models/country_model.dart';
import 'package:firebase_getx_auth_crud/screens/dashboard/layouts/api_country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controllers/dashboard_controller.dart';
import 'common_action_icon.dart';
import 'layouts/firebase_country_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dash = Get.put(DashboardController());
    return GetBuilder<DashboardController>(builder: (_) {
      return Scaffold(
          appBar: AppBar(
              title: Text("Country List"),
              centerTitle: true,
              leading: Icon( ThemeService().theme == ThemeMode.dark?Icons.wb_sunny : Icons.nightlight_round).inkWell(onTap: (){
                ThemeService().switchTheme();
              }),
              actions: [
                if (!dash.isSearch.value)
                  SvgPicture.asset(
                    svgAssets.search,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        appTheme.black, BlendMode.srcIn),
                  ).inkWell(onTap: () => dash.searchTap()),
                IconButton(
                    icon: Icon(dash.isAscending.value
                        ? Icons.arrow_upward
                        : Icons.arrow_downward),
                    onPressed: () => dash.sorting()),

                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () => dash.logout()),
              ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed(RouteName().addCountry),
            backgroundColor: appTheme.primary,
            child: Icon(Icons.add, color: appTheme.white),
          ),
          body: dash.pagingController == null
              ? AppWidgets.getLoadingView()
              : SingleChildScrollView(
                child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (dash.isSearch.value)
                        TextFieldCommon(
                          controller: dash.search,
                          hintText: Fonts.search.tr,
                          onChanged: (v) => dash.onChange(),
                          suffixIcon: SvgPicture.asset(svgAssets.search,
                                  height: 20, fit: BoxFit.scaleDown)
                              .paddingOnly(right: 20)
                              .inkWell(onTap: () => dash.searchTap()),
                        ).paddingSymmetric(horizontal: 20).marginOnly(bottom: 14),
                      Text(Fonts.listFromFirebase,style: AppCommonLayout().poppinsTextStyle(
                        fontSize: 18,
                
                
                      ),).paddingSymmetric(horizontal: 20),
                      VSpace(20),
                      FirebaseCountryList(),
                      VSpace(20),
                
                      Text(Fonts.listFromApi,style: AppCommonLayout().poppinsTextStyle(
                        fontSize: 18,
                
                
                      ),).paddingSymmetric(horizontal: 20),
                      VSpace(20),
                      ApiCountryList(),
                    ],
                  ),
              ));
    });
  }
}
