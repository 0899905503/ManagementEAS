import 'package:meas/Data/entities/attendance_entity.dart';
import 'package:meas/Data/entities/profile_entity.dart';
import 'package:meas/Data/network/api_client.dart';
import 'package:meas/Data/response/all_array_response.dart';
import 'package:meas/Data/response/object_response.dart';

abstract class TKUserRepository {
  // Future<ObjectResponse<AddressEntity>> getAddressByLatLng(
  //   double? lat,
  //   double? long,
  // );

  //Future<ObjectResponse<CurrentStateEntity>> getCurrentState();

  Future<ObjectResponse> checkInOut(
    String? type,
    double? lat,
    double? long,
  );

  Future<AllArrayResponse<AttendanceEntity>> getAttendances(
    String? startDate,
    String? endDate,
  );

  // Future<ObjectResponse<WorkOffConfig>> getWorkOffConfig();

  // Future<ObjectResponse> createWorkOff(CreateWorkOffParam param);

  // Future<ObjectResponse> createWorkLate(CreateWorkLateParam param);

  Future<ObjectResponse> changPassword(
      String? crrPassword, String? newPassword);

  Future<ObjectResponse<ProfileEntity>> getProfile();

  Future<ObjectResponse> logout(String? username, String? password);
}

class TKUserRepositoryImpl extends TKUserRepository {
  ApiClient apiClient;

  TKUserRepositoryImpl({required this.apiClient});

  // @override
  // Future<ObjectResponse<AddressEntity>> getAddressByLatLng(
  //   double? lat,
  //   double? long,
  // ) async {
  //   return await apiClient.getAddressByLatLng({
  //     "lat": lat,
  //     "long": long,
  //   });
  // }
  // Future<AllArrayResponse<AttendanceEntity>> getAttendances(
  //   String? startDate,
  //   String? endDate,
  // );
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

  // @override
  // Future<ObjectResponse<CurrentStateEntity>> getCurrentState() async {
  //   return await apiClient.getCurrentState();
  // }

  // @override
  // Future<AllArrayResponse<AttendanceEntity>> getAttendances(
  //     String? startDate, String? endDate) async {
  //   return await apiClient.getAttendances({
  //     "start_date": startDate,
  //     "end_date": endDate,
  //   });
  // }

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
  Future<ObjectResponse<dynamic>> getCurrentState() {
    // TODO: implement getCurrentState
    throw UnimplementedError();
  }

  @override
  Future<ObjectResponse<dynamic>> getAddressByLatLng(
      double? lat, double? long) {
    // TODO: implement getAddressByLatLng
    throw UnimplementedError();
  }

  @override
  Future<AllArrayResponse<AttendanceEntity>> getAttendances(
      String? startDate, String? endDate) {
    // TODO: implement getAttendances
    throw UnimplementedError();
  }

  // @override
  // Future<ObjectResponse<WorkOffConfig>> getWorkOffConfig() async {
  //   return await apiClient.getWorkOffConfig();
  // }

  // @override
  // Future<ObjectResponse> createWorkOff(CreateWorkOffParam param) async {
  //   return await apiClient.createWorkOff(param.toJson());
  // }

  // @override
  // Future<ObjectResponse> createWorkLate(CreateWorkLateParam param) async {
  //   return await apiClient.createWorkLate(param.toJson());
  // }
}
