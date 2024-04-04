import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/Data/entities/user_entity.dart';
import 'package:meas/UI/Employee/RelativeList/relativelist_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_infor/salary_infor_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/enums/load_status.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:provider/provider.dart';

import 'package:pusher_channels_flutter/pusher-js/core/transports/url_schemes.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class SalaryInforPage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const SalaryInforPage({
    Key? key,

    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const SalaryInforChildPage(),
    );
  }
}

class SalaryInforChildPage extends StatefulWidget {
  const SalaryInforChildPage({Key? key}) : super(key: key);

  @override
  State<SalaryInforChildPage> createState() => _SalaryInforChildPageState();
}

class _SalaryInforChildPageState extends State<SalaryInforChildPage> {
  List<Map<String, dynamic>>? salaryInforData;
  @override
  void initState() {
    super.initState();
    // Nhận dữ liệu từ arguments khi khởi tạo màn hình
    // relativeData = Get.arguments['relative'];
    // infor();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      // Sử dụng Provider để lấy RelativeListViewModel
      var salaryInforviewmodel =
          Provider.of<SalaryInforViewModel>(context, listen: false);
      List<Map<String, dynamic>> salaryData =
          await salaryInforviewmodel.getSalaryInfor(1);

      setState(() {
        // Update the list of users
        salaryInforData = List<Map<String, dynamic>>.from(salaryData);
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: 'Salary Infor',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color(0xFFF1F0EF),
          // border: Border.all(color: AppColors.buttonLogin, width: 2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
              width: 2000,
            ),
            SizedBox(
              height: 280,
              width: 600,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.buttonLogin, width: 1)),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Salary Information",
                              style: AppTextStyle.blackS22W800,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor("Ma nhan vien",
                                salaryInforData![0]["manv"].toString()),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor("Ma ngach",
                                salaryInforData![0]['mangach'].toString()),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor(
                              "Bac luong",
                              salaryInforData![0]['bacluong'].toString(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor("He so luong",
                                salaryInforData![0]['hesoluong'].toString()),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor(
                              "luong theo bac",
                              "${NumberFormat(AppConfigs.formatter).format(int.parse(salaryInforData![0]['luongtheobac'].toString()))} vnđ",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor("Total",
                                "${NumberFormat(AppConfigs.formatter).format(int.parse(salaryInforData![0]['tongluong'].toString()))} vnđ"),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor(
                              "Month",
                              DateFormat(AppConfigs.salaryMonth)
                                  .format(DateTime.parse(
                                salaryInforData![0]['thang'].toString(),
                              )),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
            //Dayoff + remaining + working hours + overtime
            //  _workingTime(state.PersonalIF?.essentials),
          ],
        ));
  }

  Widget EmployeeInfor(String content, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 70,
        ),
        Column(
          children: [
            Text(
              content + ": ",
              style: AppTextStyle.blackS16W800,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              details,
              style: AppTextStyle.blackS16W800
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    // _cubit.close();
    super.dispose();
  }
}
