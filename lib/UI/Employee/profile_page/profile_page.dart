import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // appBar: TKCommonAppBar(hasLeadingIcon: false, title: "Profile"),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    ));
  }

  Widget _buildBodyWidget() {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF1F0EF),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                userInfo(),
                _avatarWidget(
                    "https://upos.nq72.de/uploads/media/1701657308_595413654_OIG.y7Qm3KY4fs5"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _itemMenu(
              "Change password",
              AppImages.icTkLock,
              iconBgColor: Colors.red[200],
              onTap: () => print("change password"),
            ),
            const SizedBox(
              height: 10,
            ),
            _itemMenu("Logout", AppImages.icTkLogout,
                onTap: () => print("logout")),
          ],
        ));
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

  Widget _itemMenu(String title, String iconName,
      {Color? iconBgColor, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderMenuItem, width: 1),
          color: Colors.white,
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

  Widget userInfo() {
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
            Color(0xff663300),
            Color.fromARGB(255, 110, 73, 36),
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
            "name",
            style: AppTextStyle.whiteS22W800,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "chuc vu",
                style: AppTextStyle.whiteS16,
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
                "nam tham gia",
                style: AppTextStyle.whiteS16,
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
                " text",
                style: AppTextStyle.whiteS16,
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
                    "phone number",
                    style: AppTextStyle.whiteS14,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Image.asset(AppImages.icTkMail),
                  const SizedBox(width: 5),
                  Text(
                    "email",
                    style: AppTextStyle.whiteS14,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _workingTime() {
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

          //overtime
        ],
      ),
    );
  }
}
