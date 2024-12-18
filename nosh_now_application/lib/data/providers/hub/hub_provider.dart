import 'package:flutter/material.dart';
import 'package:nosh_now_application/core/constants/global_variable.dart';
import 'package:nosh_now_application/core/services/notification_service.dart';
import 'package:nosh_now_application/data/providers/hub/message.dart';
import 'package:signalr_core/signalr_core.dart';

class HubProvider with ChangeNotifier {
  HubConnection? _hubConnection = null;

  get hubConnection => _hubConnection;

  Future connectToNotifyHub() async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
            "${GlobalVariable.hubUrl}/order-status",
            HttpConnectionOptions(
              logging: (level, message) =>
                  print('$message'),
              accessTokenFactory: () async => GlobalVariable.jwt
            ))
        .withAutomaticReconnect([0, 2000, 10000, 30000]).build();

    _hubConnection!.onclose((error) {
      print('SignalR is disconnected: $error');
    });

    _hubConnection!.onreconnecting((error) {
      print('SignalR on reconnecting: $error');
    });

    _hubConnection!.onreconnected((connectionId) {
      print('SignalR on reconnected with ConnectionId: $connectionId');
    });

    _hubConnection!.on("SendMessageConnection", (params) {
      print(params);
    });

    addNotifyListener();

    await _hubConnection!.start();
    notifyListeners();
  }

  void addNotifyListener() {
    _hubConnection!.on('NotifyOrderStatusChange', _handleWhenReceivedMessage);
  }

  void _handleWhenReceivedMessage(List<Object?>? parameter) {
    List<Message> list = parameter!
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList();
    for (var message in list) {
      LocalNotificationService()
          .showNotification(message.title, message.content);
    }
  }
}
