// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_work_late_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWorkLateParam _$CreateWorkLateParamFromJson(Map<String, dynamic> json) =>
    CreateWorkLateParam(
      date: json['date'] as String?,
      time: json['time'] as String?,
      timeTo: json['time_to'] as String?,
      reason: json['reason'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$CreateWorkLateParamToJson(
        CreateWorkLateParam instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'time_to': instance.timeTo,
      'reason': instance.reason,
      'type': instance.type,
    };
