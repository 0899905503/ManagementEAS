import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';

class AuthRepository {
  static final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api/auth";
  static const String loginEndpoint = "/signin";
  static const String signupEndpoint = "/signup";

  Future<Map<String, dynamic>> signinApi(dynamic data) async {
    try {
      print('Sending request with data: $data');
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$loginEndpoint"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 2));

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

  Future<Map<String, dynamic>> signupApi(dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$signupEndpoint"),
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
}
