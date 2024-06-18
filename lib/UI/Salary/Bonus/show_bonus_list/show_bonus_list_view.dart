import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Salary/Bonus/show_bonus_list/show_bonus_list_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';

import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';

class BonusListPage extends StatelessWidget {
  // final BonusListArguments arguments;

  const BonusListPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BonusListViewModelProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(child: BonusListChildPage()),
        ),
      ),
    );
  }
}

class BonusListChildPage extends StatefulWidget {
  const BonusListChildPage({Key? key}) : super(key: key);

  @override
  State<BonusListChildPage> createState() => _BonusListChildPageState();
}

class _BonusListChildPageState extends State<BonusListChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  final TextEditingController manvController = TextEditingController();
  late BonusListViewModel bonusListViewModel =
      BonusListViewModelProvider.of(context);
  late BonusListViewModel bonusListViewModel1 = BonusListViewModel();
  SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  late List<Map<String, dynamic>> bonusList =
      []; // Khởi tạo BonusListlist trước
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
    fetchBonusList();
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
      await fetchBonusList(); // Gọi lại fetchBonusListList để tải dữ liệu mới
      print("Update API");
    }
  }

  Future<void> fetchBonusList() async {
    try {
      List<Map<String, dynamic>> bonusListData1 =
          await bonusListViewModel.showBonusListByMonthAndYear(
        int.parse(DateFormat(AppConfigs.year).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
        int.parse(DateFormat(AppConfigs.month).format(DateTime.parse(
          _selectedDate.toString(),
        ))),
      );
      setState(() {
        bonusList = bonusListData1;
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
    } catch (e) {
      print('Error fetching BonusList : $e');
      setState(() {
        isLoading = false; // Kết thúc quá trình tải dữ liệu
      });
      _showErrorDialog(
          "Không có thông tin lương của tháng này"); // Hiển thị dialog thông báo lỗi
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
        title: "BonusList",
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
          createBonusList("Add", onTap: () {
            Get.toNamed(RouteConfig.createBonusPage,
                arguments: {'date': _selectedDate});
            // // Kiểm tra nếu BonusListlist không rỗng và BonusListlist[0]['thang'] không null
            // if (bonusList.isNotEmpty && bonusList[0]['thang'] != null) {
            //   Get.toNamed(RouteConfig.createEmployeeSalary,
            //       arguments: {'date': bonusList[0]['thang']});
            // } else {
            //   // Xử lý trường hợp BonusListlist rỗng hoặc BonusListlist[0]['thang'] không có giá trị
            //   print(
            //       'Không thể truyền tham số date vì BonusListlist rỗng hoặc không có giá trị cho thang');
            // }
            // //(context);
          }),
          const SizedBox(
            width: 20,
          ),
          StreamBuilder<String>(
            stream: bonusListViewModel1.manv,
            builder: (context, snapshot) {
              return Row(
                children: [
                  createBonusListEmployee(
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
                Get.toNamed(RouteConfig.showBonusesByEmployeeId1,
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
          : bonusList.isEmpty
              ? const Text(
                  'Select the month you want to view') // Hiển thị thông báo khi không có dữ liệu
              : Container(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Employee Id')),
                        DataColumn(label: Text('Bonus Id')),
                        DataColumn(label: Text('Reason')),
                        DataColumn(label: Text('Create Date')),
                        DataColumn(label: Text('Salary Bonus')),
                      ],
                      rows: List<DataRow>.generate(bonusList.length, (index) {
                        var item = bonusList[index];
                        return DataRow(cells: [
                          DataCell(Text(item['manv'] != null
                              ? item['manv'].toString()
                              : 'null')),
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

  Widget createBonusList(
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

  Widget createBonusListEmployee(String title, String hintText,
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
