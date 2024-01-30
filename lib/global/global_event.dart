import 'dart:async';

class GlobalEvent {
  GlobalEvent._privateConstructor();

  static final GlobalEvent instance = GlobalEvent._privateConstructor();

  // ignore: close_sinks
  final onCategoryChange = StreamController<bool>.broadcast();
  final onProductChange = StreamController<int?>.broadcast();
  final onSupplierChange = StreamController<bool>.broadcast();
  final onWarehouseChange = StreamController<bool>.broadcast();
  final onReceiptChange = StreamController<bool>.broadcast();
  final onReceiptDetailChange = StreamController<int?>.broadcast();
  final onExportChange = StreamController<bool>.broadcast();
  final onExportDetailChange = StreamController<int?>.broadcast();
  final onTransferChange = StreamController<bool>.broadcast();
  final onTransferDetailChange = StreamController<int?>.broadcast();
  final onLossAdjustmentChange = StreamController<int?>.broadcast();
  final onLossAdjustmentDetailChange = StreamController<int?>.broadcast();

  void close() {
    onCategoryChange.close();
    onProductChange.close();
    onSupplierChange.close();
    onWarehouseChange.close();
    onReceiptChange.close();
    onReceiptDetailChange.close();
    onExportChange.close();
    onExportDetailChange.close();
    onTransferChange.close();
    onTransferDetailChange.close();
    onLossAdjustmentChange.close();
    onLossAdjustmentDetailChange.close();
  }
}
