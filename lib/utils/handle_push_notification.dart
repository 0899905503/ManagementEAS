import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/utils/local_notification_service.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:get/get.dart';

class HandlePushNotification {
  late String _tokenFirebase;
  late FirebaseMessaging _firebaseMessaging;

  HandlePushNotification._privateConstructor() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  static final HandlePushNotification instance =
      HandlePushNotification._privateConstructor();

  String get tokenFirebase => _tokenFirebase;

  Future<void> init({
    VoidCallback? callback,
  }) async {
    await _requestPermissionNotification();
    await _getToken();
    await LocalNotificationService.init();
    _handleNotification(callBack: callback);
  }

  Future<void> _requestPermissionNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        logger.d("granted permission");
        break;
      case AuthorizationStatus.provisional:
        logger.d("granted provisional permission");
        break;
      default:
        logger.e("not accept permission");
    }
  }

  Future<void> _getToken() async {
    String? tokenFirebase = await _firebaseMessaging.getToken();
    if (tokenFirebase != null) {
      _tokenFirebase = tokenFirebase;
      logger.i("Token firebase: $_tokenFirebase");
    } else {
      logger.e("Get token failed");
    }
  }

  /// [Callback] is to change status  of icon notification when new notification were pushed
  void _handleNotification({
    VoidCallback? callBack,
  }) {
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        _showNotification(message);
        callBack?.call();
      });
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      logger.i("Push noti: ${message.data}");
      handleNavigate();
      // KeyScreenAndDataEntity keyScreenAndData =
      //     KeyScreenAndDataEntity.fromJson(message.data);
      // NotificationEntity notification = NotificationEntity(
      //   id: keyScreenAndData.id ?? 0,
      //   keyScreenAndData: keyScreenAndData,
      // );
      // HandleNavigateFromNotification.handleNavigate(notification);
    });
  }

  void _showNotification(RemoteMessage message) {
    LocalNotificationService.showNotification(
      id: 0,
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: json.encode(message.data),
    );
  }

  /// remove [tokenFirebase] when force logout
  /// use when call refresh token error or logout
  void removeFcmToken() {
    _firebaseMessaging.deleteToken();
  }

  void handleNavigate() {
    Get.toNamed(RouteConfig.notification);
  }
}
