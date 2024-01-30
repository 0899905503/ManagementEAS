// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_off_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOffConfig _$WorkOffConfigFromJson(Map<String, dynamic> json) =>
    WorkOffConfig(
      leaveData: json['leave_data'] == null
          ? null
          : LeaveData.fromJson(json['leave_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkOffConfigToJson(WorkOffConfig instance) =>
    <String, dynamic>{
      'leave_data': instance.leaveData,
    };

LeaveData _$LeaveDataFromJson(Map<String, dynamic> json) => LeaveData(
      businessId: json['business_id'] as int?,
      typeLeaves: (json['type_leaves'] as List<dynamic>?)
          ?.map((e) => TypeLeaf.fromJson(e as Map<String, dynamic>))
          .toList(),
      leaveOfMonth: json['leave_of_month'] as int?,
      leaveOfYear: json['leave_of_year'] as int?,
    );

Map<String, dynamic> _$LeaveDataToJson(LeaveData instance) => <String, dynamic>{
      'business_id': instance.businessId,
      'type_leaves': instance.typeLeaves,
      'leave_of_month': instance.leaveOfMonth,
      'leave_of_year': instance.leaveOfYear,
    };

TypeLeaf _$TypeLeafFromJson(Map<String, dynamic> json) => TypeLeaf(
      id: json['id'] as int?,
      leaveType: json['leave_type'] as String?,
      leaveCountInterval: json['leave_count_interval'] as String?,
    );

Map<String, dynamic> _$TypeLeafToJson(TypeLeaf instance) => <String, dynamic>{
      'id': instance.id,
      'leave_type': instance.leaveType,
      'leave_count_interval': instance.leaveCountInterval,
    };
