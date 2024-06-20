import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Salary/Discipline/show_discipline_by_employee_id/show_discipline_by_employee_id_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';

class ShowDisciplineByEmployeeIdPage extends StatelessWidget {
  // final ShowDisciplineByEmployeeIdArguments arguments;

  const ShowDisciplineByEmployeeIdPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowDisciplineByEmployeeIdViewModelProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: ShowDisciplineByEmployeeIdChildPage()),
        ),
      ),
    );
  }
}

class ShowDisciplineByEmployeeIdChildPage extends StatefulWidget {
  const ShowDisciplineByEmployeeIdChildPage({Key? key}) : super(key: key);

  @override
  State<ShowDisciplineByEmployeeIdChildPage> createState() =>
      _ShowDisciplineByEmployeeIdChildPageState();
}

class _ShowDisciplineByEmployeeIdChildPageState
    extends State<ShowDisciplineByEmployeeIdChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  late ShowDisciplineByEmployeeIdViewModel showDisciplineByEmployeeIdViewModel =
      ShowDisciplineByEmployeeIdViewModelProvider.of(context);
  late ShowDisciplineByEmployeeIdViewModel
      showDisciplineByEmployeeIdViewModel1 =
      ShowDisciplineByEmployeeIdViewModel();
  int? idsearch;
  late List<Map<String, dynamic>> showDisciplineByEmployeeId =
      []; // Khởi tạo ShowDisciplineByEmployeeIdlist trước

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    _streamController1 = StreamController<List<Map<String, dynamic>>>();
    idsearch = Get.arguments['useridadmin'];
    //  fetchDisciplineList(idsearch!);
    fetchDisciplineList(idsearch!);
  }

  @override
  void dispose() {
    _streamController.close();
    _streamController1.close();
    super.dispose();
  }

  Future<void> fetchDisciplineList(int userid) async {
    try {
      List<Map<String, dynamic>> disciplinelist =
          await showDisciplineByEmployeeIdViewModel1
              .GetDisciplineesByEmployeeId(userid);
      setState(() {
        showDisciplineByEmployeeId = disciplinelist;
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
    } catch (e) {
      print('Error fetching DisciplineList : $e');
      setState(() {
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
      _showErrorDialog(
          "Không có thông tin kỷ luật của nhân viên này!"); // Hiển thị dialog thông báo lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Employee Discipline List",
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Center(
      child: Container(
        child: isLoading
            ? const CircularProgressIndicator() // Hiển thị indicator loading khi đang tải dữ liệu
            : showDisciplineByEmployeeId.isEmpty
                ? const Text(
                    'Không có thông tin kỷ luật của nhân viên này!') // Hiển thị thông báo khi không có dữ liệu
                : Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Discipline Id')),
                          DataColumn(label: Text('Reason')),
                          DataColumn(label: Text('Create Date')),
                          DataColumn(label: Text('Salary Discipline')),
                        ],
                        rows: List<DataRow>.generate(
                            showDisciplineByEmployeeId.length, (index) {
                          var item = showDisciplineByEmployeeId[index];
                          return DataRow(cells: [
                            DataCell(Text(item['makyluat'] != null
                                ? item['makyluat'].toString()
                                : 'null')),
                            DataCell(Text(item['lydo'] != null
                                ? item['lydo'].toString()
                                : 'null')),
                            //dateAPI
                            DataCell(Text(item['ngaykyluat'] != null
                                ? DateFormat(AppConfigs.dateAPI)
                                    .format(DateTime.parse(
                                    item['ngaykyluat'].toString(),
                                  ))
                                : 'null')),
                            DataCell(Text(item['tienphat'] != null
                                ? "${NumberFormat(AppConfigs.formatter).format(int.parse(item['tienphat'].toString()))} vnđ"
                                //NumberFormat(AppConfigs.formatter).format(int.parse( item['tienthuong'].toString()))
                                : 'null')),
                          ]);
                        }),
                      ),
                    ),
                  ),
      ),
    );
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

  Widget EmployeeInfor(String content, String s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 70,
        ),
        Column(
          children: [
            Text(
              "$content: ",
              style: AppTextStyle.blackS16W800,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              s,
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

  Widget createShowDisciplineByEmployeeId(
    String func,

    ///String department,
    //String img,
    {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          border: Border.all(color: AppColors.borderMenuItem, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              func,
              style: AppTextStyle.brownS30W700.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm để hiển thị dialog

  Widget createShowDisciplineByEmployeeIdEmployee(String title, String hintText,
      {required TextEditingController controller}) {
    return SizedBox(
        width: 367,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.brownS14W800
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 100,
                )
              ],
            ),
            AppTextField(
              obscureText: false,
              hintText: hintText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              borderRadius: 10,
              showOutline: true,
              controller: controller,
            ),
          ],
        ));
  }
}
