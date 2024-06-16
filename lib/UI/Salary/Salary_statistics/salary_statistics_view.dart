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
  late SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  late final List<Map<String, dynamic>> salaryDetails = [];
  late List<Map<String, dynamic>> salarylist = []; // Khởi tạo salarylist trước
  List<Map<String, dynamic>> userid = [];
  Map<String, dynamic>? salaryinfor;
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
    //fetchSalaryInfor(selectedEmployeeId!);
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
      print(salaryData);
      print("////////////////////////////////////////////");
      setState(() {
        _streamController.add(salaryData);
      });
    } catch (e) {
      print('Error fetching salary details: $e');
    }
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
      print("salary infor : $salaryinfor");
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
            // Kiểm tra nếu salarylist không rỗng và salarylist[0]['thang'] không null
            if (salarylist.isNotEmpty && salarylist[0]['thang'] != null) {
              Get.toNamed(RouteConfig.createEmployeeSalary,
                  arguments: {'date': salarylist[0]['thang']});
            } else {
              // Xử lý trường hợp salarylist rỗng hoặc salarylist[0]['thang'] không có giá trị
              print(
                  'Không thể truyền tham số date vì salarylist rỗng hoặc không có giá trị cho thang');
            }
            //(context);
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
                        DataColumn(label: Text('Luong theo bac')),
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
                            print('User IDs: $userid');
                            return Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    print(
                                        '${salaryinfor?['mangach'].runtimeType}');
                                  },
                                  child: Text("click"),
                                ),
                                createSalaryEmployee(
                                  "Employee Id:",
                                  selectedEmployeeId?.toString() ??
                                      'No ID selected',
                                  controller: manvController,
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
                                            selectedEmployeeId?.toString() ??
                                                '';
                                        if (selectedEmployeeId != null) {
                                          fetchSalaryInfor(selectedEmployeeId!);
                                        } else {
                                          fetchSalaryInfor(1);
                                        }
                                      });
                                      print(selectedEmployeeId);
                                    },
                                    underline: Container(),
                                    items: (userid[0]['employee_ids']
                                            as List<dynamic>)
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
                              // salaryinfor == null
                              //     ? Text("null data")
                              //     : mangachController.text =
                              //         salaryinfor!["mangach"].toString();

                              return createSalaryEmployee(
                                  "mangach:", salaryinfor.toString(),
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
