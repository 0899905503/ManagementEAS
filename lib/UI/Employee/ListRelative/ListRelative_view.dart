import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/Data/repositories/auth_repository.dart';
import 'package:meas/UI/Employee/Homepage/home_page_view.dart';
import 'package:meas/UI/Employee/ListRelative/ListRelative_viewmodel.dart';
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

class ListRelative extends StatefulWidget {
  const ListRelative({Key? key}) : super(key: key);

  @override
  State<ListRelative> createState() => _ListRelativeState();
}

class _ListRelativeState extends State<ListRelative> {
  List<Map<String, dynamic>>? relatives; // Danh sách người dùng
  final String? Url = AppConfigs.baseUrl;
  final String? Path = "storage/Img/AVT/";
  // final ListRelativeViewModel ListRelativeViewModel = ListRelativeViewModel();
//Create relative
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();

  //
  ListRelativeViewModel listRelativeViewModel = ListRelativeViewModel();
//
  String selectedRoleId = '1';
  DateTime? selectedBirthDay;

  String selectedGender = 'male';
  late StreamSubscription<String> emailSubscription;

  int? selectedEmployeeId;
  final TextEditingController manvController = TextEditingController();
  List<Map<String, dynamic>> userid = [];

  @override
  void initState() {
    super.initState();

    fetchRelatives();
//================
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
            title: Text('Relative'),
            content: SingleChildScrollView(
                child: Container(
              child: Column(children: [
                SizedBox(
                    height: 500,
                    width: 800,
                    child: ListView(
                      children: [
                        StreamBuilder<String>(
                            stream: listRelativeViewModel.nameStream,
                            builder: (context, snapshot) {
                              return createrelative("Name:", "Name",
                                  controller: nameController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                          stream: listRelativeViewModel.birthdayStream,
                          builder: (context, snapshot) {
                            return createrelative1("Birthday:", "Birthday",
                                controller: birthdayController,
                                onTap: () => _selectDate(
                                      context,
                                      selectedBirthDay,
                                      (date) {
                                        setState(() {
                                          selectedBirthDay = date;
                                          birthdayController.text =
                                              selectedBirthDay!
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
                            stream: listRelativeViewModel.addressStream,
                            builder: (context, snapshot) {
                              return createrelative("Address:", "Address",
                                  controller: addressController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: listRelativeViewModel.employeeIdStream,
                            builder: (context, snapshot) {
                              return createrelative(
                                  "Employee Id:", "Employee Id",
                                  controller: employeeIdController);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<String>(
                            stream: listRelativeViewModel.relationshipStream,
                            builder: (context, snapshot) {
                              return createrelative(
                                  "Relationship:", "Relationship",
                                  controller: relationshipController);
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
                  Map<String, String> relativeData = {
                    'hotentn': nameController.text,
                    'ngaysinh': birthdayController.text,
                    'diachi': addressController.text,
                    'relationship': relationshipController.text,
                    'userId': employeeIdController.text
                    // Thêm các trường khác tương tự
                  };
                  print(relativeData);
                  // Gọi hàm để tạo người dùng mới
                  await listRelativeViewModel.createRelative(relativeData);

                  Navigator.of(context).pop(); // Đóng dialog khi nút được nhấn
                },
              ),
            ],
          );
        });
  }

  Future<void> fetchRelatives() async {
    try {
      // Sử dụng Provider để lấy EmployeeListViewModel
      var listRelativeViewModel =
          Provider.of<ListRelativeViewModel>(context, listen: false);
      List<Map<String, dynamic>> relativeData =
          await listRelativeViewModel.getAllRelativesApi();
      List a = [relativeData];
      setState(() {
        // Update the list of users
        relatives = List<Map<String, dynamic>>.from(relativeData);
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var relativeViewModel = Provider.of<ListRelativeViewModel>(context);
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: false,
        title: 'Relative List',
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
            StreamBuilder<String>(
              stream: listRelativeViewModel.manv,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    SearchRelativeByUserId(
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
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteConfig.relative, arguments: {
                    'useridadmin': int.parse(manvController.text)
                  });
                  //  print(manvController.text);
                },
                child: Text("Search")),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: relatives![0]['relatives'].length,
            itemBuilder: (context, index) {
              var relative = relatives?[0];
              return Card(
                child: ListTile(
                  // leading: SizedBox(
                  //   width: 50,
                  //   height: 50,
                  //   child: _avatarWidget(Url! +
                  //       Path! +
                  //       relative!['relatives'][index]['avatar'].toString()),
                  // ),
                  title: Text(
                      (relative?['relatives'][index]['id'].toString() != null)
                          ? ("Relative Id: " +
                              relative!['relatives'][index]['id'].toString())
                          : 'Not found'),
                  subtitle: Text((relative?['relatives'][index]['hotentn']
                              .toString() !=
                          null)
                      ? (relative!['relatives'][index]['hotentn'].toString())
                      : 'Not found'),
                  onTap: () {
                    // Gọi hàm xử lý sự kiện khi tiêu đề được nhấn
                    Get.toNamed(RouteConfig.profileRelative,
                        arguments: {'relative': relative!['relatives'][index]});
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      // Gọi hàm xử lý sự kiện khi nút xóa được nhấn
                      // Ví dụ: xóa relative tại vị trí index
                      // print(relative['relatives'][index]['id']);
                      await listRelativeViewModel
                          .removeRelative(relative!['relatives'][index]['id']);
                      setState(() {
                        relative!['relatives'].removeAt(index);
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

Widget createrelative(String title, String hintText,
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
            fontSize: 14,
            fontWeight: FontWeight.w400,
            borderRadius: 10,
            showOutline: true,
            controller: controller,
          ),
        ],
      ));
}

Widget createrelative1(String title, String hintText,
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

Widget SearchRelativeByUserId(String title, String hintText,
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
