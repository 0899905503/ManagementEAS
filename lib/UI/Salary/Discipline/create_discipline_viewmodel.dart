import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:rxdart/rxdart.dart';

class CreateDisciplineViewModel extends ChangeNotifier {
  final BehaviorSubject<String> ngaykyluat = BehaviorSubject<String>();
  final BehaviorSubject<String> lydo = BehaviorSubject<String>();
  final BehaviorSubject<String> makyluat = BehaviorSubject<String>();
  final BehaviorSubject<String> manv = BehaviorSubject<String>();
  final BehaviorSubject<String> hinhthuc = BehaviorSubject<String>();
  final BehaviorSubject<bool> _SaveSubject = BehaviorSubject<bool>();
  final BehaviorSubject<String> tienphat = BehaviorSubject<String>();

  Stream<String> get makyluatStream => makyluat.stream;
  Sink<String> get makyluatSink => makyluat.sink;

  Stream<String> get lydoStream => lydo.stream;
  Sink<String> get lydoSink => lydo.sink;

  Stream<String> get ngaykyluatStream => ngaykyluat.stream;
  Sink<String> get ngaykyluatSink => ngaykyluat.sink;

  Stream<String> get manvStream => manv.stream;
  Sink<String> get manvSink => manv.sink;

  Stream<String> get tienphatStream => tienphat.stream;
  Sink<String> get tienphatSink => tienphat.sink;

  Stream<bool> get saveStream => _SaveSubject.stream;
  Sink<bool> get saveSink => _SaveSubject.sink;
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";

  static const String createDiscipline = "/store";
  static const String getDisciplineId = "/disciplines";

  Future<Map<String, dynamic>> createEmployeeDiscipline(dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$createDiscipline"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));

      print('Received response create discipline: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else if (response.statusCode == 400) {
        return responseData;
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        return responseData;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getDisciplineIds() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getDisciplineId"),
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
        throw Exception('Failed to load users id');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Map<String, dynamic>> getDisciplineName(int disciplineid) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getDisciplineId/$disciplineid"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 10));

      print('Received response discipline name: ${response.body}');
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseData;
      } else if (response.statusCode == 400) {
        return responseData;
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        return responseData;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  CreateDisciplineViewModel() {
    Stream<bool> saveStream = Rx.combineLatestList([
      makyluatStream,
      lydoStream,
      ngaykyluatStream,
      manv,
      tienphatStream,
    ]).map((List<String> values) {
      // Kiểm tra điều kiện để trả về giá trị của saveStream
      return values.every((value) => value.isNotEmpty);
    });

    saveStream.listen((enable) {
      saveSink.add(enable);
    });
  }
}

class CreateDisciplineViewModelProvider extends StatefulWidget {
  final Widget child;

  CreateDisciplineViewModelProvider({required this.child});

  static CreateDisciplineViewModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            _CreateDisciplineViewModelInherited>()!
        .viewModel;
  }

  @override
  _CreateDisciplineViewModelProviderState createState() =>
      _CreateDisciplineViewModelProviderState();
}

class _CreateDisciplineViewModelProviderState
    extends State<CreateDisciplineViewModelProvider> {
  late final CreateDisciplineViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CreateDisciplineViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return _CreateDisciplineViewModelInherited(
      viewModel: _viewModel,
      child: widget.child,
    );
  }
}

class _CreateDisciplineViewModelInherited extends InheritedWidget {
  final CreateDisciplineViewModel viewModel;

  const _CreateDisciplineViewModelInherited({
    required Widget child,
    required this.viewModel,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_CreateDisciplineViewModelInherited oldWidget) =>
      true;
}
