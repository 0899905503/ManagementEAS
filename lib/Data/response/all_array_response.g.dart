// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_array_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllArrayResponse<T> _$AllArrayResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AllArrayResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$AllArrayResponseToJson<T>(
  AllArrayResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map(toJsonT).toList(),
      'message': instance.message,
    };
