import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';

class SalaryDetailViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String getSalaryDetailsList = "/getSalaryDetailsList/";
  //
  static const String showSalariesByMonthAndYear1 =
      "/showSalariesByMonthAndYear/";
  Future<List<Map<String, dynamic>>> getSalaryDetail() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getSalaryDetailsList"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 10));

      print('Received response: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData is List) {
          return List<Map<String, dynamic>>.from(responseData);
        } else if (responseData is Map<String, dynamic>) {
          // Handle the case where a single object is returned
          return [responseData];
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

  Future<List<Map<String, dynamic>>> showSalariesByMonthAndYear(
      int year, int month) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$showSalariesByMonthAndYear1$year/$month"),
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

class SalaryDetailViewModelProvider extends StatefulWidget {
  final Widget child;

  SalaryDetailViewModelProvider({required this.child});

  static SalaryDetailViewModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SalaryDetailViewModelInherited>()!
        .viewModel;
  }

  @override
  _SalaryDetailViewModelProviderState createState() =>
      _SalaryDetailViewModelProviderState();
}

class _SalaryDetailViewModelProviderState
    extends State<SalaryDetailViewModelProvider> {
  late final SalaryDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SalaryDetailViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return _SalaryDetailViewModelInherited(
      viewModel: _viewModel,
      child: widget.child,
    );
  }
}

class _SalaryDetailViewModelInherited extends InheritedWidget {
  final SalaryDetailViewModel viewModel;

  _SalaryDetailViewModelInherited({
    required Widget child,
    required this.viewModel,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_SalaryDetailViewModelInherited oldWidget) => true;
}
