// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPermission _$AppPermissionFromJson(Map<String, dynamic> json) =>
    AppPermission(
      inventory: json['inventory'] as bool?,
      essentials: json['essentials'] as bool?,
    );

Map<String, dynamic> _$AppPermissionToJson(AppPermission instance) =>
    <String, dynamic>{
      'inventory': instance.inventory,
      'essentials': instance.essentials,
    };
