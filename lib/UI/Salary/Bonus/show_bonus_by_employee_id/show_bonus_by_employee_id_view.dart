import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Salary/Bonus/show_bonus_by_employee_id/show_bonus_by_employee_id_viewmodel.dart';
import 'package:meas/UI/Salary/Bonus/show_bonus_list/show_bonus_list_viewmodel.dart';

import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';

class ShowBonusByEmployeeIdPage extends StatelessWidget {
  // final ShowBonusByEmployeeIdArguments arguments;

  const ShowBonusByEmployeeIdPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowBonusByEmployeeIdViewModelProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: ShowBonusByEmployeeIdChildPage()),
        ),
      ),
    );
  }
}

class ShowBonusByEmployeeIdChildPage extends StatefulWidget {
  const ShowBonusByEmployeeIdChildPage({Key? key}) : super(key: key);

  @override
  State<ShowBonusByEmployeeIdChildPage> createState() =>
      _ShowBonusByEmployeeIdChildPageState();
}

class _ShowBonusByEmployeeIdChildPageState
    extends State<ShowBonusByEmployeeIdChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  late ShowBonusByEmployeeIdViewModel showBonusByEmployeeIdViewModel =
      ShowBonusByEmployeeIdViewModelProvider.of(context);
  late ShowBonusByEmployeeIdViewModel showBonusByEmployeeIdViewModel1 =
      ShowBonusByEmployeeIdViewModel();
  int? idsearch1;
  late List<Map<String, dynamic>> showBonusByEmployeeId =
      []; // Khởi tạo ShowBonusByEmployeeIdlist trước

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    _streamController1 = StreamController<List<Map<String, dynamic>>>();
    idsearch1 = Get.arguments['useridadmin'];
    //  fetchBonusList(idsearch!);
    fetchBonusList(idsearch1!);
  }

  @override
  void dispose() {
    _streamController.close();
    _streamController1.close();
    super.dispose();
  }

  Future<void> fetchBonusList(int userid) async {
    try {
      List<Map<String, dynamic>> bonuslist =
          await showBonusByEmployeeIdViewModel1.GetBonusesByEmployeeId(userid);
      setState(() {
        showBonusByEmployeeId = bonuslist;
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
    } catch (e) {
      print('Error fetching BonusList : $e');
      setState(() {
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
      _showErrorDialog(
          "Không có thông tin khen thưởng của nhân viên này!"); // Hiển thị dialog thông báo lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Employee Bonus List",
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
            : showBonusByEmployeeId.isEmpty
                ? const Text(
                    'Không có thông tin khen thưởng của nhân viên này!') // Hiển thị thông báo khi không có dữ liệu
                : Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Bonus Id')),
                          DataColumn(label: Text('Reason')),
                          DataColumn(label: Text('Create Date')),
                          DataColumn(label: Text('Salary Bonus')),
                        ],
                        rows: List<DataRow>.generate(
                            showBonusByEmployeeId.length, (index) {
                          var item = showBonusByEmployeeId[index];
                          return DataRow(cells: [
                            DataCell(Text(item['makhenthuong'] != null
                                ? item['makhenthuong'].toString()
                                : 'null')),
                            DataCell(Text(item['lydo'] != null
                                ? item['lydo'].toString()
                                : 'null')),
                            //dateAPI
                            DataCell(Text(item['ngaykhenthuong'] != null
                                ? DateFormat(AppConfigs.dateAPI)
                                    .format(DateTime.parse(
                                    item['ngaykhenthuong'].toString(),
                                  ))
                                : 'null')),
                            DataCell(Text(item['tienthuong'] != null
                                ? "${NumberFormat(AppConfigs.formatter).format(int.parse(item['tienthuong'].toString()))} vnđ"
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

  Widget createShowBonusByEmployeeId(
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

  Widget createShowBonusByEmployeeIdEmployee(String title, String hintText,
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
