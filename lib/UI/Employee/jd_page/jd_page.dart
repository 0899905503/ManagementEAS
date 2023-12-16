import 'package:flutter/material.dart';
import 'package:flutter_base/UI/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/models/enums/main_tab.dart';

class Homepage1 extends StatelessWidget {
  const Homepage1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: TKCommonAppBar(
          hasLeadingIcon: false,
          title: "jd",
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
