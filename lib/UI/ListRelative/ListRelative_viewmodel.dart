import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:rxdart/rxdart.dart';

class ListRelativeViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String createRelativesEndpoint = "/createRelative";
  static const String getRelativesEndpoint = "/getRelative";
  static const String deleteRelativeEndpoint = "/deleteRelative/";

  ///////////////////////////
  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _birthdaySubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _addressSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _employeeIdSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _relationshipSubject =
      BehaviorSubject<String>();
  ///////////////////////////
  Stream<String> get nameStream => _nameSubject.stream;
  Sink<String> get nameSink => _nameSubject.sink;
  Stream<String> get birthdayStream => _birthdaySubject.stream;
  Sink<String> get birthdaySink => _birthdaySubject.sink;
  Stream<String> get addressStream => _addressSubject.stream;
  Sink<String> get addressSink => _addressSubject.sink;
  Stream<String> get relationshipStream => _relationshipSubject.stream;
  Sink<String> get relationshipSink => _relationshipSubject.sink;
  Stream<String> get employeeIdStream => _employeeIdSubject.stream;
  Sink<String> get employeeIdSink => _employeeIdSubject.sink;

  ////////////////

  Future<List<Map<String, dynamic>>> getAllRelativesApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getRelativesEndpoint"),
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
        throw Exception('Failed to load relatives');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  ///////////////
  Future<Map<String, dynamic>> createRelative(dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$createRelativesEndpoint"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));

      print('Received response: ${response.body}');

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

  /////////////
  Future<void> removeRelative(int RelativeId) async {
    try {
      // Gọi API xóa bằng phương thức DELETE
      final response = await http.get(
        Uri.parse(
            '$Url$apiUrlPath$deleteRelativeEndpoint$RelativeId'), // Thay đổi thành đường dẫn thực tế của user cần xóa
      );

      if (response.statusCode == 200) {
        // Xóa user từ danh sách local nếu API xóa thành công
        print('Delete Successful');
      } else {
        // Xử lý lỗi nếu cần
        print('Error deleting user: ${response.statusCode}');
      }
    } catch (error) {
      // Xử lý lỗi nếu cần
      print('Error: $error');
    }
  }
}
