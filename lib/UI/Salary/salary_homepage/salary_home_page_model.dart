import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';

import 'package:http/http.dart' as http;
import 'package:meas/Data/repositories/auth_repository.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/routes/routes.dart';

class SalaryHomePageViewModel extends ChangeNotifier {
  static final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String usersToken = "/users";

  Map<String, dynamic>? _user; // Thêm trường dữ liệu mới
  Future<dynamic> getUser(dynamic token) async {
    try {
      print('Sending request with data: $token');
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$usersToken"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(token),
          )
          .timeout(Duration(seconds: 10));

      print('Received response: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
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
