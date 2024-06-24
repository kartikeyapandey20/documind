import 'dart:async';

import 'package:documind/screens/dashboard_screen/dashboard_screen.dart';
import 'package:documind/screens/get_started/get_started_screen.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? userId;
  @override
  void initState() {
    super.initState();
    getDataFromSession();
    Timer(Duration(seconds: 5),
            ()=>userId == null?Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => GetStartedScreen()
            )
        ): Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => DashBoardScreen()
            )
        )
    );
  }
  getDataFromSession() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getInt("userId");
    print(userId);
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
