import 'package:flutter/material.dart';
import 'package:management_app/data/providers/user_state_provider.dart';
import 'package:management_app/presentation/onboarding_screen.dart';
import 'package:management_app/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStateProvider>(builder: (context, userState, chill) {
      print('Change state to ${userState.isLogin}');
      return !userState.isLogin
          ? const OnboardingScreen()
          : const SplashScreen();
    });
  }
}
