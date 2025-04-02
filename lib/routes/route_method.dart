



import 'package:firebase_getx_auth_crud/screens/add_country/add_country_screen.dart';
import 'package:firebase_getx_auth_crud/screens/auth_screens/otp_screen/otp_screen.dart';
import 'package:firebase_getx_auth_crud/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_getx_auth_crud/screens/profile_screen/edit_profile_screen.dart';
import 'package:get/get.dart';

import '../screens/auth_screens/login_screen/login_screen.dart';
import 'route_name.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [

    GetPage(name: _routeName.loginScreen, page: () => LoginScreen(),transition: Transition.downToUp),
    GetPage(name: _routeName.otpScreen, page: () => OtpScreen(),transition: Transition.downToUp),
    GetPage(name: _routeName.profileSetupScreen, page: () => EditProfileScreen(),transition: Transition.downToUp),
    GetPage(name: _routeName.dashboard, page: () => DashboardScreen(),transition: Transition.downToUp),
    GetPage(name: _routeName.addCountry, page: () => AddCountryScreen(),transition: Transition.rightToLeftWithFade),


  ];
}
