import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:provider/provider.dart';

class SalaryArguments {
  String param;

  SalaryArguments({
    required this.param,
  });
}

class SalaryPage extends StatelessWidget {
  // final SalaryArguments arguments;

  const SalaryPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalaryDetailViewModelProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: SalaryChildPage()),
        ),
      ),
    );
  }
}

class SalaryChildPage extends StatefulWidget {
  const SalaryChildPage({Key? key}) : super(key: key);

  @override
  State<SalaryChildPage> createState() => _SalaryChildPageState();
}

class _SalaryChildPageState extends State<SalaryChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  late SalaryDetailViewModel salaryDetailViewModel =
      SalaryDetailViewModelProvider.of(context);
  late final List<Map<String, dynamic>> salaryDetails = [];
  late List<Map<String, dynamic>> salarylist = []; // Khởi tạo salarylist trước

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    _streamController1 = StreamController<List<Map<String, dynamic>>>();

    fetchSalaryDetail(); // Gọi hàm để lấy dữ liệu từ API khi StatefulWidget được khởi tạo
    fetchSalaryList();
  }

  @override
  void dispose() {
    _streamController.close();
    _streamController1.close();
    super.dispose();
  }

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
        isLoading = true;
      });
      await fetchSalaryList(); // Gọi lại fetchSalaryList để tải dữ liệu mới
      print("Update API");
    }
  }

  Future<void> fetchSalaryDetail() async {
    try {
      List<Map<String, dynamic>> salaryData =
          await salaryDetailViewModel.getSalaryDetail();
      print("////////////////////////////////////////////");
      // print(salaryData);
      print("////////////////////////////////////////////");
      setState(() {
        _streamController.add(salaryData);
      });
    } catch (e) {
      print('Error fetching salary details: $e');
    }
  }

  Future<void> fetchSalaryList() async {
    try {
      List<Map<String, dynamic>> salaryData1 =
          await salaryDetailViewModel.showSalariesByMonthAndYear(
        int.parse(DateFormat(AppConfigs.year).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
        int.parse(DateFormat(AppConfigs.month).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
      );
      setState(() {
        salarylist = salaryData1;
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
    } catch (e) {
      print('Error fetching salary detail: $e');
      setState(() {
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
      _showErrorDialog(
          "Không có thông tin lương của tháng này"); // Hiển thị dialog thông báo lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Salary",
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
          const SizedBox(
            width: 940,
          ),
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
        height: 10,
      ),
      isLoading
          ? CircularProgressIndicator() // Hiển thị indicator loading khi đang tải dữ liệu
          : salarylist.isEmpty
              ? const Text(
                  'Select the month you want to view') // Hiển thị thông báo khi không có dữ liệu
              : Container(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Id')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Department')),
                        DataColumn(label: Text('Rank Id')),
                        DataColumn(label: Text("Rank's name")),
                        DataColumn(label: Text('Bac luong ')),
                        DataColumn(label: Text('He so luong')),
                        DataColumn(label: Text('Luong cb')),
                        DataColumn(label: Text('Salary total')),
                      ],
                      rows: List<DataRow>.generate(salarylist.length, (index) {
                        var item = salarylist[index];
                        return DataRow(cells: [
                          DataCell(Text(item['manv'] != null
                              ? item['manv'].toString()
                              : 'null')),
                          DataCell(Text(item['tennv'] != null
                              ? item['tennv'].toString()
                              : 'null')),
                          DataCell(Text(item['department'] != null
                              ? item['department'].toString()
                              : 'null')),
                          DataCell(Text(item['mangach'] != null
                              ? item['mangach'].toString()
                              : 'null')),
                          DataCell(Text(item['tenngach'] != null
                              ? item['tenngach'].toString()
                              : 'null')),
                          DataCell(Text(item['bacluong'] != null
                              ? item['bacluong'].toString()
                              : 'null')),
                          DataCell(Text(item['hesoluong'] != null
                              ? item['hesoluong'].toString()
                              : 'null')),
                          DataCell(Text(item['luongtheobac'] != null
                              ? "${NumberFormat(AppConfigs.formatter).format(int.parse(item['luongtheobac'].toString()))} vnđ"
                              : 'null')),
                          DataCell(Text(item['tongluong'] != null
                              ? "${NumberFormat(AppConfigs.formatter).format(int.parse(item['tongluong'].toString()))} vnđ"
                              : 'null')),
                        ]);
                      }),
                    ),
                  ),
                ),
    ]);
  }

  Widget _menuItem(
    String title,
    String date, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 60,
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
}
