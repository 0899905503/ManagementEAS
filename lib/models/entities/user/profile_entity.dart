import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  @JsonKey(name: "user")
  UserEntity? user;
  @JsonKey(name: "essentials")
  Essentials? essentials;

  ProfileEntity({
    this.user,
    this.essentials,
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);
}

@JsonSerializable()
class Essentials {
  @JsonKey(name: "total_leave")
  int? totalLeave;
  @JsonKey(name: "total_leave_remaining")
  int? totalLeaveRemaining;
  @JsonKey(name: "total_working_hours")
  String? totalWorkingHours;
  @JsonKey(name: "total_working_hours_excess_deficiency")
  String? totalWorkingHoursExcessDeficiency;

  Essentials({
    this.totalLeave,
    this.totalLeaveRemaining,
    this.totalWorkingHours,
    this.totalWorkingHoursExcessDeficiency,
  });

  factory Essentials.fromJson(Map<String, dynamic> json) =>
      _$EssentialsFromJson(json);

  Map<String, dynamic> toJson() => _$EssentialsToJson(this);
}
