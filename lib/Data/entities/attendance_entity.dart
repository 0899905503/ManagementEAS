import 'package:json_annotation/json_annotation.dart';
import 'package:meas/configs/app_configs.dart';
import 'package:meas/utils/app_date_utils.dart';

part 'attendance_entity.g.dart';

@JsonSerializable()
class AttendanceEntity {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "attendances")
  List<Attendance>? attendances;
  @JsonKey(name: "working_time")
  WorkingTime? workingTime;

  AttendanceEntity({
    this.date,
    this.attendances,
    this.workingTime,
  });

  factory AttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEntityToJson(this);
}

@JsonSerializable()
class Attendance {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "business_id")
  int? businessId;
  @JsonKey(name: "clock_in_time")
  DateTime? clockInTime;
  @JsonKey(name: "clock_out_time")
  DateTime? clockOutTime;
  @JsonKey(name: "essentials_shift_id")
  int? essentialsShiftId;
  @JsonKey(name: "ip_address")
  String? ipAddress;
  @JsonKey(name: "clock_in_note")
  dynamic clockInNote;
  @JsonKey(name: "clock_out_note")
  dynamic clockOutNote;
  @JsonKey(name: "clock_in_location")
  String? clockInLocation;
  @JsonKey(name: "clock_out_location")
  String? clockOutLocation;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  Attendance({
    this.id,
    this.userId,
    this.businessId,
    this.clockInTime,
    this.clockOutTime,
    this.essentialsShiftId,
    this.ipAddress,
    this.clockInNote,
    this.clockOutNote,
    this.clockInLocation,
    this.clockOutLocation,
    this.createdAt,
    this.updatedAt,
  });

  String get displayCheckInTime {
    return clockInTime != null
        ? clockInTime!.toDateTimeString(format: AppConfigs.timeDisplay)
        : "";
  }

  String get displayCheckOutTime {
    return clockOutTime != null
        ? clockOutTime!.toDateTimeString(format: AppConfigs.timeDisplay)
        : "";
  }

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}

@JsonSerializable()
class WorkingTime {
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "business_work_time")
  int? businessWorkTime;
  @JsonKey(name: "shift_start_time")
  DateTime? shiftStartTime;
  @JsonKey(name: "shift_end_time")
  DateTime? shiftEndTime;

  WorkingTime({
    this.total,
    this.businessWorkTime,
    this.shiftStartTime,
    this.shiftEndTime,
  });

  factory WorkingTime.fromJson(Map<String, dynamic> json) =>
      _$WorkingTimeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingTimeToJson(this);

  String get formattedTime {
    if (total == null || total! < 1) return "";
    int min = (total! / 60).floor();
    int hours = (min / 60).floor();
    if (hours < 1) return "$min ${"minutes"}";
    return "$hours ${"hours"} ${min - (hours * 60)} ${"minutes"}";
  }

  bool get isLackTime {
    if (total == null) return true;
    if (businessWorkTime == null) return false;
    if (total! < businessWorkTime!) return true;
    return false;
  }

  String get lackTimeFormat {
    if (total == null || businessWorkTime == null) return "";
    final int lackTime = (total! - businessWorkTime!).abs();
    int min = (lackTime / 60).floor();
    int hours = (min / 60).floor();
    if (hours < 1) {
      return "${isLackTime ? "-" : "+"} $min ${"minutes"}";
    }
    return "${isLackTime ? "-" : "+"} $hours ${"hours"} ${min - (hours * 60)} ${"minutes"}";
  }

  String get shiftTime {
    if (shiftStartTime == null || shiftEndTime == null) {
      return "Ca làm linh động";
    }
    return "${shiftStartTime!.toTimeDisplay()} - ${shiftEndTime!.toTimeDisplay()}";
  }
}
