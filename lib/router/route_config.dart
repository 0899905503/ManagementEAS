import 'package:flutter_base/UI/Employee/choose_app_screen.dart';
import 'package:flutter_base/UI/Employee/home_page/home_page.dart';
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
  static const String tkTakeLeavePage = "/tkTakeLeavePage";
  static const String tkWorkLatePage = "/tkWorkLatePage";
  static const String tkTimekeepingHistoryPage = "/tkTimekeepingHistoryPage";
  static const String tkProfilePage = "/tkProfilePage";
  static const String tkChangePassword = "/tkChangePassword";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    // GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: home, page: () => const Homepage()),

    ///===================Timekeeping App=============================

    GetPage(
      name: chooseAppScreen,
      page: () => const ChooseAppScreen(),
    ),
    GetPage(
      name: tkHomePage,
      page: () => const Homepage(
          // arguments: Get.arguments,
          ),
    ),

    // GetPage(
    //   name: tkTimekeepingHistoryPage,
    //   page: () => const TkTimekeepingHistoryPage(
    //       // arguments: Get.arguments,
    //       ),
    // ),
    // GetPage(name: tkHomePage, page: () => const TkChangePassword()),
    // GetPage(name: tkChangePassword, page: () => const TkChangePassword()),
  ];
}
