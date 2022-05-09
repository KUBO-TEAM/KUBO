import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationReminder {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails({
    required String largeIconUrl,
    required String bigPictureUrl,
  }) async {
    final largeIconPath = await Utils.downloadFile(
      largeIconUrl,
      'largeIcon',
    );

    final bigPicturePath = await Utils.downloadFile(
      bigPictureUrl,
      'bigPicture',
    );

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'f9751937-f5c3-4a8f-a209-92a90370de3d',
        'Kubo Notification',
        channelDescription: 'A notification for kubo',
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
      iOS: const IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();

    // When app is closed
    final details = await _notification.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await _notification.initialize(
      settings,
      onSelectNotification: (String? payload) async {
        onNotifications.add(payload);
      },
    );

    if (initScheduled) {
      try {
        tz.initializeTimeZones();
        final locationName = await FlutterNativeTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(locationName));
      } on Exception catch (_) {}
    }
  }

  static Future showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required String largeIconUrl,
    required String bigPictureUrl,
    required DateTime scheduledDate,
  }) async =>
      _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(
          largeIconUrl: largeIconUrl,
          bigPictureUrl: bigPictureUrl,
        ),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
