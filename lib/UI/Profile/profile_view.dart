import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meas/Data/entities/profile_entity.dart';
import 'package:meas/Data/entities/user_entity.dart';
import 'package:meas/UI/Profile/profile_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/enums/load_status.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';
import 'package:meas/widgets/textfields/app_circular_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class TkProfilePage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const TkProfilePage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const TkProfileChildPage(),
    );
  }
}

class TkProfileChildPage extends StatefulWidget {
  const TkProfileChildPage({Key? key}) : super(key: key);

  @override
  State<TkProfileChildPage> createState() => _TkProfileChildPageState();
}

class _TkProfileChildPageState extends State<TkProfileChildPage> {
  final ProfileViewModel profileViewModel = ProfileViewModel();
  Map<String, dynamic>? res;
  //URL Image
  final String? Url = AppConfigs.baseUrl;
  final String? Path = "storage/Img/AVT/";

  Future<void> getUser() async {
    final String? Url = AppConfigs.baseUrl;
    const String apiUrlPath = "api";
    const String Users = "/users";
    String? token = await Security.storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('$Url$apiUrlPath$Users'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    setState(() {
      res = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
    // _cubit = BlocProvider.of(context);
    // _cubit.getProfile();
  }

  void _pickAndUploadImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery); // Use pickImage instead of getImage
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      await profileViewModel.uploadAvatar(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: 'Profile',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Color(0xFFF1F0EF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Stack(
              children: [
                // _userInfo(),
                _avatarWidget(Url! + Path! + res!['avatar'].toString()),
                Positioned(
                  bottom: 0,
                  left: 770,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: InkWell(
                      onTap: () {
                        // Gọi hàm để chọn ảnh mới và gọi API để lưu ảnh
                        _pickAndUploadImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F0EF), // Màu của nút chọn ảnh
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.buttonLogin,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: 600,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.buttonLogin, width: 1),
                ),
                child: Row(
                  children: [
                    EmployeeInfor("Start Date", res!['Start_Date'].toString()),
                    EmployeeInfor(
                        "Department", res!['Department_id'].toString()),
                    EmployeeInfor("Role Id", res!['Role_id'].toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            //change password
            Row(
              children: [
                const SizedBox(width: 500),
                _itemMenu('Change Password', AppImages.icTkLock,
                    iconBgColor: const Color(0xffF3B7B7), onTap: () {
                  //Get.toNamed(
                  // RouteConfig.tkChangePassword,
                  // );
                  print(res);
                }),
                const SizedBox(width: 15),
                //LOGOUT
                _itemMenu(
                  'Sign Out',
                  AppImages.icTkLogout,
                  onTap: () {
                    _logout();
                  },
                ),
              ],
            ),
          ],
        ));
  }

  void _logout() async {
    // Xóa thông tin đăng nhập khỏi SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('token');

    // Chuyển hướng đến màn hình đăng nhập
    Get.offNamed(RouteConfig.signIn);
  }

  Widget _itemMenu(String title, String iconName,
      {Color? iconBgColor, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff663300)),
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.veryLightGrey,
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBgColor ?? const Color(0xffADD5EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(iconName),
            ),
            const SizedBox(width: 20),
            Text(title, style: AppTextStyle.blackS20Medium)
          ],
        ),
      ),
    );
  }

  Widget _userInfo(UserEntity? userInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20).copyWith(top: 50),
      margin: const EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.buttonBGWhite,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color(0xffA8D5E4),
            Colors.white,
          ],
          stops: [0.0, 1.0],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text(
            userInfo?.fullName ?? "updating",
            style: AppTextStyle.blackS22W800,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userInfo?.essentialsDepartmentName ?? "updating",
                style: AppTextStyle.greyS16,
              ),
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const ShapeDecoration(
                  color: Color(0xFF9BAED4),
                  shape: OvalBorder(),
                ),
              ),
              Text(
                userInfo?.essentialsDesignationName ?? "updating",
                style: AppTextStyle.greyS16,
              ),
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const ShapeDecoration(
                  color: Color(0xFF9BAED4),
                  shape: OvalBorder(),
                ),
              ),
              Text(
                userInfo?.joined ?? "updating",
                style: AppTextStyle.greyS16,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Image.asset(AppImages.icTkPhone),
                  const SizedBox(width: 5),
                  Text(
                    userInfo?.contactNumber ?? "updating",
                    style: AppTextStyle.greyS14,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Image.asset(AppImages.icTkMail),
                  const SizedBox(width: 5),
                  Text(
                    userInfo?.email ?? "updating",
                    style: AppTextStyle.greyS14,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _avatarWidget(String? url) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
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

  Widget _workingTime(Essentials? essentials) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F0FE),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: AppColors.veryLightGrey,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // number of day off
          _workInfo(
            'S.current.number_of_day_off',
            (essentials?.totalLeave ?? 0).toString(),
          ),

          Container(
            width: 0.5,
            height: 40,
            color: Colors.black,
          ),
          //remaining ...
          _workInfo(
            ' S.current.remaining_days_off',
            (essentials?.totalLeaveRemaining ?? 0).toString(),
          ),

          //total working hours
          Container(
            width: 0.5,
            height: 40,
            color: Colors.black,
          ),
          _workInfo(
            ' S.current.working_hours',
            (essentials?.totalWorkingHours ?? 0).toString(),
          ),

          //overtime
          Container(
            width: 0.5,
            height: 40,
            color: Colors.black,
          ),
          _workInfo(
            'S.current.overtime',
            (essentials?.totalWorkingHoursExcessDeficiency ?? 0).toString(),
            contentColor: AppColors.green04B035,
          ),

          //overtime
        ],
      ),
    );
  }

  Widget _workInfo(String title, String content, {Color? contentColor}) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.greyS12.copyWith(color: AppColors.color697082),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: AppTextStyle.blackS20Bold.copyWith(
            color: contentColor,
          ),
        ),
      ],
    );
  }

  Widget EmployeeInfor(String content, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 70),
        Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              content,
              style: AppTextStyle.blackS16W800,
            ),
            const SizedBox(
              height: 10,
            ),
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
    // _cubit.close();
    super.dispose();
  }
}
