import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/generated/l10n.dart';

import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/repositories/auth_repository.dart';

import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';

import 'package:flutter_base/utils/error_utils.dart';
import 'package:flutter_base/utils/utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../models/enums/load_status.dart';

import '../utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AuthRepository authRepo;
  // final ProductRepository productRepository;
  // final WarehouseRepository warehouseRepository;

  AppCubit({
    required this.authRepo,
    required warehouseRepository,
    // required this.productRepository,
    // required this.warehouseRepository,
  }) : super(const AppState());

  void fetchProfile() {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateProfile(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  ///Sign Out
  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await authRepo.removeToken();
      emit(state.removeUser().copyWith(
            signOutStatus: LoadStatus.success,
          ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }

  void updateLanguage(String locale) async {
    emit(state.copyWith(updateLanguageStatus: LoadStatus.loading));
    try {
      final res = await authRepo.updateLanguage(locale);
      if (res.success) {
        emit(state.copyWith(updateLanguageStatus: LoadStatus.success));
      } else {
        emit(state.copyWith(updateLanguageStatus: LoadStatus.failure));
      }
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(updateLanguageStatus: LoadStatus.failure));
    }
  }

  // Future<void> findAndImportProduct(
  //   String barcodeNo, {
  //   int? stockReceiptId,
  //   int? businessLocationId,
  //   bool? toHistoryProduct,
  // }) async {
  //   Utils.showLoadingDialog();
  //   emit(state.copyWith(getProductStatus: LoadStatus.loading));
  //   try {
  //     final res = await productRepository.findProductByBarCode(barcodeNo);
  //     Utils.dismissLoadingDialog();

  //     if (res.success) {
  //       emit(state.copyWith(getProductStatus: LoadStatus.success));
  //       if (toHistoryProduct == true) {
  //         _pushToProductHistory(res.data!.id!);
  //       } else {
  //         await _pushToImportProduct(
  //           barcodeNo,
  //           res.data!,
  //           stockReceiptId,
  //           businessLocationId,
  //           isImportByScan: true,
  //         );
  //       }
  //     } else {
  //       emit(state.copyWith(getProductStatus: LoadStatus.failure));

  //       await _notFoundProduct(
  //         barcodeNo,
  //         stockReceiptId: stockReceiptId,
  //         businessLocationId: businessLocationId,
  //         toHistoryProduct: toHistoryProduct,
  //       );
  //     }
  //   } catch (e) {
  //     Utils.dismissLoadingDialog();
  //     logger.e(e);
  //     if (e is DioException) {
  //       if (e.response?.statusCode != 400) {
  //         AppDialog.commonDialog(message: ErrorUtils.errorToString(error: e));
  //         return;
  //       }
  //     }
  //     await _notFoundProduct(
  //       barcodeNo,
  //       stockReceiptId: stockReceiptId,
  //       businessLocationId: businessLocationId,
  //       toHistoryProduct: toHistoryProduct,
  //     );
  //     emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //   }
  // }

  // Future<void> _notFoundProduct(
  //   String barcode, {
  //   int? stockReceiptId,
  //   int? businessLocationId,
  //   bool? toHistoryProduct,
  // }) async {
  //   final res = await Get.dialog(
  //     BarcodeResultDialog(barcodeNo: barcode),
  //   );
  //   if (res != null && res is ResultScannerAction) {
  //     switch (res) {
  //       case ResultScannerAction.createProduct:
  //         final res = await Get.toNamed(
  //           RouteConfig.createEditProduct,
  //           arguments: CreateEditProductArguments(barcode: barcode),
  //         );
  //         if (res != null && res is Map<String, dynamic>) {
  //           if (toHistoryProduct == true) {
  //             _pushToProductHistory(res["product"].id!);
  //             return;
  //           }
  //           await _pushToImportProduct(
  //             barcode,
  //             res["product"],
  //             stockReceiptId,
  //             businessLocationId,
  //             isImportByScan: true,
  //           );
  //         }
  //         break;
  //       case ResultScannerAction.addToExistingProduct:
  //         final res = await Get.toNamed(
  //           RouteConfig.searchProduct,
  //           arguments: SearchProductArguments(
  //             barcode: barcode,
  //           ),
  //         );
  //         if (res != null && res is Map<String, dynamic>) {
  //           if (toHistoryProduct == true) {
  //             _pushToProductHistory(res["product"].id!);
  //             return;
  //           }
  //           await _pushToImportProduct(
  //             barcode,
  //             res["product"],
  //             stockReceiptId,
  //             businessLocationId,
  //             isImportByScan: true,
  //           );
  //         }
  //         break;
  //       case ResultScannerAction.rescan:
  //         await Utils.scanImportProduct(
  //           stockReceiptId: stockReceiptId,
  //           businessLocationId: businessLocationId,
  //           toHistoryProduct: toHistoryProduct,
  //         );
  //         break;
  //     }
  //   }
  // }

  // Future<void> _pushToImportProduct(
  //   String barcodeNo,
  //   ProductEntity product,
  //   int? stockReceiptId,
  //   int? businessLocationId, {
  //   required bool isImportByScan,
  // }) async {
  //   Utils.showLoadingDialog();
  //   final res = await productRepository.findProductByBarCode(barcodeNo);
  //   Utils.dismissLoadingDialog();
  //   if (res.data != null) {
  //     if (stockReceiptId != null && businessLocationId != null) {
  //       await Get.toNamed(
  //         RouteConfig.importProductIntoWarehouse,
  //         arguments: ImportProductIntoWarehouseArguments(
  //           alreadyHaveProduct: isImportByScan,
  //           product: res.data!,
  //           stockReceiptId: stockReceiptId,
  //           businessLocationId: businessLocationId,
  //         ),
  //       );
  //     } else {
  //       await Get.toNamed(
  //         RouteConfig.importWarehouseList,
  //         arguments: ImportWarehouseListArguments(product: product),
  //       );
  //     }
  //   }
  // }

  // Future<void> _pushToProductHistory(
  //   int productId,
  // ) async {
  //   await Get.toNamed(
  //     RouteConfig.productHistory,
  //     arguments: ProductHistoryArguments(
  //       productId: productId,
  //     ),
  //   );
  // }

  // Future<void> findAndExportProduct(String barcodeNo,
  //     {int? stockExportId, int? businessLocationId}) async {
  //   Utils.showLoadingDialog();
  //   emit(state.copyWith(getProductStatus: LoadStatus.loading));
  //   try {
  //     final res = await productRepository.findProductByBarCode(barcodeNo);
  //     Utils.dismissLoadingDialog();

  //     if (res.success) {
  //       emit(state.copyWith(getProductStatus: LoadStatus.success));
  //       if (stockExportId != null && businessLocationId != null) {
  //         return await Get.toNamed(
  //           RouteConfig.exportProductOutWarehouse,
  //           arguments: ExportProductOutWarehouseArguments(
  //             product: res.data!,
  //             stockExportId: stockExportId,
  //             businessLocationId: businessLocationId,
  //             barcodeNo: barcodeNo,
  //           ),
  //         );
  //       }
  //     } else {
  //       AppDialog.commonDialog(
  //         message: "$barcodeNo ${S.current.not_in_the_list.toLowerCase()}",
  //       );
  //       emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //     }
  //   } catch (e) {
  //     Utils.dismissLoadingDialog();
  //     logger.e(e);
  //     emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //     AppDialog.commonDialog(message: ErrorUtils.errorToString(error: e));
  //   }
  // }

  // Future<bool?> findAndTransferProduct(
  //   String barcodeNo, {
  //   int? stockTransferId,
  //   int? exportWarehouseLocationId,
  // }) async {
  //   Utils.showLoadingDialog();
  //   emit(state.copyWith(getProductStatus: LoadStatus.loading));
  //   try {
  //     final res = await warehouseRepository.findProductInWarehouseByBarcode(
  //       exportWarehouseLocationId ?? 0,
  //       barcodeNo,
  //     );
  //     Utils.dismissLoadingDialog();

  //     if (res.success) {
  //       emit(state.copyWith(getProductStatus: LoadStatus.success));
  //       if (stockTransferId != null) {
  //         return await Get.dialog(
  //           barrierDismissible: false,
  //           AddTransferProductPage(
  //             arguments: AddTransferProductArguments(
  //               product: res.data!,
  //               stockTransferId: stockTransferId,
  //               warehouseLocationId: exportWarehouseLocationId,
  //             ),
  //           ),
  //         );
  //       }
  //     } else {
  //       AppDialog.commonDialog(
  //         message: "$barcodeNo ${S.current.not_in_the_list.toLowerCase()}",
  //       );
  //       emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //     }
  //   } catch (e) {
  //     Utils.dismissLoadingDialog();
  //     logger.e(e);
  //     emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //     AppDialog.commonDialog(message: ErrorUtils.errorToString(error: e));
  //   }
  //   return null;
  // }

  // Future<bool?> findAndCheckProduct(
  //   String barcodeNo, {
  //   required int lossAdjustId,
  // }) async {
  //   Utils.showLoadingDialog();
  //   emit(state.copyWith(getProductStatus: LoadStatus.loading));
  //   try {
  //     final res = await warehouseRepository.findLossAdjustmentDetail(
  //       lossAdjustId,
  //       50,
  //       1,
  //       barcodeNo: barcodeNo,
  //     );
  //     Utils.dismissLoadingDialog();

  //     if (res.success && (res.data?.data ?? []).isNotEmpty) {
  //       emit(state.copyWith(getProductStatus: LoadStatus.success));
  //       if (res.data!.data.length > 1) {
  //         final result = await Get.toNamed(
  //           RouteConfig.listExpiryDateOfProduct,
  //           arguments: ListExpiryDateOfProductArguments(
  //             lossAdjustmentDetails: res.data!.data,
  //             productName: res.data!.data.first.productName ?? "",
  //           ),
  //         );
  //         return result;
  //       }

  //       return await Get.dialog(
  //         barrierDismissible: false,
  //         UpdateLossProductPage(
  //           arguments: UpdateLossProductArguments(
  //             lossAdjustmentDetail: res.data!.data.first,
  //           ),
  //         ),
  //       );
  //     } else {
  //       AppDialog.commonDialog(
  //         message: "$barcodeNo ${S.current.not_in_the_list.toLowerCase()}",
  //       );
  //       emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //     }
  //   } catch (e) {
  //     Utils.dismissLoadingDialog();
  //     logger.e(e);
  //     emit(state.copyWith(getProductStatus: LoadStatus.failure));
  //     AppDialog.commonDialog(message: ErrorUtils.errorToString(error: e));
  //   }
  //   return null;
  // }
}
