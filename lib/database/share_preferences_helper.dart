import 'dart:convert';

import 'package:meas/Data/response/login_response.dart';
import 'package:meas/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _introKey = '_introKey';

  static const _authKey = '_authKey';
  static const _rememberAccount = '_rememberAccount';
  static const _accountPermission = '_accountPermission';

  //Get authKey
  static Future<String> getApiTokenKey() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_authKey) ?? "";
    } catch (e) {
      logger.e(e);
      return "";
    }
  }

  //Set authKey
  static void setApiTokenKey(String apiTokenKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authKey, apiTokenKey);
  }

  static Future<void> removeApiTokenKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
  }

  //Get intro
  static Future<bool> isSeenIntro() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_introKey) ?? false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  //Set intro
  static void setSeenIntro({isSeen = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introKey, isSeen ?? true);
  }

  static Future<bool> isRememberAccount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_rememberAccount) ?? false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  static void setRememberAccount({isRemember = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberAccount, isRemember ?? true);
  }

  static Future<bool> removeRememberAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_rememberAccount);
  }

  static Future<LoginResponse?> getLoginResponse() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = prefs.getString(_accountPermission) ?? "";
      if (data.isNotEmpty) {
        return LoginResponse.fromJson(json.decode(data));
      }
      return null;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static void setLoginResponse(LoginResponse data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accountPermission, json.encode(data));
  }

  static Future<bool> removeLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_accountPermission);
  }
}
