import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:rxdart/rxdart.dart';

class BonusListViewModel extends ChangeNotifier {
  final BehaviorSubject<String> manv = BehaviorSubject<String>();

  Stream<String> get manvStream => manv.stream;
  Sink<String> get manvSink => manv.sink;

  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String showbonuslistbymonthandyear = "/showBonusesByMonth/";
  Future<List<Map<String, dynamic>>> showBonusListByMonthAndYear(
      int year, int month) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$showbonuslistbymonthandyear$month/$year"),
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

class BonusListViewModelProvider extends StatefulWidget {
  final Widget child;

  BonusListViewModelProvider({required this.child});

  static BonusListViewModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BonusListViewModelInherited>()!
        .viewModel;
  }

  @override
  BonusListViewModelProviderState createState() =>
      BonusListViewModelProviderState();
}

class BonusListViewModelProviderState
    extends State<BonusListViewModelProvider> {
  late final BonusListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = BonusListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return BonusListViewModelInherited(
      viewModel: _viewModel,
      child: widget.child,
    );
  }
}

class BonusListViewModelInherited extends InheritedWidget {
  final BonusListViewModel viewModel;

  BonusListViewModelInherited({
    required Widget child,
    required this.viewModel,
  }) : super(child: child);

  @override
  bool updateShouldNotify(BonusListViewModelInherited oldWidget) => true;
}
