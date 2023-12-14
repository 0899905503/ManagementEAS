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
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff663300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 200,
          ),
          SizedBox(
              height: 120,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[title("Hey!", "Welcome Back")],
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 469,
            decoration: const BoxDecoration(
              color: Color(0xffEECBAD),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
                bottom: Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      boxMenu("Login", 25, FontWeight.w800),
                      boxMenu("Sign Up", 25, FontWeight.w800),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  width: 350,
                  child: AppTextField(
                    title: "Email",
                    // prefixIcon: AppImages.icPerson,
                    //  enableValidator: state.enableValidate,
                    // hintText: "username ",
                    background: Color(0xffFFF5EE),
                    fontWeight: FontWeight.bold,
                    borderColor: Color(0xff663300),
                    borderRadius: 30,
                    showOutline: true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  width: 350,
                  child: AppTextField(
                    title: "Password",
                    // prefixIcon: AppImages.icPerson,
                    //  enableValidator: state.enableValidate,
                    // hintText: "password ",
                    background: Color(0xffFFF5EE),
                    fontWeight: FontWeight.bold,
                    borderColor: Color(0xff663300),
                    borderRadius: 30,
                    showOutline: true,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildSignButton(),
                Row(
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    boxMenu("Or sign up here", 14, FontWeight.w400),
                  ],
                ),
                Text(
                  "BAVO",
                  style: AppTextStyle.brownS14,
                )
              ],
            ),
          ),
        ],
      ),
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

  Widget title(String title1, String title2) {
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
                  style: AppTextStyle.whiteS50W800,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title2,
                  style: AppTextStyle.whiteS50W800,
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildSignButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
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
