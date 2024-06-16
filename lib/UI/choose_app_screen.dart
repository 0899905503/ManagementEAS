import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meas/UI/Employee/Login/auth_viewmodel.dart';
import 'package:meas/UI/Employee/Login/signin/signin_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher-js/core/transports/url_schemes.dart';
import 'package:retrofit/retrofit.dart';
import 'package:http/http.dart' as http;

class ChooseAppScreen extends StatefulWidget {
  const ChooseAppScreen({super.key});

  @override
  State<ChooseAppScreen> createState() => _ChooseAppScreenState();
}

class _ChooseAppScreenState extends State<ChooseAppScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(child: _buildBodyWidget()),
    ));
  }

  @override
  void initState() {
    a();
  }

  Future<void> a() async {
    print(await Security.storage.read(key: 'token'));
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFF1F0EF)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Text(
                  "MEAS",
                  style: AppTextStyle.brownS40W800.copyWith(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 49,
                ),
                SizedBox(
                  height: 228,
                  width: 228,
                  child: Image.asset(AppImages.icbackground),
                ),
                const SizedBox(
                  height: 81,
                ),
                Text(
                  "Chọn tính năng",
                  style: AppTextStyle.brownS14W800.copyWith(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 550,
                    ),
                    _menuItem(
                      "Nhân viên",
                      AppImages.icEmployee,
                      onTap: () {
                        Get.toNamed(RouteConfig.managementEmployee);
                      },
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    _menuItem(
                      "Lương",
                      AppImages.icSalary,
                      onTap: () {
                        Get.toNamed(RouteConfig.managementSalary);
                      },
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    _menuItem(
                      "Admin",
                      AppImages.icPerson,
                      onTap: () {
                        Get.toNamed(RouteConfig.adminPage);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 105,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 680,
                    ),
                    // Text(
                    //   "baovo1",
                    //   style: AppTextStyle.brownS14W800
                    //       .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    // ),
                    // boxMenu("Log Out", 12, FontWeight.w700)
                  ],
                )
              ],
            ),
          ),
        )
      ],
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
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          border: Border.all(color: AppColors.borderMenuItem, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 40,
              height: 32,
            ),
            const SizedBox(height: 10.6),
            Text(
              title,
              style: AppTextStyle.brownS30W700.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget boxMenu(String content, double? size, FontWeight weight) {
    return Row(
      children: [
        TextButton(
          child: Text(content,
              style: TextStyle(
                  fontSize: size,
                  fontWeight: weight,
                  color: AppColors.borderMenuItem)),
          onPressed: () {
            print("click");
          },
        )
      ],
    );
  }
}
