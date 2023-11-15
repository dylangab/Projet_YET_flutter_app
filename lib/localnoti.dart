import 'package:final_project/models/notiservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class localNoti extends StatefulWidget {
  const localNoti({super.key});

  @override
  State<localNoti> createState() => _localNotiState();
}

class _localNotiState extends State<localNoti> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  NotiService().showNoti(
                      id: 0,
                      title: 'new notification',
                      body: 'this better work,',
                      payload: 'adadad');
                },
                child: Text("click")),
          )
        ]),
      ),
    );
  }
}
/*
class Noticlass {
  static final _notfication = FlutterLocalNotificationsPlugin();
  var icon = FlutterBitmapAssetAndroidIcon('mipmap/ic_launcher');

  static notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('Channel id', 'Channel name',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notfication.show(id, title, body, await notificationDetails(),
          payload: payload);
}*/
