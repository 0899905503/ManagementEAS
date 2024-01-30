// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_work_off_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWorkOffParam _$CreateWorkOffParamFromJson(Map<String, dynamic> json) =>
    CreateWorkOffParam(
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      reason: json['reason'] as String?,
      essentialsLeaveTypeId: json['essentials_leave_type_id'] as int?,
    );

Map<String, dynamic> _$CreateWorkOffParamToJson(CreateWorkOffParam instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'reason': instance.reason,
      'essentials_leave_type_id': instance.essentialsLeaveTypeId,
    };
