/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:async' show StreamSubscription;
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:touristapp/utils/di/di.dart';

import '../../firebase_options.dart' show DefaultFirebaseOptions;
import 'device_info_service.dart' show DeviceInfoService;
import 'local_notification_service.dart' show LocalNotificationService;

String _localizedValueFromData(
  Map<String, dynamic> data,
  String lang, {
  required String ruKey,
  required String enKey,
  required String kkKey,
  String fallback = '',
}) {
  switch (lang) {
    case 'ru':
      return data[ruKey]?.toString() ?? fallback;
    case 'en':
      return data[enKey]?.toString() ?? fallback;
    case 'kk':
      return data[kkKey]?.toString() ?? fallback;
    default:
      return data[ruKey]?.toString() ?? fallback;
  }
}

/// Top-level background message handler - must be a top-level function
/// This is called when the app is in the background or terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message: ${message.data.toString()}');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize local notification service if needed
  final localNotificationService = LocalNotificationService();
  await localNotificationService.init();

  // Get storage to retrieve language preference
  final getStorage = getIt<GetStorage>();
  final lang = getStorage.read('lang') ?? 'ru';

  final title = _localizedValueFromData(
    message.data,
    lang,
    ruKey: 'title_ru',
    enKey: 'title_en',
    kkKey: 'title_kz',
    fallback: message.notification?.title ?? '',
  );
  final body = _localizedValueFromData(
    message.data,
    lang,
    ruKey: 'body_ru',
    enKey: 'body_en',
    kkKey: 'body_kz',
    fallback: message.notification?.body ?? '',
  );
  if (title.isEmpty && body.isEmpty) return;

  // Show notification
  await localNotificationService.showNotification(title, body, '');
}

class FirebaseNotificationService {
  FirebaseNotificationService._internal();

  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._internal();

  factory FirebaseNotificationService() => _instance;

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService();
  static final _getStorage = GetStorage();

  bool _initialized = false;
  bool _onMessageRegistered = false;
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _onMessageSubscription;

  Future<void> initNotification() async {
    if (_initialized) return; // <-- prevents double init
    _initialized = true;

    // Register background handler early so it works in all states.
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _localNotificationService.init();

    final settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.getAPNSToken();

    // Token
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      debugPrint('RegId: $fcmToken');
      _getStorage.write('regId', fcmToken);
    }

    // Topics
    await _subscribeToTopics();

    // Token refresh
    _tokenRefreshSubscription = _firebaseMessaging.onTokenRefresh.listen((
      newToken,
    ) {
      if (_getStorage.read('regId') != newToken) {
        _getStorage.write('regId', newToken);
      }
    });

    // Foreground messages (app is open)
    if (!_onMessageRegistered) {
      _onMessageSubscription = FirebaseMessaging.onMessage.listen((
        RemoteMessage message,
      ) {
        debugPrint('Foreground message: ${message.data.toString()}');
        _localNotificationService.showNotification(
          _getTitle(message.data),
          _getBody(message.data),
          "",
        );
      });

      _onMessageRegistered = true; // <-- ensures single listener
    }

    // Handle notification tap when app is terminated
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('Initial message: ${initialMessage.data.toString()}');
      _handleMessage(initialMessage);
    }

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Message opened app: ${message.data.toString()}');
      _handleMessage(message);
    });
  }

  /// Handle message navigation/actions
  void _handleMessage(RemoteMessage message) {
    debugPrint('Handling message: ${message.data}');
    // Example: navigate to specific screen based on message type
  }

  Future<void> _subscribeToTopics() async {
    final isAndroid = Platform.isAndroid;
    final platformPrefix = isAndroid ? 'android_' : 'ios_';

    final currentVersion = await getIt<DeviceInfoService>().getVersionName();
    final previousVersion = _getStorage.read<String>('versionTopic');

    final topicsToSubscribe = <String>{
      'all',
      isAndroid ? 'androidTopic' : 'iOSTopic',
      '$platformPrefix$currentVersion',
    };

    debugPrint("Subscribed to $platformPrefix$currentVersion");

    // Remove old version topic if needed
    if (previousVersion != null && previousVersion != currentVersion) {
      await _firebaseMessaging.unsubscribeFromTopic(
        '$platformPrefix$previousVersion',
      );
    }

    // Subscribe in parallel (faster & safe)
    await Future.wait(
      topicsToSubscribe.map(_firebaseMessaging.subscribeToTopic),
    );

    _getStorage.write('versionTopic', currentVersion);
  }

  String _getTitle(Map<String, dynamic> data) {
    final lang = _getStorage.read('lang') ?? 'ru';
    return _localizedValueFromData(
      data,
      lang,
      ruKey: 'title_ru',
      enKey: 'title_en',
      kkKey: 'title_kz',
    );
  }

  String _getBody(Map<String, dynamic> data) {
    final lang = _getStorage.read('lang') ?? 'ru';
    return _localizedValueFromData(
      data,
      lang,
      ruKey: 'body_ru',
      enKey: 'body_en',
      kkKey: 'body_kz',
    );
  }

  /// Dispose of subscriptions to prevent memory leaks
  void dispose() {
    _tokenRefreshSubscription?.cancel();
    _onMessageSubscription?.cancel();
  }
}
