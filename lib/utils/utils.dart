import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_base/app.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/global/global_data.dart';
import 'package:flutter_base/models/entities/user/normal_select_model.dart';

import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/commons/multiple_select_dialog.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Utils {
  ///Search
  // static bool isTextContainKeyword({String text = "", String keyword = ""}) {
  //   final newText = String.fromCharCodes(replaceCodeUnits(text.codeUnits)).toLowerCase();
  //   final newKeyword = String.fromCharCodes(replaceCodeUnits(keyword.codeUnits)).toLowerCase();
  //   final isContain = newText.contains(newKeyword);
  //   return isContain;
  // }
  //
  // static launchPhoneCall({String phone}) async {
  //   try {
  //     await launch("tel:$phone");
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
  //
  // static launchEmail({String email}) async {
  //   try {
  //     await launch(Uri(
  //       scheme: 'mailto',
  //       path: email,
  //     ).toString());
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  /// Checks if string is email.
  static bool isEmail(String email) => GetUtils.isEmail(email);

  /// Checks if string is phone number.
  static bool isPhoneNumber(String email) => GetUtils.isPhoneNumber(email);

  /// Checks if string is URL.
  static bool isURL(String url) => GetUtils.isURL(url);

  ///Color
  static Color? getColorFromHex(String? hexColor) {
    hexColor = (hexColor ?? '').replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  static String formatMoney(num money) => money <= 0
      ? 0.toStringAsFixed(2).replaceAll('.', ',')
      : Decimal.parse(money.toString()).toStringAsFixed(2).replaceAll('.', ',');

  static TextInputFormatter formatMoneyInput() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final String unformattedValue =
          newValue.text.isEmpty ? "0,00" : newValue.text;
      final num value = num.parse(unformattedValue.replaceAll(',', '')) / 100;
      final String newValueTemp = formatMoney(value);
      return TextEditingValue(
        text: newValueTemp,
        selection: TextSelection(
          baseOffset: newValueTemp.length,
          extentOffset: newValueTemp.length,
        ),
        composing: TextRange.empty,
      );
    });
  }

  static String? getHexFromColor(Color color) {
    String colorString = color.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return valueString;
  }

  static Future<List<NormalSelectModel>?> showMultiSelectDialog({
    required String title,
    List<NormalSelectModel>? selectedItems,
    required List<NormalSelectModel> items,
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: items,
          title: title,
          selectedItems: selectedItems,
        );
      },
    );
  }

  // static Future<void> scanImportProduct({
  //   int? stockReceiptId,
  //   int? businessLocationId,
  //   bool? toHistoryProduct,
  // }) async {
  //   ///Đi từ Home
  //   if (toHistoryProduct == true) {
  //     if (!GlobalData.instance.hasStockReceiptPer &&
  //         !GlobalData.instance.hasStockTransferPer &&
  //         !GlobalData.instance.hasProductPer &&
  //         !GlobalData.instance.hasLossAdjustmentPer) {
  //       Utils.noPermissionDialog();
  //       return;
  //     }
  //   } else {
  //     if (!GlobalData.instance.hasStockReceiptPer) {
  //       Utils.noPermissionDialog();
  //       return;
  //     }
  //   }
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //     "#ff6666",
  //     "Cancel",
  //     true,
  //     ScanMode.DEFAULT,
  //   );
  //   // logger.e(barcodeScanRes);
  //   if (barcodeScanRes != "-1") {
  //     await BlocProvider.of<AppCubit>(navigatorKey.currentContext!)
  //         .findAndImportProduct(
  //       barcodeScanRes,
  //       stockReceiptId: stockReceiptId,
  //       businessLocationId: businessLocationId,
  //       toHistoryProduct: toHistoryProduct,
  //     );
  //   }
  // }

  // static Future<void> scanExportProduct({
  //   required int stockExportId,
  //   required int businessLocationId,
  // }) async {
  //   if (!GlobalData.instance.hasStockExportPer) {
  //     Utils.noPermissionDialog();
  //     return;
  //   }
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //     "#ff6666",
  //     "Cancel",
  //     true,
  //     ScanMode.DEFAULT,
  //   );
  //   // logger.e(barcodeScanRes);
  //   if (barcodeScanRes != "-1") {
  //     await BlocProvider.of<AppCubit>(navigatorKey.currentContext!)
  //         .findAndExportProduct(
  //       barcodeScanRes,
  //       stockExportId: stockExportId,
  //       businessLocationId: businessLocationId,
  //     );
  //   }
  // }

  // static Future<bool?> scanTransferProduct(
  //     {int? stockTransferId, int? exportWarehouseLocationId}) async {
  //   if (!GlobalData.instance.hasStockTransferPer) {
  //     Utils.noPermissionDialog();
  //     return null;
  //   }
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //     "#ff6666",
  //     "Cancel",
  //     true,
  //     ScanMode.DEFAULT,
  //   );
  //   // logger.e(barcodeScanRes);
  //   if (barcodeScanRes != "-1") {
  //     return await BlocProvider.of<AppCubit>(navigatorKey.currentContext!)
  //         .findAndTransferProduct(
  //       barcodeScanRes,
  //       stockTransferId: stockTransferId,
  //       exportWarehouseLocationId: exportWarehouseLocationId,
  //     );
  //   }
  //   return null;
  // }

  // static Future<bool?> scanCheckProduct({required int lossAdjustId}) async {
  //   if (!GlobalData.instance.hasLossAdjustmentPer) {
  //     Utils.noPermissionDialog();
  //     return null;
  //   }
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //     "#ff6666",
  //     "Cancel",
  //     true,
  //     ScanMode.DEFAULT,
  //   );
  //   // logger.e(barcodeScanRes);
  //   if (barcodeScanRes != "-1") {
  //     return await BlocProvider.of<AppCubit>(navigatorKey.currentContext!)
  //         .findAndCheckProduct(
  //       barcodeScanRes,
  //       lossAdjustId: lossAdjustId,
  //     );
  //   }
  //   return null;
  // }

  static void noPermissionDialog({String? msg}) {
    AppDialog.commonDialog(message: msg ?? ' S.current.no_permission');
  }

  static Future<void> showLoadingDialog() async {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(backgroundColor: Colors.transparent),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      },
    );
  }

  static Future<void> dismissLoadingDialog() async {
    Get.back();
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
