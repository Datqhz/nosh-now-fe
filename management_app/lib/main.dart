import 'package:flutter/material.dart';
import 'package:management_app/data/providers/hub/hub_provider.dart';
import 'package:management_app/data/providers/user_state_provider.dart';
import 'package:management_app/presentation/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserStateProvider()),
      ChangeNotifierProvider(create: (context) => HubProvider())
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Wrapper()
    );
  }
}
