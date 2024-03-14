import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Security {
  Security._();
  static const storage = FlutterSecureStorage();
  final _name = " ";

  static Future<void> saveToken(dynamic token) async {
    await storage.write(key: 'token', value: token);
    // if (token != null && token.isNotEmpty) {
    //   try {
    //     // Giải mã dữ liệu JSON từ chuỗi token
    //     List<String> tokenParts = token.split('|');
    //     if (tokenParts.length == 2) {
    //       String jsonUserData = utf8.decode(base64.decode(tokenParts[1]));
    //       Map<String, dynamic> userData = jsonDecode(jsonUserData);

    //       // Lưu trữ giá trị first_name
    //       String firstName = userData['user']['first_name'];
    //       await _storage.write(key: 'first_name', value: firstName);

    //       print('Token and first_name saved successfully');
    //       // print(token);
    //       print(userData['user']);
    //       // print(firstName);
    //     } else {
    //       print('Invalid token format');
    //     }
    //   } catch (e) {
    //     print('Error saving token: $e');
    //     // Thực hiện xử lý lỗi nếu cần
    //   }
    // } else {
    //   print('Invalid token value');
    // }
  }

// Đọc token từ Flutter Secure Storage
  static Future<String?> readToken() async {
    var temp = await storage.read(key: 'token');
    return temp;
  }

  static Future<String?> readFirstName() async {
    return await storage.read(key: 'first_name');
  }
}
