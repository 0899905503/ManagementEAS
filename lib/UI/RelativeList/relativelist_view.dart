import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meas/UI/RelativeList/relativelist_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:provider/provider.dart';

class RelativeList extends StatefulWidget {
  const RelativeList({Key? key}) : super(key: key);

  @override
  State<RelativeList> createState() => _RelativeListState();
}

class _RelativeListState extends State<RelativeList> {
  List<Map<String, dynamic>>? relatives;
  late int userData; // Danh sách người dùng

  @override
  void initState() {
    super.initState();
    userData = Get.arguments['user'];
    fetchUsers(); // Gọi hàm để lấy thông tin người dùng khi Widget được tạo
  }

  Future<void> fetchUsers() async {
    try {
      // Sử dụng Provider để lấy RelativeListViewModel
      var relativeListViewModel =
          Provider.of<RelativeListViewModel>(context, listen: false);
      List<Map<String, dynamic>> relativeData =
          await relativeListViewModel.getRelativeApi(userData);
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
    var userViewModel = Provider.of<RelativeListViewModel>(context);
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: false,
        title: 'Ralationship List',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Scaffold(
      body: ListView.builder(
        itemCount: relatives![0]['relatives'].length,
        itemBuilder: (context, index) {
          var relative = relatives?[0];
          return Card(
            child: ListTile(
              title: Text((relative!['relatives'][index]['relative_info']
                              ['hotentn']
                          .toString() !=
                      null)
                  ? relative!['relatives'][index]['relative_info']['hotentn']
                      .toString()
                  : 'No Name'),
              subtitle: Text((relative!['relatives'][index]['relationships']
                          .toString() !=
                      null)
                  ? ("Relationship:" +
                      " " +
                      relative!['relatives'][index]['relationships'].toString())
                  : 'Error'),
              onTap: () {
                // Gọi hàm xử lý sự kiện khi tiêu đề được nhấn
                Get.toNamed(RouteConfig.relativeInformation,
                    arguments: {'relative': relative!['relatives'][index]});
              },
            ),
          );
        },
      ),
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
  String name,
  String department,
  //String img,
  {
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        border: Border.all(color: AppColors.borderMenuItem, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Image.asset(
          //   img,
          //   width: 40,
          //   height: 32,
          // ),

          const SizedBox(
            width: 20,
          ),
          Text(
            name,
            style: AppTextStyle.brownS30W700.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            department,
            style: AppTextStyle.brownS30W700.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}
