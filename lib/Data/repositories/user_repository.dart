import 'package:meas/Data/network/api_client.dart';
import 'package:meas/Data/notifications/notification_entity.dart';
import 'package:meas/Data/response/array_response.dart';
import 'package:meas/Data/response/object_response.dart';

abstract class UserRepository {
  Future<ArrayResponse<NotificationEntity>> getNotifications(
    int? limit,
    int? page,
  );

  Future<ObjectResponse> addFirebaseToken(String token);
  Future<ObjectResponse> logout();
  Future<ObjectResponse> getUsers(String token);
}

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<ArrayResponse<NotificationEntity>> getNotifications(
      int? limit, int? page) async {
    return await apiClient.getNotifications({
      "limit": limit,
      "page": page,
    });
  }

  @override
  Future<ObjectResponse> addFirebaseToken(String token) async {
    return await apiClient.addFirebaseToken({
      "firebase_token": token,
    });
  }

  @override
  Future<ObjectResponse> logout() async {
    return await apiClient.logout();
  }

  @override
  Future<ObjectResponse> getUsers(String token) async {
    // TODO: implement getUsers
    return await apiClient.addFirebaseToken({"firebase_token": token});
  }
}
