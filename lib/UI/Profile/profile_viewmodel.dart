import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:pusher_channels_flutter/pusher-js/core/transports/url_schemes.dart';

class ProfileViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api/";
  static const String storeImage = "storeImage";
  static const String logOut = "logout";

  Future<void> uploadAvatar(Uint8List avatarBytes) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$Url$apiUrlPath$storeImage'),
      );

      // Thêm token và key vào header Authorization nếu cần
      String? token = await Security.storage.read(key: 'token');
      String? key = "avatar"; // Thay bằng key của bạn

      if (token != null && key != null) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Key'] = key;
      }

      request.files.add(http.MultipartFile.fromBytes(
        'avatar',
        avatarBytes,
        filename: 'avatar.jpg',
      ));

      var response = await request.send();

      print(
          'Received response: ${response.statusCode} - ${response.reasonPhrase}');

      if (response.statusCode == 200) {
        // Xử lý khi cập nhật thành công
        print('Avatar update successful');
      } else {
        // Xử lý khi cập nhật không thành công
        print('Error updating avatar: ${response.statusCode}');
      }
    } catch (error) {
      // Xử lý lỗi nếu cần
      print('Error: $error');
    }
  }

  Future<void> logout() async {
    String? token = await Security.storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$Url$apiUrlPath$logOut'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thay thế bằng token của bạn
      },
    );

    if (response.statusCode == 200) {
      print('Logged out successfully');
    } else {
      print('Failed to logout: ${response.statusCode}');
    }
  }
}
