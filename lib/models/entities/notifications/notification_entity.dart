import 'package:flutter_base/common/app_const.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "business_id")
  int? businessId;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "notifiable_type")
  String? notifiableType;
  @JsonKey(name: "data")
  dynamic data;
  @JsonKey(name: "user_id")
  dynamic userId;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "stock_id")
  int? stockId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "product_name")
  String? productName;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "stock_name")
  String? stockName;
  @JsonKey(name: "inventory_qty")
  int? inventoryQty;

  NotificationEntity({
    this.id,
    this.businessId,
    this.type,
    this.notifiableType,
    this.data,
    this.userId,
    this.productId,
    this.stockId,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.sku,
    this.stockName,
    this.inventoryQty,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);

  String get title {
    switch (type) {
      case AppConst.productOutOfStock:
        return 'S.current.product_out_of_stock';
      case AppConst.productIsRunningOut:
        return '  S.current.product_is_running_out';
      default:
        return 'S.current.product_is_running_out';
    }
  }
}
