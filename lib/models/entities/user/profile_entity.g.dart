// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) =>
    ProfileEntity(
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      essentials: json['essentials'] == null
          ? null
          : Essentials.fromJson(json['essentials'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileEntityToJson(ProfileEntity instance) =>
    <String, dynamic>{
      'user': instance.user,
      'essentials': instance.essentials,
    };

Essentials _$EssentialsFromJson(Map<String, dynamic> json) => Essentials(
      totalLeave: json['total_leave'] as int?,
      totalLeaveRemaining: json['total_leave_remaining'] as int?,
      totalWorkingHours: json['total_working_hours'] as String?,
      totalWorkingHoursExcessDeficiency:
          json['total_working_hours_excess_deficiency'] as String?,
    );

Map<String, dynamic> _$EssentialsToJson(Essentials instance) =>
    <String, dynamic>{
      'total_leave': instance.totalLeave,
      'total_leave_remaining': instance.totalLeaveRemaining,
      'total_working_hours': instance.totalWorkingHours,
      'total_working_hours_excess_deficiency':
          instance.totalWorkingHoursExcessDeficiency,
    };
