import 'package:json_annotation/json_annotation.dart';

part 'permission_entity.g.dart';

@JsonSerializable()
class PermissionEntity {
  @JsonKey(name: "product")
  bool? product;
  @JsonKey(name: "supplier")
  bool? supplier;
  @JsonKey(name: "warehouse")
  bool? warehouse;
  @JsonKey(name: "loss_adjustment")
  bool? lossAdjustment;
  @JsonKey(name: "stock_receipt")
  bool? stockReceipt;
  @JsonKey(name: "stock_export")
  bool? stockExport;
  @JsonKey(name: "stock_transfer")
  bool? stockTransfer;

  PermissionEntity({
    this.product,
    this.supplier,
    this.warehouse,
    this.lossAdjustment,
    this.stockReceipt,
    this.stockExport,
    this.stockTransfer,
  });

  factory PermissionEntity.fromJson(Map<String, dynamic> json) =>
      _$PermissionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionEntityToJson(this);
}
