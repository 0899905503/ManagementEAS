import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class PersonalInformationViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String getUserById = "/getUserById/";

  Future<Map<String, dynamic>> userInfor(int userid) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getUserById$userid"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

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
}
