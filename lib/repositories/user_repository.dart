import 'package:flutter_base/models/entities/notifications/notification_entity.dart';
import 'package:flutter_base/models/response/object_response.dart';
import 'package:flutter_base/network/api_client.dart';
import 'package:flutter_base/models/response/array_response.dart';

abstract class UserRepository {
  Future<ArrayResponse<NotificationEntity>> getNotifications(
    int? limit,
    int? page,
  );

  Future<ObjectResponse> addFirebaseToken(String token);
  Future<ObjectResponse> logout();
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
}
