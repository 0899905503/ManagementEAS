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
        child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _avatarWidget(
            "https://www.facebook.com/photo/?fbid=1727432611111174&set=a.113413545846430.png"),
        const SizedBox(
          height: 10,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userInfo("Age : ", "18"),
            const SizedBox(
              height: 5,
            ),
            userInfo("Gentle : ", "Male"),
            const SizedBox(
              height: 5,
            ),
            userInfo("Id : ", "03052003"),
            const SizedBox(
              height: 5,
            ),
          ],
        )),
        const SizedBox(
          height: 10,
        ),
        _itemMenu(
          "Change password",
          AppImages.icTkLock,
          iconBgColor: Colors.green,
          onTap: () => print("change password"),
        ),
        const SizedBox(
          height: 10,
        ),
        _itemMenu("Logout", AppImages.icTkLogout, onTap: () => print("logout")),
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
          color: const Color(0xffEECBAD),
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

  Widget userInfo(String title, String detail) {
    return Column(
      children: [
        Text(
          title + detail,
          style: AppTextStyle.blackS20Bold,
        )
      ],
    );
  }
}
