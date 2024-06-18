import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:rxdart/rxdart.dart';

class ShowBonusByEmployeeIdViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String showBonusesByEmployeeId = "/showBonusesByEmployeeId/";
  Future<List<Map<String, dynamic>>> GetBonusesByEmployeeId(int userid) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$showBonusesByEmployeeId$userid"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 10));

      print('Received response: ${response.body}');

      if (response.statusCode == 200) {
        var responseData1 = jsonDecode(response.body);
        if (responseData1 is List) {
          return List<Map<String, dynamic>>.from(responseData1);
        } else if (responseData1 is Map<String, dynamic>) {
          // Handle the case where a single object is returned
          return [responseData1];
        } else {
          throw Exception('Invalid response format - Not a List');
        }
      } else {
        // Handle other HTTP status codes
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class ShowBonusByEmployeeIdViewModelProvider extends StatefulWidget {
  final Widget child;

  ShowBonusByEmployeeIdViewModelProvider({required this.child});

  static ShowBonusByEmployeeIdViewModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            ShowBonusByEmployeeIdViewModelInherited>()!
        .viewModel;
  }

  @override
  ShowBonusByEmployeeIdViewModelProviderState createState() =>
      ShowBonusByEmployeeIdViewModelProviderState();
}

class ShowBonusByEmployeeIdViewModelProviderState
    extends State<ShowBonusByEmployeeIdViewModelProvider> {
  late final ShowBonusByEmployeeIdViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ShowBonusByEmployeeIdViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ShowBonusByEmployeeIdViewModelInherited(
      viewModel: _viewModel,
      child: widget.child,
    );
  }
}

class ShowBonusByEmployeeIdViewModelInherited extends InheritedWidget {
  final ShowBonusByEmployeeIdViewModel viewModel;

  ShowBonusByEmployeeIdViewModelInherited({
    required Widget child,
    required this.viewModel,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ShowBonusByEmployeeIdViewModelInherited oldWidget) =>
      true;
}
