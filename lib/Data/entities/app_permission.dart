import 'package:json_annotation/json_annotation.dart';

part 'app_permission.g.dart';

@JsonSerializable()
class AppPermission {
  @JsonKey(name: "inventory")
  bool? inventory;
  @JsonKey(name: "essentials")
  bool? essentials;

  AppPermission({
    this.inventory,
    this.essentials,
  });

  factory AppPermission.fromJson(Map<String, dynamic> json) =>
      _$AppPermissionFromJson(json);

  Map<String, dynamic> toJson() => _$AppPermissionToJson(this);
}
