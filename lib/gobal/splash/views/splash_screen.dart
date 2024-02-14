/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/route_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _checkAuthenticationStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, navigate to home screen
      GoRouter.of(context).goNamed(RouteConstant.homeScreen);
    } else {
      // User is logged out, navigate to login screen
      GoRouter.of(context).goNamed(RouteConstant.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _checkAuthenticationStatus();
    });

    return const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
*/
