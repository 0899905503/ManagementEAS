import 'package:dio/dio.dart';

import 'package:meas/Data/entities/attendance_entity.dart';
import 'package:meas/Data/entities/profile_entity.dart';
import 'package:meas/Data/notifications/notification_entity.dart';
import 'package:meas/Data/response/array_response.dart';
import 'package:meas/Data/response/login_response.dart';
import 'package:meas/Data/response/object_response.dart';
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

  ///
  ///
  @GET("/users")
  Future<ArrayResponse<NotificationEntity>> getUsers(
    @Queries() Map<String, dynamic> params,
  );

  ///

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

  // @GET("/timesheet/current-state")
  // Future<ObjectResponse<CurrentStateEntity>> getCurrentState();

  @POST("/timesheet/check-in-out")
  Future<ObjectResponse> checkInOut(
    @Body() Map<String, dynamic> body,
  );

  // @GET("/timesheet/attendances")
  // Future<AllArrayResponse<AttendanceEntity>> getAttendances(
  //   @Queries() Map<String, dynamic> params,
  // );

  // @GET("/timesheet/leave")
  // Future<ObjectResponse<WorkOffConfig>> getWorkOffConfig();

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
