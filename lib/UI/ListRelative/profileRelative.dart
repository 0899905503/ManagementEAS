import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meas/Data/entities/user_entity.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/enums/load_status.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/appbar/tk_app_bar.dart';
import 'package:meas/widgets/images/app_cache_image.dart';

import 'package:pusher_channels_flutter/pusher-js/core/transports/url_schemes.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class ProfileRelativePage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const ProfileRelativePage({
    Key? key,

    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const ProfileRelativeChildPage(),
    );
  }
}

class ProfileRelativeChildPage extends StatefulWidget {
  const ProfileRelativeChildPage({Key? key}) : super(key: key);

  @override
  State<ProfileRelativeChildPage> createState() =>
      _ProfileRelativeChildPageState();
}

class _ProfileRelativeChildPageState extends State<ProfileRelativeChildPage> {
  Map<String, dynamic>? relativeData;
  @override
  void initState() {
    super.initState();
    // Nhận dữ liệu từ arguments khi khởi tạo màn hình
    relativeData = Get.arguments['relative'];
    // infor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TKCommonAppBar(
        hasLeadingIcon: true,
        title: 'Relative',
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color(0xFFF1F0EF),
          // border: Border.all(color: AppColors.buttonLogin, width: 2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
              width: 2000,
            ),
            SizedBox(
              height: 200,
              width: 600,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.buttonLogin, width: 1)),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Relative Information",
                              style: AppTextStyle.blackS22W800,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor(
                                "Relative Id", relativeData!['id'].toString()),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor(
                              "Name",
                              relativeData!['hotentn'].toString(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // EmployeeInfor(
                            //     "Gender", relativeData!['gender'].toString()),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            EmployeeInfor(
                              "Birth day",
                              DateFormat(AppConfigs.dateAPI).format(
                                  DateTime.parse(
                                      relativeData!['ngaysinh'].toString())),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            EmployeeInfor(
                                "Address", relativeData!['diachi'].toString()),
                            const SizedBox(
                              height: 10,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
            //Dayoff + remaining + working hours + overtime
            //  _workingTime(state.PersonalIF?.essentials),
          ],
        ));
  }

  Widget _avatarWidget(String? url) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          //border: Border.all(color: Colors.white, width: 5),
          boxShadow: [
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

  @override
  void dispose() {
    // _cubit.close();
    super.dispose();
  }
}
