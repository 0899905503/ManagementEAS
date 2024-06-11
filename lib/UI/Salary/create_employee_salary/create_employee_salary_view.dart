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
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';
import 'package:provider/provider.dart';

class SalaryArguments {
  String param;

  SalaryArguments({
    required this.param,
  });
}

class CreateEmployeeSalaryPagePAge extends StatelessWidget {
  // final SalaryArguments arguments;

  const CreateEmployeeSalaryPagePAge({
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
  final TextEditingController mangachController = TextEditingController();
  final TextEditingController bacluongController = TextEditingController();
  final TextEditingController hesoluongController = TextEditingController();
  final TextEditingController manvController = TextEditingController();
  final TextEditingController luongtheobacController = TextEditingController();
  final TextEditingController thangController = TextEditingController();
  final TextEditingController luongcobanController = TextEditingController();
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  late SalaryDetailViewModel salaryDetailViewModel =
      SalaryDetailViewModelProvider.of(context);
  late SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  late final List<Map<String, dynamic>> salaryDetails = [];
  late List<Map<String, dynamic>> salarylist = []; // Khởi tạo salarylist trước
  List<Map<String, dynamic>> userid = [];
  Map<String, dynamic>? salaryinfor;
  bool isLoading = false;
  late DateTime _selectedDate;
  //static Stream<String> get manv => Stream.value("some value");
  int? selectedEmployeeId;
  int? selectedRankId;
  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    _streamController1 = StreamController<List<Map<String, dynamic>>>();
    fetchEmployeeIds();
    _selectedDate =
        DateTime.parse(Get.arguments['date'] ?? DateTime.now().toString());
    //fetchSalaryInfor(selectedEmployeeId!);
  }

  @override
  void dispose() {
    _streamController.close();
    _streamController1.close();
    super.dispose();
  }

  Future<void> fetchSalaryInfor(int userid1) async {
    try {
      Map<String, dynamic> salaryinfor1 =
          await salaryDetailViewModel1.getinfor(userid1);
      print("////////////////////////////////////////////");
      print(salaryinfor1);
      print("////////////////////////////////////////////");
      setState(() {
        salaryinfor = Map<String, dynamic>.from(salaryinfor1);
        // _streamController.add(salaryinfor);
      });
      print(salaryinfor);
    } catch (e) {
      print('Error fetching salary details: $e');
    }
  }

  Future<void> fetchEmployeeIds() async {
    try {
      List<Map<String, dynamic>> ids = await salaryDetailViewModel1.getIds();
      print('############################');
      // print('Fetched IDs: $ids');
      print('############################');
      setState(() {
        userid = ids;
      });
      print('############################');
      print('State updated: $userid');
      print('############################');
    } catch (e) {
      _showErrorDialog("Không có id nhân viên");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Create Employee Salary",
      ),
      body: SafeArea(child: _buildBodyWidget()),
    );
  }

