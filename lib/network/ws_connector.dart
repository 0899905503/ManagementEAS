import 'dart:convert';

import 'package:flutter_base/common/app_const.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/global/global_event.dart';

import 'package:flutter_base/utils/logger.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class WsConnector {
  static final WsConnector instance = WsConnector._privateConstructor();

  WsConnector._privateConstructor();
  late PusherChannelsFlutter pusher;

  Future<void> initWS() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: AppConfigs.wsKey,
      pongTimeout: 5000,
      cluster: AppConfigs.wsCluster,
      onEvent: onEvent,
      onError: onError,
      onConnectionStateChange: onConnectionStateChange,
    );
    await pusher.connect();
  }

  Future<void> subChannel(String channelName) async {
    logger.i("subChannel: $channelName");
    await pusher.subscribe(channelName: channelName);
  }

  void unSubChannel(String channelName) async {
    await pusher.unsubscribe(channelName: channelName);
  }

  void onEvent(PusherEvent event) {
    logger.i("onEvent: $event");
    final Map<String, dynamic> data = json.decode(event.data);
    switch (event.eventName) {
      case AppConst.categoryChange:
        GlobalEvent.instance.onCategoryChange.sink.add(true);
        break;
      case AppConst.productChange:
        GlobalEvent.instance.onProductChange.sink.add(data["category_id"]);
        break;
      case AppConst.supplierChange:
        GlobalEvent.instance.onSupplierChange.sink.add(true);
        break;
      case AppConst.warehouseChange:
        GlobalEvent.instance.onWarehouseChange.sink.add(true);
        break;
      case AppConst.receiptChange:
        GlobalEvent.instance.onReceiptChange.sink.add(true);
        break;
      case AppConst.receiptDetailChange:
        GlobalEvent.instance.onReceiptDetailChange.sink.add(data["id"]);
        break;
      case AppConst.exportChange:
        GlobalEvent.instance.onExportChange.sink.add(true);
        break;
      case AppConst.exportDetailChange:
        GlobalEvent.instance.onExportDetailChange.sink.add(data["id"]);
        break;
      case AppConst.transferChange:
        GlobalEvent.instance.onTransferChange.sink.add(true);
        break;
      case AppConst.transferDetailChange:
        GlobalEvent.instance.onTransferDetailChange.sink.add(data["id"]);
        break;
      case AppConst.lossAdjustmentChange:
        GlobalEvent.instance.onLossAdjustmentChange.sink.add(data["id"]);
        break;
      case AppConst.lossAdjustmentDetailChange:
        GlobalEvent.instance.onLossAdjustmentDetailChange.sink.add(data["id"]);
        break;
    }
  }

  void onError(String message, int? code, dynamic error) {
    logger.e(
        "onError: \n 1. msg: $message \n 2. code: $code \n 3. error: $error");
  }

  void onConnectionStateChange(
      String currentState, String previousState) async {
    if (currentState == "DISCONNECTED") {
      await pusher.connect();
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) async {
    logger.i("onSubscriptionSucceeded: $channelName, data: $data");
  }

  void dispose() {
    GlobalEvent.instance.close();
    pusher.disconnect();
  }
}
