import 'package:flutter/material.dart';
import 'package:nosh_now_application/presentation/screens/auth/login_screen.dart';
import 'package:nosh_now_application/presentation/screens/auth/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              //thumbnail
              Image.asset(
                'assets/images/rice.png',
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.width - 40,
              ),
              const SizedBox(
                height: 12,
              ),
              //title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Hello!!!\nDelicious foods at your doorstep.',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(49, 49, 49, 1)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              //button sign up
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: const Color.fromRGBO(240, 240, 240, 1),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Sign up'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              // button sign in
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 44,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
                      foregroundColor: const Color.fromRGBO(49, 49, 49, 1),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Sign in'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PickLocationFromMapScreen()));
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 40, 40, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
