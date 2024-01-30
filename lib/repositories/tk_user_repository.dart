import 'package:flutter_base/models/entities/entitties/address_entity.dart';
import 'package:flutter_base/models/entities/entitties/attendance_entity.dart';
import 'package:flutter_base/models/entities/entitties/current_state_entity.dart';
import 'package:flutter_base/models/entities/user/profile_entity.dart';
import 'package:flutter_base/models/entities/user/work_off_config.dart';
import 'package:flutter_base/models/params/create_work_late_param.dart';
import 'package:flutter_base/models/params/create_work_off_param.dart';

import 'package:flutter_base/models/response/all_array_response.dart';
import 'package:flutter_base/models/response/object_response.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class TKUserRepository {
  Future<ObjectResponse<AddressEntity>> getAddressByLatLng(
    double? lat,
    double? long,
  );

  Future<ObjectResponse<CurrentStateEntity>> getCurrentState();

  Future<ObjectResponse> checkInOut(
    String? type,
    double? lat,
    double? long,
  );

  Future<AllArrayResponse<AttendanceEntity>> getAttendances(
    String? startDate,
    String? endDate,
  );

  Future<ObjectResponse<WorkOffConfig>> getWorkOffConfig();

  Future<ObjectResponse> createWorkOff(CreateWorkOffParam param);

  Future<ObjectResponse> createWorkLate(CreateWorkLateParam param);

  Future<ObjectResponse> changPassword(
      String? crrPassword, String? newPassword);

  Future<ObjectResponse<ProfileEntity>> getProfile();

  Future<ObjectResponse> logout(String? username, String? password);
}

class TKUserRepositoryImpl extends TKUserRepository {
  ApiClient apiClient;

  TKUserRepositoryImpl({required this.apiClient});

  @override
  Future<ObjectResponse<AddressEntity>> getAddressByLatLng(
    double? lat,
    double? long,
  ) async {
    return await apiClient.getAddressByLatLng({
      "lat": lat,
      "long": long,
    });
  }

  @override
  Future<ObjectResponse> checkInOut(
    String? type,
    double? lat,
    double? long,
  ) async {
    return await apiClient.checkInOut({
      "type": type,
      "lat": lat,
      "long": long,
    });
  }

  @override
  Future<ObjectResponse<CurrentStateEntity>> getCurrentState() async {
    return await apiClient.getCurrentState();
  }

  @override
  Future<AllArrayResponse<AttendanceEntity>> getAttendances(
      String? startDate, String? endDate) async {
    return await apiClient.getAttendances({
      "start_date": startDate,
      "end_date": endDate,
    });
  }

  @override
  Future<ObjectResponse> changPassword(
      String? crrPassword, String? newPassword) async {
    return await apiClient.changPassword(
        {"current_password": crrPassword, "new_password": newPassword});
  }

  @override
  Future<ObjectResponse<ProfileEntity>> getProfile() async {
    return await apiClient.getProfile();
  }

  @override
  Future<ObjectResponse> logout(String? username, String? password) async {
    return await apiClient.signOut({
      "username": username,
      "password": password,
    });
  }

  @override
  Future<ObjectResponse<WorkOffConfig>> getWorkOffConfig() async {
    return await apiClient.getWorkOffConfig();
  }

  @override
  Future<ObjectResponse> createWorkOff(CreateWorkOffParam param) async {
    return await apiClient.createWorkOff(param.toJson());
  }

  @override
  Future<ObjectResponse> createWorkLate(CreateWorkLateParam param) async {
    return await apiClient.createWorkLate(param.toJson());
  }
}
