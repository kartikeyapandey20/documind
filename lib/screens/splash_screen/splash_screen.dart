import 'dart:async';

import 'package:documind/screens/get_started/get_started_screen.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:flutter/material.dart';

import '../../constant/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const GetStartedScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomGreenBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                Image.asset(ImagePath.applogo)
          ],
        )
    );
  }
}
