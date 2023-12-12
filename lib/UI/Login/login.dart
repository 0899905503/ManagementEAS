import 'package:flutter/material.dart';
import 'package:flutter_base/UI/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/UI/widgets/textfields/app_text_field.dart';
import 'package:flutter_base/common/app_images.dart';

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
          // boxlogin("username", "error"),
          // const SizedBox(
          //   height: 30,
          // ),
          // boxlogin("password", "error"),
          // const AppTextField(
          //   prefixIcon: AppImages.icPerson,
          //   //  enableValidator: state.enableValidate,
          //   hintText: "username ",
          //   background: Color(0xff000000),
          //   fontWeight: FontWeight.bold,
          // ),
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
            child: const Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 350,
                  child: AppTextField(
                    title: "Email",
                    prefixIcon: AppImages.icPerson,
                    //  enableValidator: state.enableValidate,
                    hintText: "username ",
                    background: Color(0xffFFF5EE),
                    fontWeight: FontWeight.bold,
                    borderColor: Color(0xff663300),
                    borderRadius: 30,
                    showOutline: true,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 350,
                  child: AppTextField(
                    title: "Password",
                    prefixIcon: AppImages.icPerson,
                    //  enableValidator: state.enableValidate,
                    hintText: "password ",
                    background: Color(0xffFFF5EE),
                    fontWeight: FontWeight.bold,
                    borderColor: Color(0xff663300),
                    borderRadius: 30,
                    showOutline: true,
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget boxlogin(String input, String error) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: input,
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
            errorText: error,
            errorStyle: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
