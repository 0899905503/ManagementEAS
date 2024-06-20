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
  // List<Map<String, dynamic>>? salaryInforData;
  List<Map<String, dynamic>>? salaryInforByMonthData;
  bool isLoading = false; // Thêm biến trạng thái isLoading
  // selectdate

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectMonthYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month, 1);
        isLoading = true; // Cập nhật isLoading thành true khi chọn tháng mới
      });
      getSalary();
    }
  }

  late int userId;
  @override
  void initState() {
    super.initState();
    // Nhận dữ liệu từ arguments khi khởi tạo màn hình
    // userId = Get.arguments['userId'];
    // infor();
    //fetchUsers();
    getSalary();
  }

  Future<void> getSalary() async {
    try {
      var salaryInforviewmodel =
          Provider.of<SalaryInforViewModel>(context, listen: false);
      List<Map<String, dynamic>> salaryByMonth =
          await salaryInforviewmodel.getSalaryInforByMonth(
        //  int.parse(userId.toString()),
        1,
        int.parse(DateFormat(AppConfigs.month).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
        int.parse(DateFormat(AppConfigs.year).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
      );
      setState(() {
        salaryInforByMonthData = List<Map<String, dynamic>>.from(salaryByMonth);
      });
    } catch (e) {
      _showErrorDialog("Không có thông tin lương của tháng này");
    } finally {
      setState(() {
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
      // Hiển thị dialog thông báo lỗi
    }
  }

  Future<void> _showErrorDialog(String errorMessage) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Warning"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
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
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          _menuItem(
              'Select Month',
              DateFormat(AppConfigs.salaryMonth).format(DateTime.parse(
                "${_selectedDate.toLocal()}".split(' ')[0],
              )), onTap: () {
            _selectMonthYear(context);
          }),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      isLoading
          ? CircularProgressIndicator()
          : (salaryInforByMonthData == null)
              ? const Text('Select the month you want to view')
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F0EF),
                    // border: Border.all(color: AppColors.buttonLogin, width: 2)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 280,
                        width: 600,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.buttonLogin, width: 1)),
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
                                      EmployeeInfor("Ma nhan vien", "1"),
                                      // userId.toString() ?? 'null'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      EmployeeInfor(
                                          "Ma ngach",
                                          salaryInforByMonthData![0]['mangach']
                                                  .toString() ??
                                              'null'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      EmployeeInfor(
                                        "Bac luong",
                                        salaryInforByMonthData![0]['bacluong']
                                                .toString() ??
                                            'null',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      EmployeeInfor(
                                          "He so luong",
                                          salaryInforByMonthData![0]
                                                      ['hesoluong']
                                                  .toString() ??
                                              'null'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      EmployeeInfor(
                                        "luong theo bac",
                                        "${NumberFormat(AppConfigs.formatter).format(int.parse(salaryInforByMonthData![0]['luongtheobac'].toString()))} vnđ" ??
                                            'null',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      EmployeeInfor(
                                          "Total",
                                          "${NumberFormat(AppConfigs.formatter).format(int.parse(salaryInforByMonthData![0]['tongluong'].toString()))} vnđ" ??
                                              'null'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      EmployeeInfor(
                                        "Month",
                                        DateFormat(AppConfigs.salaryMonth)
                                            .format(DateTime.parse(
                                          salaryInforByMonthData![0]['thang']
                                                  .toString() ??
                                              'null',
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
                  ))
    ]);
  }
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

Widget _menuItem(
  String title,
  String date, {
  required VoidCallback onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end, // Đẩy widget tới phía bên phải
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 60,
          margin: EdgeInsets.only(
              right: 10), // Thêm khoảng cách 10 đơn vị từ phía bên phải
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            border: Border.all(color: AppColors.borderMenuItem, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle.brownS30W700.copyWith(
                  fontSize: 16,
                ),
              ),
              Text(
                date,
                style: AppTextStyle.brownS30W700.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
