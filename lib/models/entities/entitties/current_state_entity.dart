import 'package:json_annotation/json_annotation.dart';

part 'current_state_entity.g.dart';

@JsonSerializable()
class CurrentStateEntity {
  @JsonKey(name: "current_state")
  String? currentState;

  CurrentStateEntity({
    this.currentState,
  });

  factory CurrentStateEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrentStateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentStateEntityToJson(this);
}
