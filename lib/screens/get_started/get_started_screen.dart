import 'package:documind/constant/colors.dart';
import 'package:documind/constant/image_path.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:documind/utils/custom_container.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGreenBackground(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height/5,),
              Text(
                  "Seamless\nExploration\nof Projects",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,),
            Image.asset(ImagePath.getStarted),
             CustomTextButton(
                borderColor: AppColors.purple,
                backgroundColor: AppColors.purple,
                text: "Get Started",
                borderWidth: 0,
                width: MediaQuery.of(context).size.width/1.3,
            onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=> const LoginScreen())
                  );
            },)
          ],
        ),
      ),
    );
  }
}
