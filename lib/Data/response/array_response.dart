import 'package:json_annotation/json_annotation.dart';

part 'array_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ArrayResponse<T> {
  @JsonKey(defaultValue: false)
  final bool success;
  @JsonKey()
  final ArrayData<T>? data;
  @JsonKey(defaultValue: "")
  final String message;

  ArrayResponse({
    this.success = false,
    this.message = "",
    this.data,
  });

  factory ArrayResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ArrayResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ArrayResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class ArrayData<T> {
  @JsonKey(defaultValue: 0)
  final int from;
  @JsonKey(defaultValue: 0)
  final int to;
  @JsonKey(name: "current_page", defaultValue: 0)
  final int currentPage;
  // @JsonKey(name: "per_page", defaultValue: 0)
  // final int perPage;
  @JsonKey(name: "last_page", defaultValue: 0)
  final int lastPage;
  @JsonKey(defaultValue: 0)
  final int total;
  @JsonKey(defaultValue: [])
  final List<T> data;

  ArrayData({
    this.from = 0,
    this.to = 0,
    this.currentPage = 0,
    // this.perPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.data = const [],
  });

  factory ArrayData.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ArrayDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ArrayDataToJson(this, toJsonT);
}
