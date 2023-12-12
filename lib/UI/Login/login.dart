import 'package:flutter/material.dart';
import 'package:flutter_base/UI/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/UI/widgets/textfields/app_text_field.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
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

  @override
  Widget _buildBodyWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff663300),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 350,
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
                      boxMenu("Login"),
                      boxMenu("Sign Up"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
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
                SizedBox(
                  height: 15,
                ),
                SizedBox(
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
                  width: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget boxMenu(String content) {
    String value;
    return Row(
      children: [
        TextButton(
          child: Text(content, style: AppTextStyle.brownS20W800),
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
}
