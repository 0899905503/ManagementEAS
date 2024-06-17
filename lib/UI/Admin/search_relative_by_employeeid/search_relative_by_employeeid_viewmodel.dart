import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:rxdart/rxdart.dart';

class SearchRelativeByEmployeeIdViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  final BehaviorSubject<String> manv = BehaviorSubject<String>();

  Stream<String> get manvStream => manv.stream;
  Sink<String> get manvSink => manv.sink;
}
