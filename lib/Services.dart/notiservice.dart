import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final FlutterLocalNotificationsPlugin notiservice =
      FlutterLocalNotificationsPlugin();

  Future<void> intiNoti() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    notiservice
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    var initalizeIos = DarwinInitializationSettings();

    var initalizeSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initalizeIos);
    await notiservice.initialize(initalizeSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notiresponce) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channelName',
            importance: Importance.max, icon: '@mipmap/ic_launcher'));
  }

  Future showNoti(
      {int id = 0, String? title, String? body, String? payload}) async {
    return await notiservice.show(id, title, body, notificationDetails());
  }
}
