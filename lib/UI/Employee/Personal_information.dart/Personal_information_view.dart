import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_view.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_viewmodel.dart';
import 'package:meas/UI/Employee/Personal_information.dart/Personal_information_viewmodel.dart';

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
  int? userData;
  int? useridbyemployeelist;
  Map<String, dynamic>? userDataById;
  final String? Url = AppConfigs.baseUrl;
  final String? Path = "storage/Img/AVT/";
  final EmployeeListViewModel employeeListViewModel = EmployeeListViewModel();
  final idController = TextEditingController();
  final personalIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final qualificationController = TextEditingController();
  final nationalityController = TextEditingController();
  final ethnicityController = TextEditingController();
  final languageController = TextEditingController();
  final computerScienceController = TextEditingController();
  final religionController = TextEditingController();
  final issueDateController = TextEditingController();
  final issueByController = TextEditingController();
  final startDateController = TextEditingController();
  final roleIdController = TextEditingController();
  final permanentAddressController = TextEditingController();
  PersonalInformationViewModel personalinfor = PersonalInformationViewModel();
  DateTime? selectedIssueDate;
  DateTime? selectedStartDate;
  String selectedRoleId = '1';
  String selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    userData = Get.arguments['userid'];
    useridbyemployeelist = Get.arguments['useridemployeelist'];
    if (userData == null) {
      fetchUsers(useridbyemployeelist!);
    } else {
      fetchUsers(userData!);
    }
    //fetchUsers(userData! ?? useridbyemployeelist!);
    // Initialize controllers with user data
    // idController.text = userDataById!['employee']['id'].toString();
    // personalIdController.text =
    //     userDataById!['employee']['Personal_Id'].toString();
    // emailController.text = userDataById!['employee']['email'].toString();
    // passwordController.text = userDataById!['employee']['password'].toString();
    // firstNameController.text =
    //     userDataById!['employee']['first_name'].toString();
    // lastNameController.text = userDataById!['employee']['last_name'].toString();
    // phoneNumberController.text =
    //     userDataById!['employee']['phone_number'].toString();
    // genderController.text = userDataById!['employee']['gender'].toString();
    // addressController.text = userDataById!['employee']['address'].toString();
    // qualificationController.text =
    //     userDataById!['employee']['Qualification'].toString();
    // nationalityController.text =
    //     userDataById!['employee']['Nationality'].toString();
    // ethnicityController.text =
    //     userDataById!['employee']['Ethnicity'].toString();
    // languageController.text = userDataById!['employee']['Language'].toString();
    // computerScienceController.text =
    //     userDataById!['employee']['Computer_Science'].toString();
    // religionController.text = userDataById!['employee']['Religion'].toString();
    // issueDateController.text =
    //     userDataById!['employee']['Issue_Date'].toString();
    // issueByController.text = userDataById!['employee']['Issued_By'].toString();
    // startDateController.text =
    //     userDataById!['employee']['Start_Date'].toString();
    // roleIdController.text = userDataById!['employee']['Role_id'].toString();
    // permanentAddressController.text =
    //     userDataById!['employee']['Permanent_AdduserDatas'].toString();
  }

  Future<void> fetchUsers(int id) async {
    try {
      Map<String, dynamic> userData1 = await personalinfor.userInfor(id);
      print("===================================");
      print(userData1);
      print("===================================");
      setState(() {
        // Update the list of users
        userDataById = userData1;
        idController.text = userDataById!['employee']['id'].toString();
        personalIdController.text =
            userDataById!['employee']['Personal_Id'].toString();
        emailController.text = userDataById!['employee']['email'].toString();
        // passwordController.text =
        //     userDataById!['employee']['password'].toString();
        passwordController.text = "Password input";
        firstNameController.text =
            userDataById!['employee']['first_name'].toString();
        lastNameController.text =
            userDataById!['employee']['last_name'].toString();
        phoneNumberController.text =
            userDataById!['employee']['phone_number'].toString();
        genderController.text = userDataById!['employee']['gender'].toString();
        addressController.text =
            userDataById!['employee']['address'].toString();
        qualificationController.text =
            userDataById!['employee']['Qualification'].toString();
        nationalityController.text =
            userDataById!['employee']['Nationality'].toString();
        ethnicityController.text =
            userDataById!['employee']['Ethnicity'].toString();
        languageController.text =
            userDataById!['employee']['Language'].toString();
        computerScienceController.text =
            userDataById!['employee']['Computer_Science'].toString();
        religionController.text =
            userDataById!['employee']['Religion'].toString();
        issueDateController.text =
            userDataById!['employee']['Issue_Date'].toString();
        issueByController.text =
            userDataById!['employee']['Issued_By'].toString();
        startDateController.text =
            userDataById!['employee']['Start_Date'].toString();
        roleIdController.text = userDataById!['employee']['Role_id'].toString();
        permanentAddressController.text =
            userDataById!['employee']['Permanent_AdduserDatas'].toString();
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
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
          title: const Text('Employee'),
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
                                    width: 170,
                                    height: 40,
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
                // const SizedBox(width: 500),
                // _avatarWidget(Url! + Path! + userData!['avatar'].toString()),
                // const SizedBox(width: 30),
                // Text(
                //   userData!['first_name'].toString() +
                //       userData!['last_name'].toString(),
                //   style: AppTextStyle.brownS20W800,
                // ),
                // const SizedBox(width: 150),
                // _menuItem("Relative", onTap: () {
                //   Get.toNamed(RouteConfig.relative,
                //       arguments: {'user': userData!['id']});
                // }),
                const SizedBox(width: 10),
                _menuItem("Fix", onTap: () {
                  updateUser(context);
                }),
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
                          userDataById!['employee']['id'].toString(),
                        ),
                        const SizedBox(height: 10),
                        EmployeeInfor(
                          "Personal Id",
                          userDataById!['employee']['Personal_Id'].toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                          "Name",
                          userDataById!['employee']['first_name'].toString() +
                              ' ' +
                              userDataById!['employee']['last_name'].toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Gender",
                            userDataById!['employee']['gender'].toString()),
                        const SizedBox(
                          height: 10,
                        ),

                        EmployeeInfor(
                          "Birth day",
                          DateFormat(AppConfigs.dateAPI).format(DateTime.parse(
                              userDataById!['employee']['birth_date']
                                  .toString())),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Email",
                            userDataById!['employee']['email'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Address",
                            userDataById!['employee']['address'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Contract",
                            userDataById!['employee']['phone_number']
                                .toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Qualification",
                            userDataById!['employee']['Qualification']
                                .toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Nationality",
                            userDataById!['employee']['Nationality']
                                .toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Ethnicity",
                            userDataById!['employee']['Ethnicity'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                          "Issue Date",
                          DateFormat(AppConfigs.dateAPI).format(DateTime.parse(
                              userDataById!['employee']['Issue_Date']
                                  .toString())),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Issue By",
                            userDataById!['employee']['Issued_By'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                          "Start Date",
                          DateFormat(AppConfigs.dateAPI).format(DateTime.parse(
                              userDataById!['employee']['Start_Date']
                                  .toString())),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Language",
                            userDataById!['employee']['Language'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Computer Science",
                            userDataById!['employee']['Computer_Science']
                                .toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor("Role Id",
                            userDataById!['employee']['Role_id'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        EmployeeInfor(
                            "Permanent Address",
                            userDataById!['employee']['Permanent_Address']
                                .toString()),
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
    // personalIdController.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    // firstNameController.dispose();
    // lastNameController.dispose();
    // phoneNumberController.dispose();
    // genderController.dispose();
    // addressController.dispose();
    // nationalityController.dispose();
    // qualificationController.dispose();
    // ethnicityController.dispose();
    // languageController.dispose();
    // computerScienceController.dispose();
    // religionController.dispose();
    // issueDateController.dispose();
    // issueByController.dispose();
    // startDateController.dispose();
    // roleIdController.dispose();
    // permanentAddressController.dispose();
    // idController.dispose();
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
