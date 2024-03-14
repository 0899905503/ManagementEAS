import 'package:get/get.dart';
import 'package:meas/UI/Homepage/home_page_view.dart';
import 'package:meas/UI/Login/signin/signin_view.dart';
import 'package:meas/UI/choose_app_screen.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String signIn = "/signin";
  static const String home = "/home";

  ///==============================Timekeeping app==================================
  static const String chooseAppScreen = "/chooseAppScreen";
  static const String tkHomePage = "/tkHomePage";
  static const String employeeList = "/employeeList";
  // MEAS ======================================================================================================
  static const String managementSalary = "/salary";
  static const String managementEmployee = "/managementEmployee";
  static const String profile = "profile";
  static const String notification = "/notification";
  static const String personalInformation = "personalInformation";
  static const String relativeInformation = "relativeInformation";
  static const String relative = "relative";
  static const String listRelative = "listRelative";
  //============================================================================================================

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    // GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: home, page: () => const Signin()),

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
    // GetPage(name: managementEmployee, page: () => HomePage()),
    // GetPage(name: managementSalary, page: () => salary()),
  ];
}