  Widget _buildBodyWidget() {
    return Center(
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          child: Column(children: [
            SizedBox(
                height: 650,
                width: 800,
                child: ListView(
                  children: [
                    StreamBuilder<String>(
                      stream: salaryDetailViewModel.manv,
                      builder: (context, snapshot) {
                        print('User IDs: $userid');
                        return Row(
                          children: [
                            // ElevatedButton(
                            //   onPressed: () {
                            //     print('${salaryinfor?['mangach'].runtimeType}');
                            //   },
                            //   child: Text("click"),
                            // ),
                            createSalaryEmployee(
                              "Employee Id:",
                              selectedEmployeeId?.toString() ??
                                  'No ID selected',
                              controller: manvController,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 170,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2, color: Color(0xff663300)),
                              ),
                              child: DropdownButton<String>(
                                value: selectedEmployeeId?.toString(),
                                hint: const Text("Select Employee ID"),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedEmployeeId =
                                        int.tryParse(newValue!);
                                    manvController.text =
                                        selectedEmployeeId?.toString() ?? '';
                                    if (selectedEmployeeId != null) {
                                      fetchSalaryInfor(selectedEmployeeId!);
                                    } else {
                                      fetchSalaryInfor(1);
                                    }
                                  });
                                  print(selectedEmployeeId);
                                },
                                underline: Container(),
                                items:
                                    (userid[0]['employee_ids'] as List<dynamic>)
                                        .map<DropdownMenuItem<String>>(
                                            (dynamic id) {
                                  return DropdownMenuItem<String>(
                                    value: id.toString(),
                                    child: Text(id.toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<String>(
                        stream: salaryDetailViewModel.mangach,
                        builder: (context, snapshot) {
                          salaryinfor == null
                              ? Text("null data")
                              : mangachController.text =
                                  salaryinfor!["mangach"].toString();

                          return createSalaryEmployee("mangach:", "mangach",
                              controller: mangachController);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<String>(
                        stream: salaryDetailViewModel.bacluong,
                        builder: (context, snapshot) {
                          salaryinfor == null
                              ? Text("null data")
                              : bacluongController.text =
                                  salaryinfor!["bacluong"].toString();
                          return createSalaryEmployee("bacluong:", "bacluong",
                              controller: bacluongController);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<String>(
                        stream: salaryDetailViewModel.hesoluong,
                        builder: (context, snapshot) {
                          salaryinfor == null
                              ? Text("null data")
                              : hesoluongController.text =
                                  salaryinfor!["hesoluong"].toString();
                          return createSalaryEmployee(
                            "hesoluong:",
                            "hesoluong",
                            controller: hesoluongController,
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<String>(
                        stream: salaryDetailViewModel.luongtheobac,
                        builder: (context, snapshot) {
                          salaryinfor == null
                              ? Text("null data")
                              : luongtheobacController.text =
                                  salaryinfor!["luongtheobac"].toString();
                          return createSalaryEmployee(
                              "luongtheobac:", "luongtheobac",
                              controller: luongtheobacController);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<String>(
                        stream: salaryDetailViewModel.thang,
                        builder: (context, snapshot) {
                          thangController.text =
                              "${(DateFormat(AppConfigs.dateAPI).format(_selectedDate))}";
                          return createSalaryEmployee("Month:", "Month",
                              controller: thangController);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<String>(
                        stream: salaryDetailViewModel.luongcoban,
                        builder: (context, snapshot) {
                          salaryinfor == null
                              ? const Text("null data")
                              : luongcobanController.text =
                                  "${NumberFormat(AppConfigs.formatter).format(double.parse(hesoluongController.text) * double.parse(luongtheobacController.text))} vnđ";
                          return createSalaryEmployee(
                              "Luong co ban:", "Luong co ban",
                              controller: luongcobanController);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    createSalary("Submit", onTap: () {
                      _handleSubmit();
                    })
                  ],
                ))
          ]),
        )
      ]),
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

  Widget createSalary(
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

  Widget createSalaryEmployee(String title, String hintText,
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

  Future<void> _handleSubmit() async {
    Map<String, String> salaryData = {
      'manv': manvController.text,
      'mangach': mangachController.text,
      'bacluong': bacluongController.text,
      'hesoluong': hesoluongController.text,
      'luongtheobac': luongtheobacController.text,
      'thang': thangController.text,
    };
    print(salaryData);

    // Kiểm tra xem thông tin lương của nhân viên trong tháng đó đã tồn tại hay chưa
    bool isSalaryExists = await salaryDetailViewModel.checkIfSalaryExists(
        salaryData['manv']!, salaryData['thang']!);

    if (isSalaryExists) {
      // Thông báo lỗi nếu đã có thông tin lương nhân viên trong tháng đó
      print('Thông tin lương của nhân viên đã tồn tại cho tháng này.');
      _showErrorDialog(
          'Thông tin lương của nhân viên đã tồn tại cho tháng này.');
    } else {
      // Gọi hàm để tạo lương mới trên server
      await salaryDetailViewModel.createSalaryforEmployee(salaryData);
      // Thông báo thành công
      print('Tạo lương thành công.');
      _showSuccessDialog('Successedful');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thành công"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
