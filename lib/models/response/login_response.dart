import 'package:flutter_base/models/entities/user/app_permission.dart';
import 'package:flutter_base/models/entities/user/permission_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';

class LoginResponse {
  UserEntity? user;
  //BusinessEntity? business;
  PermissionEntity? permissions;
  AppPermission? appPermissions;

  LoginResponse({
    this.user,
    //this.business,
    this.permissions,
    this.appPermissions,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserEntity.fromJson(json['user']) : null;
    // business = json['business'] != null
    //     ? BusinessEntity.fromJson(json['business'])
    //     : null;
    permissions = json['permissions'] != null
        ? PermissionEntity.fromJson(json['permissions'])
        : null;
    appPermissions = json['app_permissions'] != null
        ? AppPermission.fromJson(json['app_permissions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (permissions != null) {
      data['permissions'] = permissions!.toJson();
    }
    // if (business != null) {
    //   data['business'] = business!.toJson();
    // }
    if (appPermissions != null) {
      data['app_permissions'] = appPermissions!.toJson();
    }
    return data;
  }
}
