import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/configs/security.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class EmployeeListViewModel extends ChangeNotifier {
  final String? Url = AppConfigs.baseUrl;
  static const String apiUrlPath = "api";
  static const String Users = "/users";
  static const String Auth = "/auth";
  static const String signupEndpoint = "/register";
  static const String getAllUsersEndpoint = "/getAllUsers";
  static const String deleteUser = "/delete/";
  static const String updateUser = "/updateUser/";
  static const String id = '';

  Future<List<Map<String, dynamic>>> getAllUsersApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$Url$apiUrlPath$getAllUsersEndpoint"),
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

  Future<Map<String, dynamic>> createUser(dynamic data) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse("$Url$apiUrlPath$Auth$signupEndpoint"),
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

  // Hàm xóa item và gọi API
  Future<void> deleteItem(int index) async {
    try {
      // Gọi API xóa bằng phương thức DELETE
      final response = await http.get(
        Uri.parse(
            '$Url$apiUrlPath$Auth$deleteUser$index'), // Thay đổi thành đường dẫn thực tế của user cần xóa
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

//API update User
  Future<void> updateUserInfo(int userId, dynamic data) async {
    try {
      final response = await http
          .put(
            Uri.parse('$Url$apiUrlPath$Auth$updateUser$userId'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              // Có thể cần thêm các header khác nếu cần
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));

      print('Received response: ${response.body}');

      if (response.statusCode == 200) {
        // Xử lý khi cập nhật thành công, nếu cần
        print('Update Successful');
      } else {
        // Xử lý khi cập nhật không thành công
        print('Error updating user: ${response.statusCode}');
      }
    } catch (error) {
      // Xử lý lỗi nếu cần
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<dynamic> _userData = [];

  List<dynamic> get userData => _userData;

  void setUserData(List<dynamic> data) {
    _userData = data;
    notifyListeners();
  }

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _PersonalIdSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _firstNameSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _lastNameSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _phoneNumberSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _genderSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _addressSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _qualificationSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _nationalitySubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _ethnicitySubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _languageSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _computerScienceSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _religionSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _issueDateSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _issueBySubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _startDateSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _roleIdSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _permanentAddressSubject =
      BehaviorSubject<String>();

  final BehaviorSubject<bool> _SaveSubject = BehaviorSubject<bool>();

  Stream<String> get emailStream => _emailSubject.stream;
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get personalIdStream => _PersonalIdSubject.stream;
  Sink<String> get personalIdSink => _PersonalIdSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream;
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<String> get firstNameStream => _firstNameSubject.stream;
  Sink<String> get firstNameSink => _firstNameSubject.sink;

  Stream<String> get lastNameStream => _lastNameSubject.stream;
  Sink<String> get lastNameSink => _lastNameSubject.sink;

  Stream<String> get phoneNumberStream => _phoneNumberSubject.stream;
  Sink<String> get phoneNumberSink => _phoneNumberSubject.sink;

  Stream<String> get genderStream => _genderSubject.stream;
  Sink<String> get genderSink => _genderSubject.sink;

  Stream<String> get addressStream => _addressSubject.stream;
  Sink<String> get addressSink => _addressSubject.sink;

  Stream<String> get qualificationStream => _qualificationSubject.stream;
  Sink<String> get qualificationSink => _qualificationSubject.sink;

  Stream<String> get nationalityStream => _nationalitySubject.stream;
  Sink<String> get nationalitySink => _nationalitySubject.sink;

  Stream<String> get ethnicityStream => _ethnicitySubject.stream;
  Sink<String> get ethnicitySink => _ethnicitySubject.sink;

  Stream<String> get languageStream => _languageSubject.stream;
  Sink<String> get languageSink => _languageSubject.sink;

  Stream<String> get computerScienceStream => _computerScienceSubject.stream;
  Sink<String> get computerScienceSink => _computerScienceSubject.sink;

  Stream<String> get religionStream => _religionSubject.stream;
  Sink<String> get religionSink => _religionSubject.sink;

  Stream<String> get issueDateStream => _issueBySubject.stream;
  Sink<String> get issueDateSink => _issueDateSubject.sink;

  Stream<String> get issueBytream => _issueBySubject.stream;
  Sink<String> get issueBySink => _issueBySubject.sink;

  Stream<String> get startDateStream => _startDateSubject.stream;
  Sink<String> get startDateSink => _startDateSubject.sink;

  Stream<String> get roleIdStream => _roleIdSubject.stream;
  Sink<String> get roleIdSink => _roleIdSubject.sink;

  Stream<String> get permanentAddressStream => _permanentAddressSubject.stream;
  Sink<String> get permanentAddressSink => _permanentAddressSubject.sink;

  Stream<bool> get saveStream => _SaveSubject.stream;
  Sink<bool> get saveSink => _SaveSubject.sink;

  EmployeeListViewModel() {
    Stream<bool> saveStream = Rx.combineLatestList([
      emailStream,
      personalIdStream,
      passwordStream,
      firstNameStream,
      lastNameStream,
      phoneNumberStream,
      genderStream,
      addressStream,
      qualificationStream,
      nationalityStream,
      ethnicityStream,
      languageStream,
      computerScienceStream,
      religionStream,
      issueDateStream,
      issueBytream,
      startDateStream,
      roleIdStream,
      permanentAddressStream,
    ]).map((List<String> values) {
      // Kiểm tra điều kiện để trả về giá trị của saveStream
      return values.every((value) => value.isNotEmpty);
    });

    saveStream.listen((enable) {
      saveSink.add(enable);
    });
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _emailController.close();
  // }
}
