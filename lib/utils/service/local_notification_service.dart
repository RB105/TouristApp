/* October 2025 , Baxrom Rajabov, Tashkent , Uzbekistan */
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidFlutterLocalNotificationsPlugin,
        AndroidInitializationSettings,
        AndroidNotificationChannel,
        AndroidNotificationDetails,
        DarwinInitializationSettings,
        FlutterLocalNotificationsPlugin,
        Importance,
        InitializationSettings,
        LinuxInitializationSettings,
        NotificationDetails,
        Priority;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          linux: const LinuxInitializationSettings(defaultActionName: ''),
        );
    _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> showNotification(
    String title,
    String body,
    String payload,
  ) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel',
      'Notifications',
      importance: Importance.high,
    );

    // creates Notification channel
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.max,
          priority: Priority.high,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // Use timestamp as unique notification ID to avoid replacing previous notifications
    final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;

    await _flutterLocalNotificationsPlugin.show(
      id: notificationId,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }
}
