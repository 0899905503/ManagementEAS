import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/UI/EmployeeList/employeelist_view.dart';
import 'package:meas/UI/EmployeeList/employeelist_viewmodel.dart';
import 'package:meas/UI/Homepage/home_page_view.dart';
import 'package:meas/UI/Login/signin/signin_view.dart';
import 'package:meas/UI/Personal_information.dart/Personal_information_view.dart';
import 'package:meas/UI/Profile/profile_view.dart';
import 'package:meas/UI/Profile/profile_viewmodel.dart';
import 'package:meas/UI/RelativeList/relativeInformation.dart';
import 'package:meas/UI/RelativeList/relativelist_view.dart';
import 'package:meas/UI/RelativeList/relativelist_viewmodel.dart';
import 'package:meas/UI/choose_app_screen.dart';
import 'package:meas/UI/main_page/main_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:html';

import 'package:provider/provider.dart';

// void main() {
//   // await dotenv.load(fileName: ".env");
//   runApp(GetMaterialApp(
//     // Your app configurations...
//     home: MyApp(),
// getPages: [
//   GetPage(name: '/chooseAppScreen', page: () => const ChooseAppScreen()),
//   GetPage(name: '/managementEmployee', page: () => const HomePage()),
//   GetPage(name: '/employeeList', page: () => const EmployeeList()),
//   GetPage(name: '/profile', page: () => const TkProfilePage()),
//   GetPage(
//       name: '/personalInformation', page: () => const TkPersonalIFPage()),
// ],
//   ));
// }
// void main() {
//   // await dotenv.load(fileName: ".env");
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => EmployeeListViewModel(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: EmployeeList(),
//     );
//   }
// }
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeListViewModel()),
        ChangeNotifierProvider(create: (_) => RelativeListViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: Builder(
        builder: (context) {
          // Use GetMaterialApp here to access providers
          return GetMaterialApp(
            home: Signin(),
            getPages: [
              GetPage(name: '/signin', page: () => const Signin()),
              GetPage(
                  name: '/chooseAppScreen',
                  page: () => const ChooseAppScreen()),
              GetPage(
                  name: '/managementEmployee', page: () => const HomePage()),
              GetPage(name: '/employeeList', page: () => const EmployeeList()),
              GetPage(name: '/profile', page: () => const TkProfilePage()),
              GetPage(
                  name: '/personalInformation',
                  page: () => const TkPersonalIFPage()),
              GetPage(
                  name: '/relativeInformation',
                  page: () => const RelativeIFPage()),
              GetPage(name: '/relative', page: () => const RelativeList()),
              GetPage(name: '/listRelative', page: () => const RelativeList()),
            ],
          );
        },
      ),
    );
  }
}
