import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/UI/Admin/search_relative_by_employeeid/search_relative_by_employeeid_viewmodel.dart';
import 'package:meas/UI/Salary/Discipline/create_discipline_viewmodel.dart';
import 'package:meas/UI/Salary/Salary_statistics/salary_statistics_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher-js/core/transports/url_schemes.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class SearchRelativeByEmployeeIdPage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const SearchRelativeByEmployeeIdPage({
    Key? key,

    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const SearchRelativeByEmployeeIdChildPage(),
    );
  }
}

class SearchRelativeByEmployeeIdChildPage extends StatefulWidget {
  const SearchRelativeByEmployeeIdChildPage({Key? key}) : super(key: key);

  @override
  State<SearchRelativeByEmployeeIdChildPage> createState() =>
      _SearchRelativeByEmployeeIdChildPageState();
}

class _SearchRelativeByEmployeeIdChildPageState
    extends State<SearchRelativeByEmployeeIdChildPage> {
  // List<Map<String, dynamic>>? SearchRelativeByEmployeeIdData;
  List<Map<String, dynamic>>? searchRelativeByEmployeeIdByMonthData;
  bool isLoading = false; // Thêm biến trạng thái isLoading
  // selectdate
  SalaryDetailViewModel salaryDetailViewModel1 = SalaryDetailViewModel();
  List<Map<String, dynamic>> userid = [];
  int? selectedEmployeeId;
  late int userId;
  late SearchRelativeByEmployeeIdViewModel searchRelativeByEmployeeIdViewModel;
  final TextEditingController manvController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Nhận dữ liệu từ arguments khi khởi tạo màn hình
    // userId = Get.arguments['userId'];
    // infor();
    //fetchUsers();
    fetchEmployeeIds();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchRelativeByEmployeeIdViewModel =
        Provider.of<SearchRelativeByEmployeeIdViewModel>(context);
  }

  // Future<void> fetchUsers() async {
  //   try {
  //     // Sử dụng Provider để lấy RelativeListViewModel
  //     var SearchRelativeByEmployeeIdviewmodel =
  //         Provider.of<SearchRelativeByEmployeeIdViewModel>(context, listen: false);
  //     List<Map<String, dynamic>> salaryData =
  //         // await SearchRelativeByEmployeeIdviewmodel.getSearchRelativeByEmployeeId(userId);
  //           int.parse(userId.toString()) ;
  //     setState(() {
  //       // Update the list of users
  //       SearchRelativeByEmployeeIdData = List<Map<String, dynamic>>.from(salaryData);
  //     });
  //   } catch (e) {
  //     print('Error fetching users: $e');
  //   }
  // }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: 'Search Employee Relative',
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
      StreamBuilder<String>(
        stream: searchRelativeByEmployeeIdViewModel.manv,
        builder: (context, snapshot) {
          return Row(
            children: [
              createDisciplineEmployee(
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
            Get.toNamed(RouteConfig.relative,
                arguments: {'useridadmin': int.parse(manvController.text)});
            //  print(manvController.text);
          },
          child: Text("Search")),
    ]);
  }
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
