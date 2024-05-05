import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../a2f_sdk.dart';

/// {@template notification_service}
/// This service is in charge of configuring the flutter_local_notifications
/// plugin, showing (local and push) and scheduling (local) notifications.
/// {@endtemplate}
class NotificationService with LoggerMixin {
  NotificationService(
    this._flutterLocalNotificationsPlugin,
    this._payloadService,
  ) {
    _doneFuture = _init();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// The payload service.
  ///
  /// It add a new payload if exist to its stream and sends to the
  /// app.
  final StreamControllerHandler<Map<String, dynamic>> _payloadService;

  late Future<void> _doneFuture;

  Future<void> get initializationDone => _doneFuture;

  // On Android, The default FCM channel used is hidden from users,
  // however provides a "default" importance level. Heads up notifications
  // require a "max" importance level.
  AndroidNotificationChannel _buildAndroidNotificationMaxChannel() {
    return const AndroidNotificationChannel(
      'high_importance_channel', // id - Waste Not App High
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      // to receive notification when app is in foreground
      importance: Importance.max,
    );
  }

  Future<void> _init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final notificationAppLaunchDetails = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();

    logger.i(
      'getNotificationAppLaunchDetails: '
      '${notificationAppLaunchDetails?.didNotificationLaunchApp}',
    );
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      logger.i('The app has been launched by a notification tap');
      final details = notificationAppLaunchDetails?.notificationResponse;
      if (details != null && details.payload != null) {
        final data = jsonDecode(details.payload!) as Map<String, dynamic>;
        // if the notification is a push notification and the app has to store
        // the notification in the db, create notification.

        // add the payload to the payload service
        _payloadService.add(data);
      }
    } else {
      logger.i('The app has been launched by the user');
    }

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_buildAndroidNotificationMaxChannel());

    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      ),
      // this is needed to handle the tap on the notification when the app is
      // open.
      onDidReceiveNotificationResponse: (details) {
        logger.i('Click on notification: $details');
        // notifications can be remote or local.
        // only notifications with payload are handled.
        if (details.payload != null) {
          final data = jsonDecode(details.payload!) as Map<String, dynamic>;
          // if the notification is a push notification and the app has to store
          // the notification in the db, create notification.

          // add the payload the the payload service
          _payloadService.add(data);
        }
      },
    );
  }

  // Use this inside the show method
  NotificationDetails _buildNotificationDetails(
    StyleInformation? styleInformation,
  ) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'android_ian_channel',
      'General Notification',
      channelDescription: 'This is a general notification channel',
      importance: Importance.max,
      priority: Priority.max, // high
      showWhen: false,
      styleInformation: styleInformation,
    );

    return NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
  }

  /// On Android, notification message are sent to Notification Channel which
  /// are used to control how a notification is delivered.
  /// The default FCM channel used is hidden from users, however provides a
  /// "default" importance level.
  /// Heads up notifications require a "max" importance level.
  ///
  /// N.B. When this method is used with FirebaseMessaging.onMessage
  /// remember to check if message.notification?.android is not null.
  Future<void> showNotification(ReceivedNotification notification) async {
    // final bigPicture = _base64EncodedImage(notification.imageUrl ?? '');
    await _flutterLocalNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      _buildNotificationDetails(
        null,
        // BigPictureStyleInformation(
        //   ByteArrayAndroidBitmap.fromBase64String(bigPicture),
        // ),
      ),
      payload: jsonEncode(notification.payload),
    );
  }

  Future<void> scheduleNotification(
    ReceivedNotification notification, {
    required DateTime scheduleAt,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(scheduleAt, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'android_ian_channel',
          'General Notification',
          channelDescription: 'This is a general notification channel',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: jsonEncode(notification.payload),
    );
  }

  /// Cancel a scheduled notification by the [id].
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
