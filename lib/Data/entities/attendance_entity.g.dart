// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceEntity _$AttendanceEntityFromJson(Map<String, dynamic> json) =>
    AttendanceEntity(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      attendances: (json['attendances'] as List<dynamic>?)
          ?.map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      workingTime: json['working_time'] == null
          ? null
          : WorkingTime.fromJson(json['working_time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AttendanceEntityToJson(AttendanceEntity instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'attendances': instance.attendances,
      'working_time': instance.workingTime,
    };

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      businessId: json['business_id'] as int?,
      clockInTime: json['clock_in_time'] == null
          ? null
          : DateTime.parse(json['clock_in_time'] as String),
      clockOutTime: json['clock_out_time'] == null
          ? null
          : DateTime.parse(json['clock_out_time'] as String),
      essentialsShiftId: json['essentials_shift_id'] as int?,
      ipAddress: json['ip_address'] as String?,
      clockInNote: json['clock_in_note'],
      clockOutNote: json['clock_out_note'],
      clockInLocation: json['clock_in_location'] as String?,
      clockOutLocation: json['clock_out_location'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'business_id': instance.businessId,
      'clock_in_time': instance.clockInTime?.toIso8601String(),
      'clock_out_time': instance.clockOutTime?.toIso8601String(),
      'essentials_shift_id': instance.essentialsShiftId,
      'ip_address': instance.ipAddress,
      'clock_in_note': instance.clockInNote,
      'clock_out_note': instance.clockOutNote,
      'clock_in_location': instance.clockInLocation,
      'clock_out_location': instance.clockOutLocation,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

WorkingTime _$WorkingTimeFromJson(Map<String, dynamic> json) => WorkingTime(
      total: json['total'] as int?,
      businessWorkTime: json['business_work_time'] as int?,
      shiftStartTime: json['shift_start_time'] == null
          ? null
          : DateTime.parse(json['shift_start_time'] as String),
      shiftEndTime: json['shift_end_time'] == null
          ? null
          : DateTime.parse(json['shift_end_time'] as String),
    );

Map<String, dynamic> _$WorkingTimeToJson(WorkingTime instance) =>
    <String, dynamic>{
      'total': instance.total,
      'business_work_time': instance.businessWorkTime,
      'shift_start_time': instance.shiftStartTime?.toIso8601String(),
      'shift_end_time': instance.shiftEndTime?.toIso8601String(),
    };
