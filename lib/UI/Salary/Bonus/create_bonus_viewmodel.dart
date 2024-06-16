import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:rxdart/rxdart.dart';

class CreateBonusViewModel extends ChangeNotifier {
  final BehaviorSubject<String> ngaykhenthuong = BehaviorSubject<String>();
  final BehaviorSubject<String> lydo = BehaviorSubject<String>();
  final BehaviorSubject<String> makhenthuong = BehaviorSubject<String>();
  final BehaviorSubject<String> manv = BehaviorSubject<String>();
  final BehaviorSubject<String> hinhthuc = BehaviorSubject<String>();
  final BehaviorSubject<bool> _SaveSubject = BehaviorSubject<bool>();
  final BehaviorSubject<String> tienthuong = BehaviorSubject<String>();

  Stream<String> get makhenthuongStream => makhenthuong.stream;
  Sink<String> get makhenthuongSink => makhenthuong.sink;

  Stream<String> get lydoStream => lydo.stream;
  Sink<String> get lydoSink => lydo.sink;

  Stream<String> get ngaykhenthuongStream => ngaykhenthuong.stream;
  Sink<String> get ngaykhenthuongSink => ngaykhenthuong.sink;

  Stream<String> get manvStream => manv.stream;
  Sink<String> get manvSink => manv.sink;

  Stream<String> get tienthuongStream => tienthuong.stream;
  Sink<String> get tienthuongSink => tienthuong.sink;

  Stream<bool> get saveStream => _SaveSubject.stream;
  Sink<bool> get saveSink => _SaveSubject.sink;
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";

  static const String createBonus = "/bonus";
  static const String getBonusId = "/bonusid";
  static const String bonusName = "/bonus";

  Future<Map<String, dynamic>> createEmployeeBonus(dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$createBonus"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));

      print('Received response create bonus: ${response.body}');

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

  Future<List<Map<String, dynamic>>> getBonusIds() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getBonusId"),
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

  Future<Map<String, dynamic>> getBonusName(int Bonusid) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$bonusName/$Bonusid"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 10));

      print('Received response Bonus name: ${response.body}');
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

  CreateBonusViewModel() {
    Stream<bool> saveStream = Rx.combineLatestList([
      makhenthuongStream,
      lydoStream,
      ngaykhenthuongStream,
      manv,
      tienthuongStream,
    ]).map((List<String> values) {
      // Kiểm tra điều kiện để trả về giá trị của saveStream
      return values.every((value) => value.isNotEmpty);
    });

    saveStream.listen((enable) {
      saveSink.add(enable);
    });
  }
}

class CreateBonusViewModelProvider extends StatefulWidget {
  final Widget child;

  CreateBonusViewModelProvider({required this.child});

  static CreateBonusViewModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CreateBonusViewModelInherited>()!
        .viewModel;
  }

  @override
  _CreateBonusViewModelProviderState createState() =>
      _CreateBonusViewModelProviderState();
}

class _CreateBonusViewModelProviderState
    extends State<CreateBonusViewModelProvider> {
  late final CreateBonusViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CreateBonusViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return _CreateBonusViewModelInherited(
      viewModel: _viewModel,
      child: widget.child,
    );
  }
}

class _CreateBonusViewModelInherited extends InheritedWidget {
  final CreateBonusViewModel viewModel;

  const _CreateBonusViewModelInherited({
    required Widget child,
    required this.viewModel,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_CreateBonusViewModelInherited oldWidget) => true;
}
