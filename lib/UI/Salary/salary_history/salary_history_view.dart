import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/UI/Salary/Salary_infor/salary_infor_viewmodel.dart';
import 'package:meas/UI/Salary/salary_history/salary_history_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'dart:convert';

import 'package:meas/configs/app_configs.dart';
import 'package:provider/provider.dart';

class SalaryHistoryPage extends StatefulWidget {
  @override
  _SalaryHistoryPageState createState() => _SalaryHistoryPageState();
}

class _SalaryHistoryPageState extends State<SalaryHistoryPage> {
  List<dynamic> salaryHistory = [];
  bool isLoading = true;
  late SalaryHistoryViewModel salaryhistoryViewModel = SalaryHistoryViewModel();

  @override
  void initState() {
    super.initState();
    fetchSalaryHistory();
  }

  Future<void> fetchSalaryHistory() async {
    try {
      var salaryhistoryViewModel1 =
          await salaryhistoryViewModel.getSalaryHistory(1);
      setState(() {
        isLoading = false;
        salaryHistory = salaryhistoryViewModel1;
      });
    } catch (e) {
      print('Error :$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary History"),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.buttonLogin, // Màu sắc của đường viền
            width: 1, // Độ dày của đường viền
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : salaryHistory.isEmpty
                ? const Center(
                    child: Text("No salary history available."),
                  )
                : ListView.builder(
                    itemCount: salaryHistory[0]["salary_history"].length,
                    itemBuilder: (context, index) {
                      final item = salaryHistory[0]["salary_history"][index];
                      return ListTile(
                        title: Text(
                          "Tháng ${DateFormat(AppConfigs.salaryMonth).format(DateTime.parse(
                            "${item['thang'].toString()}" ?? 'null',
                          ))}",
                        ),
                        //  _salaryHistory("${item['thang']}".toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _salaryHistory(
                              "1",
                              "${item['mangach'].toString()}",
                              "${item['bacluong'].toString()}",
                              "${item['hesoluong'].toString()}",
                              "${item['luongtheobac'].toString()}",
                              "${item['tongluong'].toString()}",
                            )

                            // Text('Mã ngạch: ${item['mangach'].toString()}'),
                            // Text('Bậc lương: ${item['bacluong']}'),
                            // Text('Hệ số lương: ${item['hesoluong']}'),
                            // Text('Lương theo bậc: ${item['luongtheobac']}'),
                            // Text('Tổng lương: ${item['tongluong']}'),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

Widget _salaryHistory(String id, String mangach, String bacluong,
    String hesoluong, String luongtheobac, String tongluong) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.buttonLogin, // Màu sắc của đường viền
        width: 1, // Độ dày của đường viền
      ),
    ),
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        EmployeeInfor("Ma nhan vien", id),
        // userId.toString() ?? 'null'),
        const SizedBox(
          height: 10,
        ),
        EmployeeInfor("Ma ngach", mangach ?? 'null'),
        const SizedBox(
          height: 10,
        ),
        EmployeeInfor(
          "Bac luong",
          bacluong ?? 'null',
        ),
        const SizedBox(
          height: 10,
        ),
        EmployeeInfor("He so luong", hesoluong ?? 'null'),
        const SizedBox(
          height: 10,
        ),
        EmployeeInfor(
          "luong theo bac",
          "${NumberFormat(AppConfigs.formatter).format(int.parse(luongtheobac.toString()))} vnđ" ??
              'null',
        ),
        const SizedBox(
          height: 10,
        ),
        EmployeeInfor(
            "Total",
            "${NumberFormat(AppConfigs.formatter).format(int.parse(tongluong.toString()))} vnđ" ??
                'null'),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
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
