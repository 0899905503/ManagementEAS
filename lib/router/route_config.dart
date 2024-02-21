import 'package:flutter_base/UI/Employee/choose_app_screen.dart';
import 'package:flutter_base/UI/Employee/home_page/home_page.dart';
import 'package:flutter_base/UI/Employee/profile_page/tk_profile_page.dart';
import 'package:flutter_base/UI/Salary/Sum/salary.dart';
import 'package:get/get.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String signIn = "/signIn";
  static const String home = "/home";

  ///==============================Timekeeping app==================================
  static const String chooseAppScreen = "/chooseAppScreen";
  static const String tkHomePage = "/tkHomePage";
  // MEAS ======================================================================================================
  static const String managementSalary = "/salary";
  static const String managementEmployee = "/homepage";
  static const String profile = "TkProfilePage";
  static const String notification = "/notification";
  //============================================================================================================

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    // GetPage(name: signIn, page: () => const SignInPage()),
    // GetPage(name: home, page: () => const HomePage()),

    ///===================Timekeeping App=============================

    GetPage(
      name: chooseAppScreen,
      page: () => const ChooseAppScreen(),
    ),
    GetPage(
      name: tkHomePage,
      page: () => const HomePage(
          // arguments: Get.arguments,
          ),
    ),

    //MEAS =============================================================================================
    GetPage(name: managementEmployee, page: () => HomePage()),
    GetPage(name: managementSalary, page: () => salary()),
  ];
}
