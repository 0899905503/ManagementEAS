import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/utils/handle_push_notification.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final _localNotificationService = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings(AppImages.icNotification);
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await _localNotificationService.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            // Map<String, dynamic> notificationData =
            //     json.decode(notificationResponse.payload!);
            // NotificationEntity notification = NotificationEntity(
            // );
            // HandleNavigateFromNotification.handleNavigate(notification);
            logger.d('------------------ selectedNotification');
            //HandlePushNotification.instance.handleNavigate();

            ///Indicates that a user has selected a notification
            break;
          case NotificationResponseType.selectedNotificationAction:
            logger.d('------------------Click  action notification');

            ///Indicates the a user has selected a notification action.
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_notification',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();
    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  static Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  static void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    logger.d(
        '------------------- onDidReceiveLocalNotification -------------- $title');
  }

  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    // Map<String, dynamic> notificationData =
    //     json.decode(notificationResponse.payload!);
   //s HandlePushNotification.instance.handleNavigate();
    if (notificationResponse.input?.isNotEmpty ?? false) {
      logger.d(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }
}
