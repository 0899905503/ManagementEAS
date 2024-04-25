import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';

class SalaryHistoryViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String salaryhistory = "/salaryHistory/";
  Future<List<Map<String, dynamic>>> getSalaryHistory(int UserId) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$salaryhistory$UserId"),
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
}
