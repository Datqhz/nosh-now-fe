import 'package:flutter/material.dart';
import 'package:management_app/data/providers/user_state_provider.dart';
import 'package:management_app/presentation/onboarding_screen.dart';
import 'package:management_app/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<UserStateProvider>(context);
    return !loginState.isLogin
        ? const OnboardingScreen()
        : const SplashScreen();
  }
}
