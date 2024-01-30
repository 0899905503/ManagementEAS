import 'package:flutter_base/models/entities/user/normal_select_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_off_config.g.dart';

@JsonSerializable()
class WorkOffConfig {
  @JsonKey(name: "leave_data")
  LeaveData? leaveData;

  WorkOffConfig({
    this.leaveData,
  });

  factory WorkOffConfig.fromJson(Map<String, dynamic> json) =>
      _$WorkOffConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WorkOffConfigToJson(this);
}

@JsonSerializable()
class LeaveData {
  @JsonKey(name: "business_id")
  int? businessId;
  @JsonKey(name: "type_leaves")
  List<TypeLeaf>? typeLeaves;
  @JsonKey(name: "leave_of_month")
  int? leaveOfMonth;
  @JsonKey(name: "leave_of_year")
  int? leaveOfYear;

  LeaveData({
    this.businessId,
    this.typeLeaves,
    this.leaveOfMonth,
    this.leaveOfYear,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) =>
      _$LeaveDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveDataToJson(this);
}

@JsonSerializable()
class TypeLeaf {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "leave_type")
  String? leaveType;
  @JsonKey(name: "leave_count_interval")
  String? leaveCountInterval;

  NormalSelectModel get toNormalSelectModel => NormalSelectModel(id, leaveType);
  TypeLeaf({
    this.id,
    this.leaveType,
    this.leaveCountInterval,
  });

  factory TypeLeaf.fromJson(Map<String, dynamic> json) =>
      _$TypeLeafFromJson(json);

  Map<String, dynamic> toJson() => _$TypeLeafToJson(this);
}
