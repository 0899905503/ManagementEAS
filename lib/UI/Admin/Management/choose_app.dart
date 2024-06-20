import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(child: ChooseChildPage()),
    ));
  }
}

class ChooseChildPage extends StatefulWidget {
  const ChooseChildPage({Key? key}) : super(key: key);

  @override
  State<ChooseChildPage> createState() => _ChooseChildPageState();
}

class _ChooseChildPageState extends State<ChooseChildPage> {
  Map<String, dynamic>? res;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Management",
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(bottom: 100),
        child: Center(
          // Center the Column horizontally and vertically
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Center the Column's children vertically
            children: [
              const SizedBox(height: 200), // Add vertical space
              Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment
                    .center, // Center the Wrap's children horizontally
                children: [
                  _menuItem(
                    "Employee",
                    AppImages.icEmployee,
                    onTap: () {
                      Get.toNamed(RouteConfig.employeeList);
                    },
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  _menuItem(
                    "Bonus",
                    AppImages.icEmployee,
                    onTap: () {
                      Get.toNamed(RouteConfig.bonusListPage);
                    },
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  _menuItem(
                    "Discipline",
                    AppImages.icEmployee,
                    onTap: () {
                      Get.toNamed(RouteConfig.disciplineListPage);
                    },
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  _menuItem(
                    "Relative",
                    AppImages.icEmployee,
                    onTap: () {
                      Get.toNamed(RouteConfig.listRelative);
                    },
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  _menuItem(
                    "Salary",
                    AppImages.icSalary,
                    onTap: () {
                      Get.toNamed(RouteConfig.salaryStatistic);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String title, String img, {required VoidCallback onTap}) {
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
