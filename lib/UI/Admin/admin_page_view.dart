import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/UI/Admin/Management/choose_app.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(child: AdminChildPage()),
    ));
  }
}

class AdminChildPage extends StatefulWidget {
  const AdminChildPage({Key? key}) : super(key: key);

  @override
  State<AdminChildPage> createState() => _AdminChildPageState();
}

class _AdminChildPageState extends State<AdminChildPage> {
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
        title: "Admin Panel",
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
        child: Column(
          children: [
            const SizedBox(height: 200),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.start,
              children: [
                _menuItem(
                  "Quản lý nhân viên",
                  AppImages.icEmployee,
                  onTap: () {
                    Get.toNamed(RouteConfig.choosePage);
                  },
                ),
                const SizedBox(
                  width: 11,
                ),
                // _menuItem(
                //   "Xem báo cáo",
                //   AppImages.icJob,
                //   onTap: () {
                //     Get.toNamed('/admin/view-reports');
                //   },
                // ),
                // const SizedBox(
                //   width: 11,
                // ),
                // _menuItem(
                //   "Hồ sơ",
                //   AppImages.icMenuSupplier,
                //   onTap: () {
                //     Get.toNamed('/admin/profile');
                //   },
                // ),
              ],
            ),
          ],
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
