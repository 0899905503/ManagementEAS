import 'package:flutter/material.dart';
import 'package:flutter_base/UI/widgets/appbar/tk_app_bar.dart';
import 'package:flutter_base/models/enums/main_tab.dart';

class salary extends StatelessWidget {
  const salary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
