import 'package:documind/screens/sign_up/sign_up_screen.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:documind/utils/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/image_path.dart';
import '../../utils/custom_container.dart';
import '../login/login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomGreenBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath.applogo),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Text(
              "Login",
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            CustomTextFormField(
              labelText: "Username",
              width: MediaQuery.of(context).size.width / 1.3,
              textController: userNameController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            CustomTextFormField(
              labelText: "Password",
              width: MediaQuery.of(context).size.width / 1.3,
              textController: passwordController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            CustomTextButton(
              borderColor: AppColors.purple,
              backgroundColor: AppColors.purple,
              text: "Login",
              borderWidth: 0,
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 16,
              borderCircularRadius: 22,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Text(
              "Forgot Passowrd?",
              style: TextStyle(color: AppColors.purple),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  "Sign Up!",
                  style: TextStyle(color: AppColors.purple),
                )),

          ],
        ));
  }
}
