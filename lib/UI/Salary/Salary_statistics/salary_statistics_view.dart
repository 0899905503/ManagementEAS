import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:get/get.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
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
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: SalaryChildPage()),
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
  late final List<Map<String, dynamic>> salaryDetails;
  SalaryDetailViewModel salaryDetailViewModel = SalaryDetailViewModel();

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    fetchSalaryDetail(); // Gọi hàm để lấy dữ liệu từ API khi StatefulWidget được khởi tạo
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> fetchSalaryDetail() async {
    try {
      List<Map<String, dynamic>> salaryData =
          await salaryDetailViewModel.getSalaryDetail();
      print("////////////////////////////////////////////");
      print(salaryData);
      print("////////////////////////////////////////////");
      setState(() {
        _streamController.add(salaryData);
      });
    } catch (e) {
      print('Error fetching salary details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var salaryDetailViewModel = Provider.of<SalaryDetailViewModel>(context);
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
    return Center(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            salaryDetails = snapshot.data!;
            // Chuyển đổi kiểu dữ liệu của trường 'tenngach' sang String
            List<Map<String, dynamic>> convertedData =
                snapshot.data!.map((item) {
              return {
                'name': item['name'].toString(),
                'tongluong': int.parse(item['tongluong'].toString()),
              };
            }).toList();
            return
                //Text(convertedData.toString()),

                Expanded(
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
                  rows: salaryDetails.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item['userId'] != null
                          ? item['userId'].toString()
                          : '')),
                      DataCell(Text(
                          item['name'] != null ? item['name'].toString() : '')),
                      DataCell(Text(item['department_name'] != null
                          ? item['department_name'].toString()
                          : '')),
                      DataCell(Text(item['mangach'] != null
                          ? item['mangach'].toString()
                          : '')),
                      DataCell(Text(item['tenngach'] != null
                          ? item['tenngach'].toString()
                          : '')),
                      DataCell(Text(item['bacluong'] != null
                          ? item['bacluong'].toString()
                          : '')),
                      DataCell(Text(item['hesoluong'] != null
                          ? item['hesoluong'].toString()
                          : '')),
                      DataCell(Text(item['luongtheobac'] != null
                          ? item['luongtheobac'].toString()
                          : '')),
                      DataCell(Text(item['tongluong'] != null
                          ? item['tongluong'].toString()
                          : '')),
                    ]);
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
