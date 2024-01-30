import 'package:json_annotation/json_annotation.dart';

part 'create_work_off_param.g.dart';

@JsonSerializable()
class CreateWorkOffParam {
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "end_date")
  String? endDate;
  @JsonKey(name: "reason")
  String? reason;
  @JsonKey(name: "essentials_leave_type_id")
  int? essentialsLeaveTypeId;

  CreateWorkOffParam({
    this.startDate,
    this.endDate,
    this.reason,
    this.essentialsLeaveTypeId,
  });

  factory CreateWorkOffParam.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkOffParamFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWorkOffParamToJson(this);
}
