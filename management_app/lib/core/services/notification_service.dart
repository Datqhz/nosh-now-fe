import 'package:awesome_notifications/awesome_notifications.dart';


class LocalNotificationService {
  Future<void> showNotification(String title, String content) async{
    bool isallowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isallowed) {
      //no permission of local notification
      AwesomeNotifications().requestPermissionToSendNotifications();
    }else{
        //show notification
        AwesomeNotifications().createNotification(
            content: NotificationContent( 
                id: 123,
                channelKey: 'basic', 
                title: title,
                body: content,
            )
        );
    }
  }
}