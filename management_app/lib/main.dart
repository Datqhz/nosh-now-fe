import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:management_app/data/providers/food_list_provider.dart';
import 'package:management_app/data/providers/hub/hub_provider.dart';
import 'package:management_app/data/providers/ingredient_list_provider.dart';
import 'package:management_app/data/providers/user_state_provider.dart';
import 'package:management_app/presentation/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic',
            channelKey: 'basic',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic', channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserStateProvider()),
      ChangeNotifierProvider(create: (context) => HubProvider()),
      ChangeNotifierProvider(create: (context) => FoodListProvider()),
      ChangeNotifierProvider(create: (context) => IngredientListProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Wrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
