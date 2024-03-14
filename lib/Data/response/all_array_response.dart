import 'package:json_annotation/json_annotation.dart';

part 'all_array_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AllArrayResponse<T> {
  @JsonKey(defaultValue: false)
  final bool success;
  @JsonKey()
  final List<T>? data;
  @JsonKey(defaultValue: "")
  final String message;

  AllArrayResponse({
    this.success = false,
    this.message = "",
    this.data,
  });

  factory AllArrayResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$AllArrayResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$AllArrayResponseToJson(this, toJsonT);
}
