import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'Highly Important Notifications',
    description: 'This Cahnnel is used for important nots',
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    log("Notification clicked with data: ${message.data}");
    // Handle navigation or action based on message data
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(settings);
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotifications() async {
    // Request permissions for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      log("User declined or has not granted permissions for notifications");
      return;
    }

    // Display notification in foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification != null && android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Save the FCM token
    await saveToken();
  }

  Future<void> saveToken() async {
    final bool hasFCMToken =
        await CacheHelper.getData(key: "hasFCMToken") ?? false;
    log("hasFCMToken: ${hasFCMToken.toString()}");
    final String? token = await CacheHelper.getData(key: "token");
    log("token: ${token.toString()}");
    if (!hasFCMToken) {
      final String? fcmToken = Platform.isAndroid
          ? await _firebaseMessaging.getToken()
          : await _firebaseMessaging.getAPNSToken();
      log("fCMToken: ${fcmToken.toString()}");

      if (fcmToken != null) {
        await CacheHelper.setBool(key: "hasFCMToken", value: true);
        await CacheHelper.setString(key: "fcm_token", value: fcmToken);
      } else {
        log("Failed to retrieve FCM token");
      }
    } else {
      final String fcmToken = CacheHelper.getData(key: 'fcm_token');
      log("fCMToken: ${fcmToken.toString()}");
    }
  }

  Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log("Notification permission denied");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("Notification permission granted");
    } else {
      log("Notification permission granted provisionally");
    }
  }

  Future<void> initNotifications() async {
    await requestNotificationPermission();
    await initPushNotifications();
    await initLocalNotifications();
  }
}
