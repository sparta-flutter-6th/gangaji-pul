import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;


@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  
}

class NotificationHelper {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initiailize() async {
    tzData.initializeTimeZones();
    // 안드로이드 초기화 설정
    // @mipmap/ic_launcher => android/src/main/mipmap/ic_launcher.png
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS에서 알림 초기화 설정
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      // 알림 알림 권한을 요청
      requestAlertPermission: true,
      // 배지 권한을 요청
      requestBadgePermission: true,
      // 사운드 권한을 요청
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // 초기화
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (noti) {
        // 포그라운드에서 알림 터치했을 때
        print(noti.payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // 안드로이드 33 부터는 권한 요청해줘야함!
    await _requestAndroidPermissionForOver33();
  }

  static Future<bool?> _requestAndroidPermissionForOver33() async {
    final androidNotificationPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    return await androidNotificationPlugin?.requestNotificationsPermission();
  }

  // 사용자가 선택한 시간에 예약 알림을 보내는 함수
  static Future<void> schedule(
      String title, String content, TimeOfDay time) async {
    final now = DateTime.now();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // 이미 지난 시간이면 다음 날로 예약
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final tzScheduled = tz.TZDateTime.from(scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1, 
      title,
      content,
      tzScheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test channel id',
          'General Notifications',
          importance: Importance.high,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
      payload: 'Scheduled Notification',
    );
  }

  static Future<void> cancel({required int id}) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

}
