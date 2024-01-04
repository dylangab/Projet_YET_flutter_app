// Importing necessary Flutter packages for handling local notifications
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Class for managing local notifications
class NotiService {
  // Creating an instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin notiservice =
      FlutterLocalNotificationsPlugin();

  // Method to initialize local notifications
  Future<void> intiNoti() async {
    // Initializing Android notification settings
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    // Requesting notification permissions on Android
    notiservice
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    // Initializing iOS notification settings
    var initalizeIos = DarwinInitializationSettings();

    // Creating overall initialization settings
    var initalizeSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initalizeIos);

    // Initializing the FlutterLocalNotificationsPlugin with settings
    await notiservice.initialize(initalizeSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notiresponce) async {});
  }

  // Method to get default notification details
  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channelName',
            importance: Importance.max, icon: '@mipmap/ic_launcher'));
  }

  // Method to show a local notification
  Future showNoti(
      {int id = 0, String? title, String? body, String? payload}) async {
    return await notiservice.show(id, title, body, notificationDetails());
  }
}
