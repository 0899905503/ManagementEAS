// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionEntity _$PermissionEntityFromJson(Map<String, dynamic> json) =>
    PermissionEntity(
      product: json['product'] as bool?,
      supplier: json['supplier'] as bool?,
      warehouse: json['warehouse'] as bool?,
      lossAdjustment: json['loss_adjustment'] as bool?,
      stockReceipt: json['stock_receipt'] as bool?,
      stockExport: json['stock_export'] as bool?,
      stockTransfer: json['stock_transfer'] as bool?,
    );

Map<String, dynamic> _$PermissionEntityToJson(PermissionEntity instance) =>
    <String, dynamic>{
      'product': instance.product,
      'supplier': instance.supplier,
      'warehouse': instance.warehouse,
      'loss_adjustment': instance.lossAdjustment,
      'stock_receipt': instance.stockReceipt,
      'stock_export': instance.stockExport,
      'stock_transfer': instance.stockTransfer,
    };
