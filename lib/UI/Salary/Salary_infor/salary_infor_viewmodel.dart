import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';

class SalaryInforViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String getSalaryInfors = "/showSalaryUser/";
  static const String getSalaryByMonth = '/salary/';

  Future<List<Map<String, dynamic>>> getSalaryInfor(int UserId) async {
    String? token = await Security.storage.read(key: 'token');
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getSalaryInfors$UserId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
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
          throw Exception('Invalid response');
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

  Future<List<Map<String, dynamic>>> getSalaryInforByMonth(
      int UserId, int Month, int Year) async {
    String? token = await Security.storage.read(key: 'token');
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getSalaryByMonth$UserId/$Month/$Year"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
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
          throw Exception('Invalid response');
        }
      } else {
        // Handle other HTTP status codes
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        throw Exception('Failed to load salary');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
