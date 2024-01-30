// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'array_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArrayResponse<T> _$ArrayResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ArrayResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : ArrayData<T>.fromJson(json['data'] as Map<String, dynamic>,
              (value) => fromJsonT(value)),
    );

Map<String, dynamic> _$ArrayResponseToJson<T>(
  ArrayResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(
        (value) => toJsonT(value),
      ),
      'message': instance.message,
    };

ArrayData<T> _$ArrayDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ArrayData<T>(
      from: json['from'] as int? ?? 0,
      to: json['to'] as int? ?? 0,
      currentPage: json['current_page'] as int? ?? 0,
      lastPage: json['last_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
    );

Map<String, dynamic> _$ArrayDataToJson<T>(
  ArrayData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'total': instance.total,
      'data': instance.data.map(toJsonT).toList(),
    };
