import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/app_permission.dart';

import 'package:flutter_base/ui/widgets/buttons/app_button.dart';
import 'package:get/get.dart';

class ChooseAppScreen extends StatefulWidget {
  const ChooseAppScreen({Key? key}) : super(key: key);

  @override
  State<ChooseAppScreen> createState() => _ChooseAppScreenState();
}

class _ChooseAppScreenState extends State<ChooseAppScreen> {
  AppPermission? _appPermission;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: _buildBodyWidget(),
      )),
    );
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MEAS",
                style: AppTextStyle.blackS22Bold.copyWith(
                  fontSize: 50,
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(AppImages.ic_doan),
              ),
              const SizedBox(height: 30),
              Text(
                "chọn ứng dụng",
                style: AppTextStyle.blackS20Bold.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              AppButton(
                title: "QL Nhân Viên",
                onPressed: () {
                  _appPermission = AppPermission.employee;
                  setState(() {});
                },
                backgroundColor:
                    _appPermission?.isEmployee == true ? null : Colors.white,
                textColor:
                    _appPermission?.isEmployee == true ? null : Colors.black,
                isShadow: true,
                cornerRadius: 20,
              ),
              const SizedBox(height: 15),
              AppButton(
                title: "QL Lương",
                onPressed: () {
                  _appPermission = AppPermission.salary;
                  setState(() {});
                },
                backgroundColor:
                    _appPermission?.isSalary == true ? null : Colors.white,
                textColor:
                    _appPermission?.isSalary == true ? null : Colors.black,
                isShadow: true,
                cornerRadius: 20,
              ),
              const SizedBox(height: 80),
              const AppButton(
                title: "Bắt đầu",
                // onPressed: () {
                //   if (_appPermission?.isEmployee == true) {
                //     Get.offAll(() => const TkMainPage());
                //   } else if (_appPermission?.isSalary == true) {
                //     Get.offAll(() => const HomePage());
                //   }
                // },
                cornerRadius: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
