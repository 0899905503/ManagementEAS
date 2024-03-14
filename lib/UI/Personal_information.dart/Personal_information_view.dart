import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meas/UI/EmployeeList/employeelist_view.dart';
import 'package:meas/UI/EmployeeList/employeelist_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/enums/load_status.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:provider/provider.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class TkPersonalIFPage extends StatelessWidget {
  const TkPersonalIFPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const TkPersonalIFChildPage(),
    );
  }
}

class TkPersonalIFChildPage extends StatefulWidget {
  const TkPersonalIFChildPage({Key? key}) : super(key: key);

  @override
  State<TkPersonalIFChildPage> createState() => _TkPersonalIFChildPageState();
}

class _TkPersonalIFChildPageState extends State<TkPersonalIFChildPage> {
  Map<String, dynamic>? userData;
  final String? Url = AppConfigs.baseUrl;
  final String? Path = "storage/Img/AVT/";
  final EmployeeListViewModel employeeListViewModel = EmployeeListViewModel();
  final TextEditingController idController = TextEditingController();
  final TextEditingController personalIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController ethnicityController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController computerScienceController =
      TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController issueDateController = TextEditingController();
  final TextEditingController issueByController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController roleIdController = TextEditingController();
  final TextEditingController permanentAddressController =
      TextEditingController();

