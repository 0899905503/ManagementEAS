import 'package:json_annotation/json_annotation.dart';

part 'create_work_late_param.g.dart';

@JsonSerializable()
class CreateWorkLateParam {
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "time_to")
  String? timeTo;
  @JsonKey(name: "reason")
  String? reason;
  @JsonKey(name: "type")
  String? type;

  CreateWorkLateParam({
    this.date,
    this.time,
    this.timeTo,
    this.reason,
    this.type,
  });

  factory CreateWorkLateParam.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkLateParamFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWorkLateParamToJson(this);
}
