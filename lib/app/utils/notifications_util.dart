import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/firebase_options.dart';

const String _androidNotificationChannelId = 'zay_notifications';
const String _androidNotificationChannelName = 'ZAY Notifications';
const String _androidNotificationChannelDescription =
    'Order updates, offers, and account alerts from ZAY.';

final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _androidNotificationChannel =
    AndroidNotificationChannel(
      _androidNotificationChannelId,
      _androidNotificationChannelName,
      description: _androidNotificationChannelDescription,
      importance: Importance.high,
    );

/// Handles messages received while the app is in the background or
/// terminated. Runs on a separate isolate, so Firebase must be
/// re-initialized here before touching any Firebase API.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationsUtil.showNotificationForRemoteMessage(message);
}

/// Entry point used by flutter_local_notifications to handle a tap on a
/// notification while the app is in the background/terminated. Runs on a
/// separate isolate, so no navigation happens here: navigation for this
/// scenario is handled by [NotificationsUtil.handelInitialLink] once the
/// Flutter UI isolate starts up.
@pragma('vm:entry-point')
void notificationTapBackgroundHandler(NotificationResponse response) {}

class NotificationsUtil {
  NotificationsUtil._();

  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    await _initLocalNotifications();
    await _initFirebaseMessaging();
  }

  static Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          notificationTapBackgroundHandler,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  static Future<void> _initFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // Terminated state: message tapped while the app process wasn't running.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Foreground state: FCM never shows a system notification by itself, so
    // it needs to be displayed manually via flutter_local_notifications.
    FirebaseMessaging.onMessage.listen(showNotificationForRemoteMessage);

    // Background state: the app was backgrounded and the user tapped a
    // system notification tray entry created automatically by the OS
    // (only happens for messages that include a `notification` payload).
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _navigateFromData(message.data),
    );
  }

  /// Displays a local notification for [message] so that it's visible to
  /// the user (foreground) and clickable (background/terminated) in every
  /// app state. Skipped for background/terminated messages that already
  /// contain a `notification` payload, since the OS already displays those
  /// automatically in the system tray.
  static Future<void> showNotificationForRemoteMessage(
    RemoteMessage message,
  ) async {
    log('message ${message.notification?.title} ${message.notification?.body}');
    final notification = message.notification;
    final title = notification?.title ?? message.data['title'] as String?;
    final body = notification?.body ?? message.data['body'] as String?;

    if (title == null && body == null) return;

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _androidNotificationChannelId,
        _androidNotificationChannelName,
        channelDescription: _androidNotificationChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );

    await _localNotificationsPlugin.show(
      id: (message.messageId ?? message.hashCode.toString()).hashCode &
          0x7fffffff,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  static void _onDidReceiveNotificationResponse(
    NotificationResponse response,
  ) {
    _navigateFromPayload(response.payload);
  }

  static void _navigateFromPayload(String? payload) {
    if (payload == null || payload.isEmpty) return;
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _navigateFromData(data);
    } catch (e) {
      debugPrint('NotificationsUtil: failed to parse payload: $e');
    }
  }

  static void _navigateFromData(Map<String, dynamic> data) {
    final routeTarget = data['routeTarget']?.toString();
    switch (routeTarget) {
      case 'order-details':
        final orderId = int.tryParse(data['orderId']?.toString() ?? '');
        if (orderId == null) return;
        Get.toNamed(Routes.orderDetails, arguments: {'orderId': orderId});
        break;
      case 'product-details':
        final productId = int.tryParse(data['productId']?.toString() ?? '');
        if (productId == null) return;
        Get.toNamed(
          Routes.productDetails,
          arguments: {'productId': productId},
        );
        break;
      case 'notifications':
      default:
        Get.toNamed(Routes.notifications);
        break;
    }
  }

  /// Handles the case where the app was launched (from a terminated state)
  /// by the user tapping a notification. Must be called once the app's
  /// navigation stack is ready to receive a route change.
  static Future<void> handelInitialLink() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _navigateFromData(initialMessage.data);
      return;
    }

    final launchDetails = await _localNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _navigateFromPayload(launchDetails?.notificationResponse?.payload);
    }
  }

  static Future<String?> getToken() async {
    try {
      if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) return '';
      }
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return '';
    }
  }
}
