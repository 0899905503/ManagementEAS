// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      type: json['type'] as String?,
      notifiableType: json['notifiable_type'] as String?,
      data: json['data'],
      userId: json['user_id'],
      productId: json['product_id'] as int?,
      stockId: json['stock_id'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      productName: json['product_name'] as String?,
      sku: json['sku'] as String?,
      stockName: json['stock_name'] as String?,
      inventoryQty: json['inventory_qty'] as int?,
    );

Map<String, dynamic> _$NotificationEntityToJson(NotificationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'type': instance.type,
      'notifiable_type': instance.notifiableType,
      'data': instance.data,
      'user_id': instance.userId,
      'product_id': instance.productId,
      'stock_id': instance.stockId,
      'date': instance.date?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'product_name': instance.productName,
      'sku': instance.sku,
      'stock_name': instance.stockName,
      'inventory_qty': instance.inventoryQty,
    };