  DateTime? selectedIssueDate;
  DateTime? selectedStartDate;
  String selectedRoleId = '1';
  String selectedGender = 'male';
  @override
  void initState() {
    super.initState();
    userData = Get.arguments['user'];

    // Initialize controllers with user data
    idController.text = userData!['id'].toString();
    personalIdController.text = userData!['Personal_Id'].toString();
    emailController.text = userData!['email'].toString();
    passwordController.text = userData!['password'].toString();
    firstNameController.text = userData!['first_name'].toString();
    lastNameController.text = userData!['last_name'].toString();
    phoneNumberController.text = userData!['phone_number'].toString();
    genderController.text = userData!['gender'].toString();
    addressController.text = userData!['address'].toString();
    qualificationController.text = userData!['Qualification'].toString();
    nationalityController.text = userData!['Nationality'].toString();
    ethnicityController.text = userData!['Ethnicity'].toString();
    languageController.text = userData!['Language'].toString();
    computerScienceController.text = userData!['Computer_Science'].toString();
    religionController.text = userData!['Religion'].toString();
    issueDateController.text = userData!['Issue_Date'].toString();
    issueByController.text = userData!['Issued_By'].toString();
    startDateController.text = userData!['Start_Date'].toString();
    roleIdController.text = userData!['Role_id'].toString();
    permanentAddressController.text =
        userData!['Permanent_AdduserDatas'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: 'Personal',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
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

  Future<void> updateUser(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Employee'),
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    width: 800,
                    child: ListView(
                      children: [
                        createUser("Personal Id:", "Personal Id",
                            controller: personalIdController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Email:", "Email",
                            controller: emailController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Password:", "Password",
                            controller: passwordController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("First Name:", "First Name",
                            controller: firstNameController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Last Name:", "Last Name",
                            controller: lastNameController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Phone Number:", "Phone Number",
                            controller: phoneNumberController),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.roleIdStream,
                            builder: (context, snapshot) {
                              String gender = snapshot.data ?? selectedGender;
                              return Row(
                                children: [
                                  createUser("Gender", "Gender",
                                      controller: genderController),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 2,
                                            color: Color(0xff663300))),
                                    child: DropdownButton<String>(
                                      value: gender,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGender = newValue!;
                                          genderController.text =
                                              selectedGender;
                                        });
                                      },
                                      underline: Container(),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'male',
                                          child: Text('male'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'female',
                                          child: Text('female'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Address:", "Address",
                            controller: addressController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Nationality:", "Nationality",
                            controller: nationalityController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Qualification:", "Qualification",
                            controller: qualificationController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Ethnicity:", "Ethnicity",
                            controller: ethnicityController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Language:", "Language",
                            controller: languageController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Computer Science:", "Computer Science",
                            controller: computerScienceController),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Religion:", "Religion",
                            controller: religionController),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                          stream: employeeListViewModel.issueDateStream,
                          builder: (context, snapshot) {
                            return createUser1("Issue Date:", "Issue Date",
                                controller: issueDateController,
                                onTap: () => _selectDate(
                                      context,
                                      selectedIssueDate,
                                      (date) {
                                        setState(() {
                                          selectedIssueDate = date;
                                          issueDateController.text =
                                              selectedIssueDate!
                                                  .toLocal()
                                                  .toString()
                                                  .split(' ')[0];
                                        });
                                      },
                                    ));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Issue By:", "Issue By",
                            controller: issueByController),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                          stream: employeeListViewModel.startDateStream,
                          builder: (context, snapshot) {
                            return createUser1("Start Date:", "Start Date",
                                controller: startDateController,
                                onTap: () => _selectDate(
                                      context,
                                      selectedStartDate,
                                      (date) {
                                        setState(() {
                                          selectedStartDate = date;
                                          startDateController.text =
                                              selectedStartDate!
                                                  .toLocal()
                                                  .toString()
                                                  .split(' ')[0];
                                        });
                                      },
                                    ));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.roleIdStream,
                            builder: (context, snapshot) {
                              String roleId = snapshot.data ?? selectedRoleId;
                              return Row(
                                children: [
                                  createUser("Role Id", "Role Id",
                                      controller: roleIdController),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2,
                                            color: Color(0xff663300))),
                                    child: DropdownButton<String>(
                                      value: roleId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedRoleId = newValue!;
                                          roleIdController.text =
                                              selectedRoleId;
                                        });
                                      },
                                      underline: Container(),
                                      items: const [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Employee'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Department Head'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Deputy Director'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('Director'),
                                        ),
                                        DropdownMenuItem(
                                          value: '5',
                                          child: Text('Chairman'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        createUser("Permanent Address", "Permanent Address",
                            controller: permanentAddressController),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đồng ý'),
              onPressed: () async {
                Map<String, String> userData = {
                  'Personal_Id': personalIdController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'first_name': firstNameController.text,
                  'last_name': lastNameController.text,
                  'phone_number': phoneNumberController.text,
                  'gender': genderController.text,
                  'address': addressController.text,
                  'Qualification': qualificationController.text,
                  'Nationality': nationalityController.text,
                  'Ethnicity': ethnicityController.text,
                  'Language': languageController.text,
                  'Computer_Science': computerScienceController.text,
                  'Religion': religionController.text,
                  'Issue_Date': issueDateController.text,
                  'Issued_By': issueByController.text,
                  'Start_Date': startDateController.text,
                  'Role_id': roleIdController.text,
                  'Permanent_Address': permanentAddressController.text,
                };
                int UserID = int.parse(idController.text);
                try {
                  await employeeListViewModel.updateUserInfo(UserID, userData);
                } catch (e) {
                  print(e);
                }
                // print(userData!['Personal_Id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF1F0EF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 500),
                _avatarWidget(Url! + Path! + userData!['avatar'].toString()),
                const SizedBox(width: 30),
                Text(
                  userData!['first_name'].toString() +
                      userData!['last_name'].toString(),
                  style: AppTextStyle.brownS20W800,
                ),
                const SizedBox(width: 150),
                _menuItem("Relative", onTap: () {
                  Get.toNamed(RouteConfig.relative,
                      arguments: {'user': userData!['id']});
                }),
                const SizedBox(width: 10),
                _menuItem("Fix", onTap: () {
                  updateUser(context);
                })
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 520,
            width: 600,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.buttonLogin, width: 1),
              ),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Personal Information",
                          style: AppTextStyle.blackS22W800,
                        ),
                        const SizedBox(height: 10),
                        EmployeeInfor(
                          "Id",
                          userData!['id'].toString(),
                        ),
                        const SizedBox(height: 10),
                        EmployeeInfor(
                          "Personal Id",
                          userData!['Personal_Id'].toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                          "Name",
                          userData!['first_name'].toString() +
                              ' ' +
                              userData!['last_name'].toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Gender", userData!['gender'].toString()),
                        const SizedBox(
                          height: 10,
                        ),

                        EmployeeInfor(
                            "Birth day", userData!['birth_date'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Email", userData!['email'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Address", userData!['address'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Contract", userData!['phone_number'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Qualification",
                            userData!['Qualification'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Nationality", userData!['Nationality'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Ethnicity", userData!['Ethnicity'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Issue Date", userData!['Issue_Date'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Issue By", userData!['Issued_By'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Start Date", userData!['Start_Date'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Language", userData!['Language'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Computer Science",
                            userData!['Computer_Science'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Role Id", userData!['Role_id'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Permanent Address",
                            userData!['Permanent_Address'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        // ... (add other fields as needed)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarWidget(String? url) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey929292,
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: AppCacheImage(
          url: url ?? "",
          borderRadius: 60,
        ),
      ),
    );
  }

  Widget EmployeeInfor(String content, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 70),
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
              style: AppTextStyle.blackS16W800.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget _menuItem(
  String title, {
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 100,
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
        ],
      ),
    ),
  );
}
