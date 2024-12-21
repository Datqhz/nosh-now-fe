import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';


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

  void showToast(String title, String content, BuildContext context) {
    ElegantNotification(
      icon: Container(
        color: Colors.black,
        width: 30,
        height: 30,
      ),
      title: Text(
        title,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      description: Text(
        content,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      animationCurve: Curves.linear,
      position: Alignment.topCenter,
      animation: AnimationType.fromTop,
      showProgressIndicator: false,
      toastDuration: const Duration(seconds: 4),
      width: MediaQuery.of(context).size.width - 60,
      height: 100,
      borderRadius: BorderRadius.circular(16),
      displayCloseButton: false,
      shadow: BoxShadow(
          color: Colors.grey,
          blurRadius: 6,
          blurStyle: BlurStyle.solid,
          offset: Offset.fromDirection(
            0,
          )),
    ).show(context);
  }
}