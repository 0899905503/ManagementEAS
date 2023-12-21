import 'package:flutter/material.dart';
import 'package:flutter_base/UI/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/UI/widgets/images/app_cache_image.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class HomePage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const HomePage({
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: false,
        title: "menu",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên nhân viên",
                        style: AppTextStyle.brownS14W800.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "23 May 2020",
                        style: AppTextStyle.brownS14.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const AppCacheImage(
                    width: 60,
                    height: 60,
                    // url:
                    //     GlobalData.instance.loginResponse?.user?.profileImage ??
                    //         "",

                    borderRadius: 60,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.start,
              children: [
                _menuItem(
                  "Chấm công",
                  AppImages.icTKMenuTimekeeping,
                  onTap: () {
                    // Get.toNamed(RouteConfig.tkTimekeepingHistoryPage);
                  },
                ),
                _menuItem(
                  "Công việc",
                  AppImages.icTKMenuTodoList,
                  onTap: () {},
                ),
                _menuItem(
                  "Xin nghỉ phép",
                  AppImages.icTKMenuSchedule,
                  onTap: () {
                    // Get.toNamed(RouteConfig.tkTakeLeavePage);
                  },
                ),
                _menuItem(
                  "Xin đi trễ, về sớm",
                  AppImages.icTKWorkLate,
                  onTap: () {
                    //  Get.toNamed(RouteConfig.tkWorkLatePage);
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
