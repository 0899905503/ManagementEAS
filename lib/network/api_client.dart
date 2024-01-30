import 'package:dio/dio.dart';
import 'package:flutter_base/models/entities/entitties/attendance_entity.dart';
import 'package:flutter_base/models/entities/entitties/current_state_entity.dart';
import 'package:flutter_base/models/entities/notifications/notification_entity.dart';
import 'package:flutter_base/models/entities/user/profile_entity.dart';
import 'package:flutter_base/models/entities/user/work_off_config.dart';
import 'package:flutter_base/models/response/all_array_response.dart';
import 'package:flutter_base/models/response/login_response.dart';

import 'package:flutter_base/models/response/object_response.dart';
import 'package:flutter_base/models/response/array_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///User
  @POST("/login")
  Future<ObjectResponse<LoginResponse>> authLogin(
      @Body() Map<String, dynamic> body);

  @POST("/logout")
  Future<dynamic> signOut(@Body() Map<String, dynamic> body);

  @POST("/update_language")
  Future<ObjectResponse> updateLanguage(@Body() Map<String, dynamic> body);

  @GET("/app-notifications")
  Future<ArrayResponse<NotificationEntity>> getNotifications(
    @Queries() Map<String, dynamic> params,
  );

  @POST("/update_firebase_token")
  Future<ObjectResponse> addFirebaseToken(
    @Body() Map<String, dynamic> body,
  );

  @POST("/logout")
  Future<ObjectResponse> logout();

  /// TIME KEEPING
  // @GET("/timesheet/user-location")
  // Future<ObjectResponse<AddressEntity>> getAddressByLatLng(
  //   @Queries() Map<String, dynamic> params,
  // );

  @GET("/timesheet/current-state")
  Future<ObjectResponse<CurrentStateEntity>> getCurrentState();

  @POST("/timesheet/check-in-out")
  Future<ObjectResponse> checkInOut(
    @Body() Map<String, dynamic> body,
  );

  @GET("/timesheet/attendances")
  Future<AllArrayResponse<AttendanceEntity>> getAttendances(
    @Queries() Map<String, dynamic> params,
  );

  @GET("/timesheet/leave")
  Future<ObjectResponse<WorkOffConfig>> getWorkOffConfig();

  @POST("/timesheet/leave")
  Future<ObjectResponse> createWorkOff(
    @Body() Map<String, dynamic> body,
  );
  @POST("/timesheet/early-lates")
  Future<ObjectResponse> createWorkLate(
    @Body() Map<String, dynamic> body,
  );

  @POST("/change-password")
  Future<ObjectResponse> changPassword(
    @Body() Map<String, dynamic> body,
  );

  @GET("/profile")
  Future<ObjectResponse<ProfileEntity>> getProfile();

  getAddressByLatLng(Map<String, double?> map) {}
}
