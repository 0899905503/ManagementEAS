import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/Data/network/api_client.dart';

import 'package:meas/UI/Employee/Login/auth_viewmodel.dart';
import 'package:meas/UI/Employee/Login/signin/signin_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/global/global_data.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';

import '../../../utils/routes/routes.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class SalaryHomePage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const SalaryHomePage({
    Key? key,

    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(child: TkHomeChildPage()),
    ));
  }
}

class TkHomeChildPage extends StatefulWidget {
  const TkHomeChildPage({Key? key}) : super(key: key);

  @override
  State<TkHomeChildPage> createState() => _TkHomeChildPageState();
}

class _TkHomeChildPageState extends State<TkHomeChildPage> {
  SigninViewModel homeViewModel = SigninViewModel();
  AuthViewModel authViewModel = AuthViewModel();
  final SigninViewModel signinViewModel = SigninViewModel();
  Map<String, dynamic>? res;
  @override
  void initState() {
    super.initState();

    a();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "menu",
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Future<void> a() async {
    final String? Url = AppConfigs.baseUrl;
    const String apiUrlPath = "api";
    const String Users = "/users";
    String? token = await Security.storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('$Url$apiUrlPath$Users'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    setState(() {
      res = jsonDecode(response.body);
    });
  }

  Widget _buildBodyWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(bottom: 100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        res!['first_name'].toString() +
                            ' ' +
                            res!['last_name'].toString(),
                        style: AppTextStyle.brownS14W800.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        DateFormat(AppConfigs.dateAPI).format(
                            DateTime.parse(res!['Start_Date'].toString())),
                        style: AppTextStyle.brownS14.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // const AppCacheImage(
                  //   width: 60,
                  //   height: 60,
                  //   url:
                  //       GlobalData.instance.,
                  //   borderRadius: 60,
                  // ),
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: _avatarWidget(res!['avatar'].toString())),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.start,
              children: [
                _menuItem(
                  "Salary Infor",
                  AppImages.icEmployee,
                  onTap: () {
                    Get.toNamed(RouteConfig.salaryInfor,
                        arguments: {'userId': res!['id']});
                    // print(res!['id']);
                    // if (res!['Role_id'] == 4) {
                    //   Get.offNamed(RouteConfig.employeeList);
                    // } else {
                    //   Get.snackbar(
                    //     "Warning!!!",
                    //     "You do not have sufficient access rights",
                    //     colorText: Colors.white,
                    //     icon: const Icon(
                    //       IconData(0x2757, fontFamily: 'Alumi Sans'),
                    //       color: Colors.yellow, // Thay đổi màu sắc nếu cần
                    //       size: 30, // Thay đổi kích thước nếu cần
                    //     ),
                    //   );
                    // }
                  },
                ),
                // _menuItem(
                //   "Salary Statistics",
                //   AppImages.icEmployee,
                //   onTap: () {
                //     Get.toNamed(RouteConfig.salaryStatistic);
                //     // if (res!['Role_id'] == 4) {
                //     //   Get.offNamed(RouteConfig.employeeList);
                //     // } else {
                //     //   Get.snackbar(
                //     //     "Warning!!!",
                //     //     "You do not have sufficient access rights",
                //     //     colorText: Colors.white,
                //     //     icon: const Icon(
                //     //       IconData(0x2757, fontFamily: 'Alumi Sans'),
                //     //       color: Colors.yellow, // Thay đổi màu sắc nếu cần
                //     //       size: 30, // Thay đổi kích thước nếu cần
                //     //     ),
                //     //   );
                //     // }
                //   },
                // ),
                _menuItem(
                  "Ranking",
                  AppImages.icJob,
                  onTap: () {
                    Get.toNamed(RouteConfig.rankSalaryPersonal,
                        arguments: {'userId': res!['id']});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    String title,
    String img, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 185,
        height: 172,
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          border: Border.all(color: AppColors.borderMenuItem, width: 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.textBlack.withOpacity(0.25),
              spreadRadius: 0.0,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 42,
              height: 42,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: AppTextStyle.brownS14.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _avatarWidget(String? url) {
  return Center(
    child: Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
        border: Border.all(color: Colors.white, width: 5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey929292,
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: AppCacheImage(
        url: url ?? "",
        borderRadius: 60,
      ),
    ),
  );
}
