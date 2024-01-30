import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/models/response/login_response.dart';
import 'package:flutter_base/models/response/object_response.dart';
import 'package:flutter_base/network/api_client.dart';

import '../models/entities/token_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<ObjectResponse<LoginResponse>> signIn(
    String username,
    String password,
    String locale,
  );

  Future<ObjectResponse> updateLanguage(String locale);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<ObjectResponse<LoginResponse>> signIn(
      String username, String password, String locale) async {
    return apiClient.authLogin({
      "username": username,
      "password": password,
      "language": locale,
    });
  }

  @override
  Future<ObjectResponse> updateLanguage(String locale) async {
    return await apiClient.updateLanguage({
      "language": locale,
    });
  }
}
