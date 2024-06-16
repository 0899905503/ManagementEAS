import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meas/UI/Salary/Discipline/create_discipline_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';
import 'package:provider/provider.dart';

class CreateDisciplineArguments {
  String param;

  CreateDisciplineArguments({
    required this.param,
  });
}

class CreateDisciplinePage extends StatelessWidget {
  const CreateDisciplinePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: CreateDisciplineChildPage()),
      ),
    );
  }
}

class CreateDisciplineChildPage extends StatefulWidget {
  const CreateDisciplineChildPage({Key? key}) : super(key: key);

  @override
  State<CreateDisciplineChildPage> createState() =>
      _CreateDisciplineChildPageState();
}

class _CreateDisciplineChildPageState extends State<CreateDisciplineChildPage> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late CreateDisciplineViewModel createDisciplineViewModel;

  SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  CreateDisciplineViewModel createDisciplineViewModel1 =
      CreateDisciplineViewModel();

  int? selectedEmployeeId;
  int? selectedDisciplineId;
  DateTime? selectedNgaykyluat;

  final TextEditingController makyluatController = TextEditingController();
  final TextEditingController lydoController = TextEditingController();
  final TextEditingController hinhthucController = TextEditingController();
  final TextEditingController manvController = TextEditingController();
  final TextEditingController ngaykyluatController = TextEditingController();
  final TextEditingController tienphatController = TextEditingController();

  List<Map<String, dynamic>> userid = [];
  List<Map<String, dynamic>> disciplineid1 = [];
  Map<String, dynamic>? disciplinename;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    fetchDisciplineIds();
    fetchEmployeeIds();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createDisciplineViewModel = Provider.of<CreateDisciplineViewModel>(context);
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

  Future<void> fetchDisciplineIds() async {
    try {
      List<Map<String, dynamic>> ids1 =
          await createDisciplineViewModel1.getDisciplineIds();
      setState(() {
        disciplineid1 = ids1;
      });
      print('=============================');
      print('State updated: $disciplineid1');
      print('=============================');
    } catch (e) {
      _showErrorDialog("Không có id ma ky luat");
    }
  }

  Future<void> fetchDisciplineName(int disciplineid) async {
    try {
      Map<String, dynamic> name =
          await createDisciplineViewModel1.getDisciplineName(disciplineid);
      setState(() {
        disciplinename = name;
      });
      print('=============================');
      print('State updated: $disciplinename');
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
        title: "Discipline",
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
                        stream: createDisciplineViewModel.manv,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              createDisciplineEmployee(
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
                        stream: createDisciplineViewModel.makyluat,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              createDisciplineEmployee(
                                "* Discipline ID: ",
                                selectedDisciplineId?.toString() ??
                                    'No ID selected',
                                controller: makyluatController,
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
                                  value: selectedDisciplineId?.toString(),
                                  hint: const Text("Select Discipline ID"),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDisciplineId =
                                          int.tryParse(newValue!);
                                      makyluatController.text =
                                          selectedDisciplineId?.toString() ??
                                              '';
                                      fetchDisciplineName(
                                          selectedDisciplineId!);
                                    });
                                  },
                                  underline: Container(),
                                  items: (disciplineid1[0]['discipline_ids']
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
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createDisciplineViewModel.hinhthuc,
                        builder: (context, snapshot) {
                          disciplinename == null
                              ? const Text("null data")
                              : hinhthucController.text =
                                  disciplinename!["discipline_name"].toString();
                          return createDisciplineEmployee(
                              "hinh thuc:", "hinh thuc",
                              controller: hinhthucController);
                        },
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createDisciplineViewModel.lydo,
                        builder: (context, snapshot) {
                          return createDisciplineEmployee(" *lydo:", "lydo",
                              controller: lydoController);
                        },
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: createDisciplineViewModel.ngaykyluatStream,
                        builder: (context, snapshot) {
                          return createDisciplineEmployee1(
                              "ngaykyluat:", "ngaykyluat",
                              controller: ngaykyluatController,
                              onTap: () => _selectDate(
                                    context,
                                    selectedNgaykyluat,
                                    (date) {
                                      setState(() {
                                        selectedNgaykyluat = date;
                                        ngaykyluatController.text =
                                            selectedNgaykyluat!
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
                        stream: createDisciplineViewModel.tienphat,
                        builder: (context, snapshot) {
                          return createDisciplineEmployee(
                              "tienphat:", "tienphat",
                              controller: tienphatController);
                        },
                      ),
                      const SizedBox(height: 10),
                      createDiscipline("Submit", onTap: _handleSubmit),
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
      'makyluat': makyluatController.text,
      'lydo': lydoController.text,
      'ngaykyluat': ngaykyluatController.text,
      'tienphat': tienphatController.text,
    };
    print(salaryData);
    await createDisciplineViewModel1.createEmployeeDiscipline(salaryData);
    _showSuccessDialog("Successful");
  }

  Widget createDiscipline(String func, {required VoidCallback onTap}) {
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

  Widget createDisciplineEmployee(String title, String hintText,
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

  Widget createDisciplineEmployee1(String title, String hintText,
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
