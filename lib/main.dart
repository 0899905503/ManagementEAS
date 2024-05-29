import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_view.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_viewmodel.dart';

import 'package:meas/UI/Employee/Homepage/home_page_view.dart';
import 'package:meas/UI/Employee/ListRelative/ListRelative_view.dart';
import 'package:meas/UI/Employee/ListRelative/ListRelative_viewmodel.dart';
import 'package:meas/UI/Employee/ListRelative/profileRelative.dart';
import 'package:meas/UI/Employee/Login/signin/signin_view.dart';
import 'package:meas/UI/Employee/Personal_information.dart/Personal_information_view.dart';
import 'package:meas/UI/Employee/Profile/profile_view.dart';
import 'package:meas/UI/Employee/Profile/profile_viewmodel.dart';
import 'package:meas/UI/Employee/RelativeList/relativeInformation.dart';
import 'package:meas/UI/Employee/RelativeList/relativelist_view.dart';
import 'package:meas/UI/Employee/RelativeList/relativelist_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_infor/salary_infor_view.dart';
import 'package:meas/UI/Salary/Salary_infor/salary_infor_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_ranking/salary_rank_view.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_view.dart';
import 'package:meas/UI/Salary/salary_history/salary_history_view.dart';
import 'package:meas/UI/Salary/salary_homepage/salary_home_page_view.dart';
import 'package:meas/UI/choose_app_screen.dart';
import 'package:meas/UI/Employee/main_page/main_viewmodel.dart';
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
        ChangeNotifierProvider(create: (_) => SalaryDetailViewModel()),
        ChangeNotifierProvider(create: (_) => RelativeListViewModel()),
        ChangeNotifierProvider(create: (_) => ListRelativeViewModel()),
        ChangeNotifierProvider(create: (_) => SalaryInforViewModel())
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
              GetPage(name: '/listRelative', page: () => const ListRelative()),
              GetPage(
                name: '/profileRelative',
                page: () => const ProfileRelativePage(),
              ),
              GetPage(
                name: '/salaryStatistic',
                page: () => const SalaryPage(),
              ),
              GetPage(
                name: '/managementSalary',
                page: () => const SalaryHomePage(),
              ),
              GetPage(
                name: '/salaryRanking',
                page: () => const SalaryRankPage(),
              ),
              GetPage(
                name: '/salaryInfor',
                page: () => const SalaryInforPage(),
              ),
              GetPage(
                name: '/salaryRanks',
                page: () => const SalaryRankPage(),
              )
            ],
          );
        },
      ),
    );
  }
}
