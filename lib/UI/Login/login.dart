import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_base/UI/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/UI/widgets/buttons/app_button.dart';
import 'package:flutter_base/UI/widgets/textfields/app_text_field.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/generated/l10n.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // appBar: TKCommonAppBar(hasLeadingIcon: false, title: "login"),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    ));
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFF1F0EF)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Text(
                  "MEAS",
                  style: AppTextStyle.brownS40W800.copyWith(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 49,
                ),
                SizedBox(
                  height: 228,
                  width: 228,
                  child: Image.asset(AppImages.ic_background),
                ),
                const SizedBox(
                  height: 99,
                ),
                const SizedBox(
                  width: 367,
                  child: AppTextField(
                    hintText: "Username ",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    borderRadius: 10,
                    showOutline: true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  width: 367,
                  child: AppTextField(
                    hintText: "Password ",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    borderRadius: 10,
                    showOutline: true,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 204,
                    ),
                    boxMenu("Forgot Password?", 12, FontWeight.w400),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                _buildSignButton(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Text(
                      "You don't have an account ?",
                      style: AppTextStyle.blackS12W400,
                    ),
                    boxMenu("Sign Up", 12, FontWeight.w700)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget boxMenu(String content, double? size, FontWeight weight) {
    return Row(
      children: [
        TextButton(
          child: Text(content,
              style: TextStyle(
                  fontSize: size,
                  fontWeight: weight,
                  color: AppColors.defaultText)),
          onPressed: () {
            if (content == "Login") {
              print(content);
            }
            if (content == "Sign Up") {
              print(content);
            }
          },
        )
      ],
    );
  }

  Widget title(String title1) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: AppTextStyle.brownS20Bold,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildSignButton() {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 80),
      child: AppButton(
        // title: S.current.login,

        title: "Login",
        onPressed: _signIn,
        // isLoading: state.signInStatus == LoadStatus.loading,
      ),
    );
  }

  void _signIn() {
    // _cubit.changeUsername(username: usernameTextController.text);
    // _cubit.changePassword(password: passwordTextController.text);
    // _cubit.signIn(_appSettingCubit.state.locale?.languageCode ?? "de");
  }
}
