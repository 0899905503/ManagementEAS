import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Salary/Bonus/create_bonus_viewmodel.dart';

import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';
import 'package:provider/provider.dart';

class CreateBonusArguments {
  String param;

  CreateBonusArguments({
    required this.param,
  });
}

class CreateBonusPage extends StatelessWidget {
  const CreateBonusPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: CreateBonusChildPage()),
      ),
    );
  }
}

class CreateBonusChildPage extends StatefulWidget {
  const CreateBonusChildPage({Key? key}) : super(key: key);

  @override
  State<CreateBonusChildPage> createState() => _CreateBonusChildPageState();
}

class _CreateBonusChildPageState extends State<CreateBonusChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late CreateBonusViewModel createBonusViewModel;

  SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  CreateBonusViewModel createBonusViewModel1 = CreateBonusViewModel();

  int? selectedEmployeeId;
  int? selectedBonusId;
  DateTime? selectedNgaykhenthuong;

  final TextEditingController makhenthuongController = TextEditingController();
  final TextEditingController lydoController = TextEditingController();
  final TextEditingController hinhthucController = TextEditingController();
  final TextEditingController manvController = TextEditingController();
  final TextEditingController ngaykhenthuongController =
      TextEditingController();
  final TextEditingController tienthuongController = TextEditingController();

  List<Map<String, dynamic>> userid = [];
  List<Map<String, dynamic>> bonusd1 = [];
  Map<String, dynamic>? bonusname;
  DateTime? selectedNgaykhenthuong1;
  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    fetchBonusIds();
    fetchEmployeeIds();
    selectedNgaykhenthuong1 = DateTime.parse(DateFormat(AppConfigs.dateAPI)
        .format(Get.arguments['date'] ?? DateTime.now().toString()));
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createBonusViewModel = Provider.of<CreateBonusViewModel>(context);
  }

  Future<void> fetchEmployeeIds() async {
    try {
      List<Map<String, dynamic>> ids = await salaryDetailViewModel1.getIds();
      setState(() {
        userid = ids;
      });
    } catch (e) {
      _showErrorDialog("Không có id nhân viên");
    }
  }

  Future<void> fetchBonusIds() async {
    try {
      List<Map<String, dynamic>> ids1 =
          await createBonusViewModel1.getBonusIds();
      setState(() {
        bonusd1 = ids1;
      });
      print('=============================');
      print('State updated: $bonusd1');
      print('=============================');
    } catch (e) {
      _showErrorDialog("Không có id ma ky luat");
    }
  }

  Future<void> fetchDisciplineName(int bonus) async {
    try {
      Map<String, dynamic> name =
          await createBonusViewModel1.getBonusName(bonus);
      setState(() {
        bonusname = name;
      });
      print('=============================');
      print('State updated: $bonusname');
      print('=============================');
    } catch (e) {
      _showErrorDialog("Error discipline id");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: "Bonus",
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 650,
                  width: 800,
                  child: ListView(
                    children: [
                      StreamBuilder<String>(
                        stream: createBonusViewModel.manv,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              CreateBonusEmployee(
                                "* Employee Id:",
                                selectedEmployeeId?.toString() ??
                                    'No ID selected',
                                controller: manvController,
                              ),
                              const SizedBox(width: 20),
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
                                    });
                                  },
                                  underline: Container(),
                                  items: userid.isNotEmpty
                                      ? (userid[0]['employee_ids']
                                              as List<dynamic>)
                                          .map<DropdownMenuItem<String>>(
                                              (dynamic id) {
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
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createBonusViewModel.makhenthuong,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              CreateBonusEmployee(
                                "* Bonus ID: ",
                                selectedBonusId?.toString() ?? 'No ID selected',
                                controller: makhenthuongController,
                              ),
                              const SizedBox(width: 20),
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
                                  value: selectedBonusId?.toString(),
                                  hint: const Text("Select Bonus ID"),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedBonusId = int.tryParse(newValue!);
                                      makhenthuongController.text =
                                          selectedBonusId?.toString() ?? '';
                                      fetchDisciplineName(selectedBonusId!);
                                    });
                                  },
                                  underline: Container(),
                                  items:
                                      (bonusd1[0]['bonus_ids'] as List<dynamic>)
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
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createBonusViewModel.hinhthuc,
                        builder: (context, snapshot) {
                          bonusname == null
                              ? const Text("null data")
                              : hinhthucController.text =
                                  bonusname!["bonus_name"].toString();
                          return CreateBonusEmployee("hinh thuc:", "hinh thuc",
                              controller: hinhthucController);
                        },
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createBonusViewModel.lydo,
                        builder: (context, snapshot) {
                          return CreateBonusEmployee(" *lydo:", "lydo",
                              controller: lydoController);
                        },
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createBonusViewModel.ngaykhenthuongStream,
                        builder: (context, snapshot) {
                          ngaykhenthuongController.text =
                              DateFormat(AppConfigs.dateAPI)
                                  .format(selectedNgaykhenthuong1!);
                          return CreateBonusEmployee1(
                              "ngaykhenthuong:", "ngaykhenthuong",
                              controller: ngaykhenthuongController,
                              onTap: () => _selectDate(
                                    context,
                                    selectedNgaykhenthuong1 ??
                                        selectedNgaykhenthuong,
                                    (date) {
                                      setState(() {
                                        selectedNgaykhenthuong1 = date;
                                        ngaykhenthuongController.text =
                                            selectedNgaykhenthuong1!
                                                .toLocal()
                                                .toString()
                                                .split(' ')[0];
                                      });
                                    },
                                  ));
                        },
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createBonusViewModel.tienthuong,
                        builder: (context, snapshot) {
                          return CreateBonusEmployee(
                              "tienthuong:", "tienthuong",
                              controller: tienthuongController);
                        },
                      ),
                      const SizedBox(height: 10),
                      CreateBonus("Submit", onTap: _handleSubmit),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    Map<String, String> salaryData = {
      'manv': manvController.text,
      'makhenthuong': makhenthuongController.text,
      'lydo': lydoController.text,
      'ngaykhenthuong': ngaykhenthuongController.text,
      'tienthuong': tienthuongController.text,
    };
    print(salaryData);
    await createBonusViewModel1.createEmployeeBonus(salaryData);
    _showSuccessDialog("Successful");
  }

  Widget CreateBonus(String func, {required VoidCallback onTap}) {
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
              style: AppTextStyle.brownS30W700.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime? selectedDate,
    Function(DateTime) onDateSelected,
  ) async {
    final DateTime currentDate = selectedDate ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != currentDate) {
      onDateSelected(picked);
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

  Widget CreateBonusEmployee(String title, String hintText,
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
              const SizedBox(width: 100),
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
      ),
    );
  }

  Widget CreateBonusEmployee1(String title, String hintText,
      {required TextEditingController controller, Function()? onTap}) {
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
              const SizedBox(width: 100),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: AppTextField(
              obscureText: false,
              hintText: hintText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              borderRadius: 10,
              showOutline: true,
              controller: controller,
            ),
          ),
        ],
      ),
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
