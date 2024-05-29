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
  final TextEditingController mangachController = TextEditingController();
  final TextEditingController bacluongController = TextEditingController();
  final TextEditingController hesoluongController = TextEditingController();
  final TextEditingController manvController = TextEditingController();
  final TextEditingController luongtheobacController = TextEditingController();
  final TextEditingController thangController = TextEditingController();
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController1;
  late SalaryDetailViewModel salaryDetailViewModel =
      SalaryDetailViewModelProvider.of(context);
  late final List<Map<String, dynamic>> salaryDetails = [];
  late List<Map<String, dynamic>> salarylist = []; // Khởi tạo salarylist trước

  bool isLoading = false;
  final TextEditingController mangach = TextEditingController();
  final TextEditingController bacluong = TextEditingController();
  final TextEditingController hesoluong = TextEditingController();
  final TextEditingController manv = TextEditingController();
  final TextEditingController luongtheobac = TextEditingController();
  final TextEditingController thang = TextEditingController();
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
          const SizedBox(
            width: 20,
          ),
          createSalary("Add", onTap: () {
            _showDialog(context);
          }),
          const SizedBox(
            width: 20,
          ),
          createSalary(
            "Ranks",
            onTap: () {
              // Kiểm tra nếu salarylist không rỗng và salarylist[0]['thang'] không null
              if (salarylist.isNotEmpty && salarylist[0]['thang'] != null) {
                Get.toNamed(RouteConfig.salaryRanks,
                    arguments: {'date': salarylist[0]['thang']});
              } else {
                // Xử lý trường hợp salarylist rỗng hoặc salarylist[0]['thang'] không có giá trị
                print(
                    'Không thể truyền tham số date vì salarylist rỗng hoặc không có giá trị cho thang');
              }
            },
          )
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
                        DataColumn(label: Text('Role')),
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
                          DataCell(Text(item['phongban'] != null
                              ? item['phongban'].toString()
                              : 'null')),
                          DataCell(Text(item['chucvu'] != null
                              ? item['chucvu'].toString()
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
  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // Ngăn chặn đóng dialog khi bấm ra ngoài
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Salary'),
            content: SingleChildScrollView(
                child: Container(
              child: Column(children: [
                SizedBox(
                    height: 500,
                    width: 800,
                    child: ListView(
                      children: [
                        StreamBuilder<String>(
                            stream: salaryDetailViewModel.manv,
                            builder: (context, snapshot) {
                              return createSalaryEmployee(
                                  "Employee Id:", "Employee Id",
                                  controller: manvController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: salaryDetailViewModel.mangach,
                            builder: (context, snapshot) {
                              return createSalaryEmployee("mangach:", "mangach",
                                  controller: mangachController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: salaryDetailViewModel.bacluong,
                            builder: (context, snapshot) {
                              return createSalaryEmployee(
                                  "bacluong:", "bacluong",
                                  controller: bacluongController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: salaryDetailViewModel.hesoluong,
                            builder: (context, snapshot) {
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
                              return createSalaryEmployee("Month:", "Month",
                                  controller: thangController);
                            }),

                        // StreamBuilder<String>(
                        //   stream: salaryDetailViewModel.birthdayStream,
                        //   builder: (context, snapshot) {
                        //     return createSalaryEmployee1(
                        //         "Birthday:", "Birthday",
                        //         controller: birthdayController,
                        //         onTap: () => _selectDate(
                        //               context,
                        //               selectedBirthday,
                        //               (date) {
                        //                 setState(() {
                        //                   selectedBirthday = date;
                        //                   birthdayController.text =
                        //                       selectedBirthday!
                        //                           .toLocal()
                        //                           .toString()
                        //                           .split(' ')[0];
                        //                 });
                        //               },
                        //             ));
                        //   },
                        // ),

                        // StreamBuilder<String>(
                        //     stream: salaryDetailViewModel.roleIdStream,
                        //     builder: (context, snapshot) {
                        //       String roleId = snapshot.data ?? selectedRoleId;
                        //       return Row(
                        //         children: [
                        //           createSalaryEmployee("Role Id", "Role Id",
                        //               controller: roleIdController),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Container(
                        //             width: 170,
                        //             height: 40,
                        //             decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 border: Border.all(
                        //                     width: 2,
                        //                     color: Color(0xff663300))),
                        //             child: DropdownButton<String>(
                        //               value: roleId,
                        //               onChanged: (String? newValue) {
                        //                 setState(() {
                        //                   selectedRoleId = newValue!;
                        //                   roleIdController.text =
                        //                       selectedRoleId;
                        //                 });
                        //               },
                        //               underline: Container(),
                        //               items: const [
                        //                 DropdownMenuItem(
                        //                   value: '1',
                        //                   child: Text('Employee'),
                        //                 ),
                        //                 DropdownMenuItem(
                        //                   value: '2',
                        //                   child: Text('Department Head'),
                        //                 ),
                        //                 DropdownMenuItem(
                        //                   value: '3',
                        //                   child: Text('Deputy Director'),
                        //                 ),
                        //                 DropdownMenuItem(
                        //                   value: '4',
                        //                   child: Text('Director'),
                        //                 ),
                        //                 DropdownMenuItem(
                        //                   value: '5',
                        //                   child: Text('Chairman'),
                        //                 ),
                        //               ],
                        //             ),
                        //           )
                        //         ],
                        //       );
                        //     }),
                      ],
                    ))
              ]),
            )),
            actions: <Widget>[
              TextButton(
                child: const Text('Đồng ý'),
                onPressed: () async {
                  // Lấy dữ liệu từ các trường nhập
                  // (Bạn cần điều chỉnh dòng sau tùy thuộc vào cách bạn thu thập dữ liệu)
                  Map<String, String> salaryData = {
                    'manv': manvController.text,
                    'mangach': mangachController.text,
                    'bacluong': bacluongController.text,
                    'hesoluong': hesoluongController.text,
                    'luongtheobac': luongtheobacController.text,
                    'thang': thangController.text,

                    // Thêm các trường khác tương tự
                  };
                  print(salaryData);
                  // Gọi hàm để tạo lương mới
                  await salaryDetailViewModel
                      .createSalaryforEmployee(salaryData);

                  Navigator.of(context).pop(); // Đóng dialog khi nút được nhấn
                },
              ),
            ],
          );
        });
  }

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
}
