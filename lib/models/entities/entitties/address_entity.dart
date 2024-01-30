import 'package:json_annotation/json_annotation.dart';

part 'address_entity.g.dart';

@JsonSerializable()
class AddressEntity {
  @JsonKey(name: "address")
  String? address;

  AddressEntity({
    this.address,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);
}
