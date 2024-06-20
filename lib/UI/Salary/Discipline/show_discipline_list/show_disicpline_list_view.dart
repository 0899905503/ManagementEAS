import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:meas/UI/Salary/Discipline/show_discipline_list/show_discipline_list_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';

import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';

class DisciplineListPage extends StatelessWidget {
  // final DisciplineListArguments arguments;

  const DisciplineListPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisciplineListViewModelProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: DisciplineListChildPage()),
        ),
      ),
    );
  }
}

class DisciplineListChildPage extends StatefulWidget {
  const DisciplineListChildPage({Key? key}) : super(key: key);

  @override
  State<DisciplineListChildPage> createState() =>
      _DisciplineListChildPageState();
}

class _DisciplineListChildPageState extends State<DisciplineListChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  final TextEditingController manvController = TextEditingController();
  late DisciplineListViewModel disciplineListViewModel =
      DisciplineListViewModelProvider.of(context);
  late DisciplineListViewModel disciplineListViewModel1 =
      DisciplineListViewModel();
  SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  late List<Map<String, dynamic>> DisciplineList =
      []; // Khởi tạo DisciplineListlist trước
  List<Map<String, dynamic>> userid = [];

  bool isLoading = false;

  //static Stream<String> get manv => Stream.value("some value");
  int? selectedEmployeeId;
  int? selectedRankId;
  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    _streamController1 = StreamController<List<Map<String, dynamic>>>();
    fetchEmployeeIds();
    fetchDisciplineList();
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
      await fetchDisciplineList(); // Gọi lại fetchDisciplineListList để tải dữ liệu mới
      print("Update API");
    }
  }

  Future<void> fetchDisciplineList() async {
    try {
      List<Map<String, dynamic>> DisciplineListData1 =
          await disciplineListViewModel.showDisciplineListByMonthAndYear(
        int.parse(DateFormat(AppConfigs.year).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
        int.parse(DateFormat(AppConfigs.month).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
      );
      setState(() {
        DisciplineList = DisciplineListData1;
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
    } catch (e) {
      print('Error fetching DisciplineList : $e');
      setState(() {
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
      _showErrorDialog(
          "Không có thông tin kỷ luật của tháng này"); // Hiển thị dialog thông báo lỗi
    }
  }

  Future<void> fetchEmployeeIds() async {
    try {
      List<Map<String, dynamic>> ids = await salaryDetailViewModel1.getIds();
      setState(() {
        userid = ids;
      });
      print("=================================");
      print(userid.toString());
      print("=================================");
    } catch (e) {
      _showErrorDialog("Không có id nhân viên");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "DisciplineList",
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
            width: 100,
          ),
          _menuItem(
              'Select Month',
              DateFormat(AppConfigs.salaryMonth).format(DateTime.parse(
                "${_selectedDate.toLocal()}".split(' ')[0],
              )), onTap: () {
            _selectMonthYear(context);
          }),
          const SizedBox(
            width: 20,
          ),
          createDisciplineList("Add", onTap: () {
            Get.toNamed(RouteConfig.createDisciplinePage,
                arguments: {'date': _selectedDate});
            // // Kiểm tra nếu DisciplineListlist không rỗng và DisciplineListlist[0]['thang'] không null
            // if (DisciplineList.isNotEmpty && DisciplineList[0]['thang'] != null) {
            //   Get.toNamed(RouteConfig.createEmployeeSalary,
            //       arguments: {'date': DisciplineList[0]['thang']});
            // } else {
            //   // Xử lý trường hợp DisciplineListlist rỗng hoặc DisciplineListlist[0]['thang'] không có giá trị
            //   print(
            //       'Không thể truyền tham số date vì DisciplineListlist rỗng hoặc không có giá trị cho thang');
            // }
            // //(context);
          }),
          const SizedBox(
            width: 20,
          ),
          StreamBuilder<String>(
            stream: disciplineListViewModel1.manv,
            builder: (context, snapshot) {
              return Row(
                children: [
                  createDisciplineListEmployee(
                    "* Employee Id:",
                    selectedEmployeeId?.toString() ?? 'No ID selected',
                    controller: manvController,
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 170,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Color(0xff663300)),
                    ),
                    child: DropdownButton<String>(
                      value: selectedEmployeeId?.toString(),
                      hint: const Text("Select Employee ID"),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEmployeeId = int.tryParse(newValue!);
                          manvController.text =
                              selectedEmployeeId?.toString() ?? '';
                        });
                      },
                      underline: Container(),
                      items: userid.isNotEmpty
                          ? (userid[0]['employee_ids'] as List<dynamic>)
                              .map<DropdownMenuItem<String>>((dynamic id) {
                              return DropdownMenuItem<String>(
                                value: id.toString(),
                                child: Text(id.toString()),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteConfig.showDisciplinesByEmployeeId,
                    arguments: {'useridadmin': int.parse(manvController.text)});
                //  print(manvController.text);
              },
              child: Text("Search")),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      isLoading
          ? const CircularProgressIndicator() // Hiển thị indicator loading khi đang tải dữ liệu
          : DisciplineList.isEmpty
              ? const Text(
                  'Select the month you want to view') // Hiển thị thông báo khi không có dữ liệu
              : Container(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Employee Id')),
                        DataColumn(label: Text('Discipline Id')),
                        DataColumn(label: Text('Reason')),
                        DataColumn(label: Text('Create Date')),
                        DataColumn(label: Text('Salary Discipline')),
                      ],
                      rows: List<DataRow>.generate(DisciplineList.length,
                          (index) {
                        var item = DisciplineList[index];
                        return DataRow(cells: [
                          DataCell(Text(item['manv'] != null
                              ? item['manv'].toString()
                              : 'null')),
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

  Widget createDisciplineList(
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

  Widget createDisciplineListEmployee(String title, String hintText,
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
