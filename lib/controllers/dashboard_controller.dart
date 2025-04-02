import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx_auth_crud/api_helpers/api_utils.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/models/country_model.dart';
import 'package:firebase_getx_auth_crud/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../api_helpers/api_manager.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSearch = false.obs;
  RxBool isAscending = false.obs;
  GetStorage storage = GetStorage();
  static const int _pageSize = 20;
  List<CountryModel> allCountries = []; //
  List<CountryModel> filteredCountries = [];

// Full dataset
  TextEditingController search = TextEditingController();
  PagingController<int, CountryModel>? pagingController;

  @override
  void onInit() {
    // TODO: implement onInit
    _fetchAllData();
    super.onInit();
  }

  Future<void> _fetchAllData() async {
    try {
      allCountries = await getCountryList();
      filteredCountries = allCountries;
      log("allCountries:${allCountries.length}");
      update();
      setupPagingController();
    } catch (e) {}
  }

  void onChange() {
    if (search.text.isNotEmpty) {
      allCountries = filteredCountries
          .where((country) => country.name!.official!
              .toLowerCase()
              .contains(search.text.toLowerCase()))
          .toList();
      update();
      log("filteredCountries:${allCountries.length}");
    } else {
      allCountries = filteredCountries;
      update();
    }
    setupPagingController();
  }

  sorting() {
    allCountries.sort((a, b) => isAscending.value
        ? a.population!.compareTo(b.population!)
        : b.population!.compareTo(a.population!));
    update();
    setupPagingController();
  }

  searchTap() {
    isSearch.value = !isSearch.value;
    update();
  }

  void setupPagingController() {
    pagingController = null;
    log("allCountries :${allCountries.length}");
    update();

    pagingController = PagingController<int, CountryModel>(
      getNextPageKey: (state) {
        log("state :$state");
        final lastKey = state.keys != null ? state.keys!.last : 0;
        return (lastKey + 1) * _pageSize < allCountries.length
            ? lastKey + 1
            : 0;
      },
      fetchPage: (pageKey) async =>
          await _fetchPage(pageKey), // Use lambda function
    );
    update();
  }

  Future<List<CountryModel>> _fetchPage(int pageKey) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    final int startIndex = pageKey * _pageSize;
    final int endIndex = startIndex + _pageSize;

    if (startIndex >= allCountries.length) return [];

    return allCountries.sublist(
      startIndex,
      endIndex > allCountries.length ? allCountries.length : endIndex,
    );
  }

  Future<List<CountryModel>> getCountryList() async {
    List<CountryModel> highList = [];
    try {
      var value = await ApiManager.callGet(
          method: "get", endPoint: ApiUtils.country); // Wait for API response

      update();
      log("highList :$value");
      if (value != null) {
        List list = jsonDecode(value);
        for (var d in list) {
          CountryModel bookVersionListModel = CountryModel.fromJson(d);

          if (!highList.contains(bookVersionListModel)) {
            highList.add(bookVersionListModel);
          }
        }
        log("highList :$highList");
        update();
      } else {
        log(value['message']);
      }
    } catch (e) {
      log("AA :$e");
    }

    return highList; // Ensure bookList is returned properly
  }

  logout(){
    storage.remove(Session.user);
    storage.remove(Session.isLogin);
    storage.remove(Session.isDarkMode);
    FirebaseAuth.instance.signOut();
   Get.offAllNamed(RouteName().loginScreen);
  }
}
