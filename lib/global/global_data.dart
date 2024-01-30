import 'package:flutter_base/models/entities/user/app_permission.dart';
import 'package:flutter_base/models/entities/user/permission_entity.dart';
//import 'package:flutter_base/models/entities/user/permission_entity.dart';
import 'package:flutter_base/models/response/login_response.dart';

class GlobalData {
  GlobalData._privateConstructor();

  static final GlobalData instance = GlobalData._privateConstructor();

  LoginResponse? loginResponse;

  PermissionEntity? get permission => loginResponse?.permissions;
  AppPermission? get appPermission => loginResponse?.appPermissions;

  String get fullName {
    return "${loginResponse?.user?.firstName ?? ""} ${loginResponse?.user?.lastName ?? ""}";
  }

  String get channelName => "npos-${loginResponse?.user?.id}";

  bool get hasProductPer => permission?.product == true;
  bool get hasLossAdjustmentPer => permission?.lossAdjustment == true;
  bool get hasStockTransferPer => permission?.stockTransfer == true;
  bool get hasStockExportPer => permission?.stockExport == true;
  bool get hasStockReceiptPer => permission?.stockReceipt == true;
  bool get hasSupplierPer => permission?.supplier == true;
  bool get hasWarehousePer => permission?.warehouse == true;
}
