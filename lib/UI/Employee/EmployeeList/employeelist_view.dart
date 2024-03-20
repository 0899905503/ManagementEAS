import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/Data/repositories/auth_repository.dart';
import 'package:meas/UI/Employee/EmployeeList/employeelist_viewmodel.dart';

import 'package:meas/UI/Employee/Homepage/home_page_view.dart';
import 'package:meas/UI/Employee/Login/auth_viewmodel.dart';
import 'package:meas/UI/Employee/Login/signin/signin_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/buttons/app_button.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher-js/core/utils/collections.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bcrypt/bcrypt.dart';

import 'package:http/http.dart' as http;

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Map<String, dynamic>>? users; // Danh sách người dùng
  final String? Url = AppConfigs.baseUrl;
  final String? Path = "storage/Img/AVT/";

  final EmployeeListViewModel employeeListViewModel = EmployeeListViewModel();
//Create User
  final TextEditingController personalIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
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
  final TextEditingController subsidyIdController = TextEditingController();
  final TextEditingController departmentIdController = TextEditingController();
  final TextEditingController permanentAddressController =
      TextEditingController();
//
  String selectedRoleId = '1';
  String selectedDepartmentId = '1';
  String selectedSubsidyId = '1';
  DateTime? selectedIssueDate;
  DateTime? selectedStartDate;
  DateTime? selectedBirthday;
  String selectedGender = 'male';
  late StreamSubscription<String> emailSubscription;

  @override
  void initState() {
    super.initState();

    //Create User
    // Lắng nghe sự thay đổi từ Stream
    // emailSubscription =
    //     EmployeeListViewModel.emailStream.listen((String email) {
    //   print(email);
    // });

//================
    fetchUsers(); // Gọi hàm để lấy thông tin người dùng khi Widget được tạo
  }

  Future<void> fetchUsers() async {
    try {
      // Sử dụng Provider để lấy EmployeeListViewModel
      var employeeListViewModel =
          Provider.of<EmployeeListViewModel>(context, listen: false);
      List<Map<String, dynamic>> userData =
          await employeeListViewModel.getAllUsersApi();
      List a = [userData];
      setState(() {
        // Update the list of users
        users = List<Map<String, dynamic>>.from(userData);
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  ///////////////////////////////////
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

  // Hàm để hiển thị dialog
  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // Ngăn chặn đóng dialog khi bấm ra ngoài
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Employee'),
            content: SingleChildScrollView(
                child: Container(
              child: Column(children: [
                SizedBox(
                    height: 500,
                    width: 800,
                    child: ListView(
                      children: [
                        StreamBuilder<String>(
                            stream: employeeListViewModel.personalIdStream,
                            builder: (context, snapshot) {
                              return createUser("Personal Id:", "Personal Id",
                                  controller: personalIdController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.emailStream,
                            builder: (context, snapshot) {
                              return createUser("Email:", "Email",
                                  controller: emailController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.passwordStream,
                            builder: (context, snapshot) {
                              return createPassword(
                                "Password:",
                                "Password",
                                controller: passwordController,
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.firstNameStream,
                            builder: (context, snapshot) {
                              return createUser("First Name:", "First Name",
                                  controller: firstNameController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.lastNameStream,
                            builder: (context, snapshot) {
                              return createUser("Last Name:", "Last Name",
                                  controller: lastNameController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.phoneNumberStream,
                            builder: (context, snapshot) {
                              return createUser("Phone Number:", "Phone Number",
                                  controller: phoneNumberController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.roleIdStream,
                            builder: (context, snapshot) {
                              String gender = snapshot.data ?? selectedGender;
                              return Row(
                                children: [
                                  createUser("Gender:", "Gender",
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
                        StreamBuilder<String>(
                          stream: employeeListViewModel.birthdayStream,
                          builder: (context, snapshot) {
                            return createUser1("Birthday:", "Birthday",
                                controller: birthdayController,
                                onTap: () => _selectDate(
                                      context,
                                      selectedBirthday,
                                      (date) {
                                        setState(() {
                                          selectedBirthday = date;
                                          birthdayController.text =
                                              selectedBirthday!
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
                            stream: employeeListViewModel.addressStream,
                            builder: (context, snapshot) {
                              return createUser("Address:", "Address",
                                  controller: addressController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.nationalityStream,
                            builder: (context, snapshot) {
                              return createUser("Nationality:", "Nationality",
                                  controller: nationalityController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.qualificationStream,
                            builder: (context, snapshot) {
                              return createUser(
                                  "Qualification:", "Qualification",
                                  controller: qualificationController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.ethnicityStream,
                            builder: (context, snapshot) {
                              return createUser("Ethnicity:", "Ethnicity",
                                  controller: ethnicityController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.languageStream,
                            builder: (context, snapshot) {
                              return createUser("Language:", "Language",
                                  controller: languageController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.computerScienceStream,
                            builder: (context, snapshot) {
                              return createUser(
                                  "Computer Science:", "Computer Science",
                                  controller: computerScienceController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: employeeListViewModel.religionStream,
                            builder: (context, snapshot) {
                              return createUser("Religion:", "Religion",
                                  controller: religionController);
                            }),
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
                        StreamBuilder<String>(
                            stream: employeeListViewModel.issueBytream,
                            builder: (context, snapshot) {
                              return createUser("Issue By:", "Issue By",
                                  controller: issueByController);
                            }),
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
                        StreamBuilder<String>(
                            stream: employeeListViewModel.departmentIdStream,
                            builder: (context, snapshot) {
                              String departmentId =
                                  snapshot.data ?? selectedDepartmentId;
                              return Row(
                                children: [
                                  createUser("Department Id", "Department Id",
                                      controller: departmentIdController),
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
                                      value: departmentId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedDepartmentId = newValue!;
                                          departmentIdController.text =
                                              selectedDepartmentId;
                                        });
                                      },
                                      underline: Container(),
                                      items: const [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('HR'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('Accounting'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Marketing'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('Technical'),
                                        ),
                                        DropdownMenuItem(
                                          value: '5',
                                          child: Text('Executive'),
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
                        StreamBuilder<String>(
                            stream: employeeListViewModel.subsidyIdStream,
                            builder: (context, snapshot) {
                              String subsidyId =
                                  snapshot.data ?? selectedSubsidyId;
                              return Row(
                                children: [
                                  createUser("Subsidy Id", "Subsidy Id",
                                      controller: subsidyIdController),
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
                                      value: subsidyId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedSubsidyId = newValue!;
                                          subsidyIdController.text =
                                              selectedSubsidyId;
                                        });
                                      },
                                      underline: Container(),
                                      items: const [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('phucapchucvu'),
                                        ),
                                        DropdownMenuItem(
                                          value: '2',
                                          child: Text('phucapkhuvuc'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('phucapthamnien'),
                                        ),
                                        DropdownMenuItem(
                                          value: '4',
                                          child: Text('phucapdilai'),
                                        ),
                                        DropdownMenuItem(
                                          value: '5',
                                          child: Text('phucapthoivu'),
                                        ),
                                        DropdownMenuItem(
                                          value: '6',
                                          child: Text('phucapcadem'),
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
                        StreamBuilder<String>(
                            stream:
                                employeeListViewModel.permanentAddressStream,
                            builder: (context, snapshot) {
                              return createUser(
                                  "Permanent Address", "Permanent Address",
                                  controller: permanentAddressController);
                            }),
                      ],
                    ))
              ]),
            )),
            actions: <Widget>[
              TextButton(
                child: Text('Đồng ý'),
                onPressed: () async {
                  // Lấy dữ liệu từ các trường nhập
                  // (Bạn cần điều chỉnh dòng sau tùy thuộc vào cách bạn thu thập dữ liệu)
                  Map<String, String> userData = {
                    'Personal_Id': personalIdController.text,
                    'email': emailController.text,
                    'password': passwordController.text,
                    'first_name': firstNameController.text,
                    'last_name': lastNameController.text,
                    'phone_number': phoneNumberController.text,
                    'birth_date': birthdayController.text,
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
                    'Department_id': departmentIdController.text,
                    'Subsidy_id': subsidyIdController.text,
                    'Permanent_Address': permanentAddressController.text,
                    // Thêm các trường khác tương tự
                  };
                  print(userData);
                  // Gọi hàm để tạo người dùng mới
                  await employeeListViewModel.createUser(userData);

                  Navigator.of(context).pop(); // Đóng dialog khi nút được nhấn
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<EmployeeListViewModel>(context);
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: false,
        title: 'Employee List',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _menuItem("Add", onTap: () {
              _showDialog(context);
            }),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: users![0]['users'].length,
            itemBuilder: (context, index) {
              var user = users?[0];
              return Card(
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: _avatarWidget(Url! +
                        Path! +
                        user!['users'][index]['avatar'].toString()),
                  ),
                  title: Text((user?['users'][index]['first_name'].toString() !=
                              null &&
                          user?['users'][index]['last_name'].toString() != null)
                      ? (user!['users'][index]['first_name'].toString() +
                          " " +
                          user!['users'][index]['last_name'].toString())
                      : 'No Name'),
                  subtitle: Text(
                      (user?['users'][index]['email'].toString() != null)
                          ? (user!['users'][index]['email'].toString())
                          : 'No Email'),
                  onTap: () {
                    // Gọi hàm xử lý sự kiện khi tiêu đề được nhấn
                    Get.toNamed(RouteConfig.personalInformation,
                        arguments: {'user': user!['users'][index]});
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      // Gọi hàm xử lý sự kiện khi nút xóa được nhấn
                      // Ví dụ: xóa user tại vị trí index
                      // print(user['users'][index]['id']);
                      await employeeListViewModel
                          .deleteItem(user!['users'][index]['id']);
                      setState(() {
                        user!['users'].removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget status(String name, String department) {
    return SizedBox(
      height: 60,
      width: 260,
      child: Row(
        children: [
          const SizedBox(
            width: 50,
          ),
          Text(
            name,
            style: AppTextStyle.blackS14W400,
          ),
          const SizedBox(
            width: 300,
          ),
          Text(department,
              style: AppTextStyle.greyS14W800
                  .copyWith(fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}

Widget Title() {
  return SizedBox(
    height: 50,
    width: 400,
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.title,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          'Name',
          style: AppTextStyle.brownS20W800,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Department",
          style: AppTextStyle.brownS20W800,
        ),
        const SizedBox(
          width: 20,
        ),
      ]),
    ),
  );
}

Widget _menuItem(
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
        borderRadius: BorderRadius.circular(0),
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

Widget _avatarWidget(String? url) {
  return Center(
    child: Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
        border: Border.all(color: Colors.white, width: 5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey929292,
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
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

Widget createUser(String title, String hintText,
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

Widget createPassword(String title, String hintText,
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
            hintText: hintText,
            obscureText: true,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            borderRadius: 10,
            showOutline: true,
            controller: controller,
          ),
        ],
      ));
}

Widget createUser1(String title, String hintText,
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
            const SizedBox(
              width: 100,
            )
          ],
        ),
        InkWell(
          onTap: onTap,
          child: AppTextField(
            hintText: hintText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            borderRadius: 10,
            showOutline: true,
            controller: controller,
            enabled: false, // Tắt khả năng chỉnh sửa trực tiếp trên TextField
          ),
        ),
      ],
    ),
  );
}
