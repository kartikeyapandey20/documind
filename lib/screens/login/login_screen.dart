import 'package:documind/screens/dashboard_screen/dashboard_screen.dart';
import 'package:documind/screens/sign_up/sign_up_screen.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:documind/utils/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/colors.dart';
import '../../constant/image_path.dart';
import '../../data/api_call/user_api_call.dart';
import '../../data/model/login_model.dart';
import '../../utils/custom_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginModel loginModel = LoginModel();
  bool isLoading = false;
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
              labelText: "Email",
              width: MediaQuery.of(context).size.width / 1.3,
              textController: emailController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            CustomTextFormField(
              labelText: "Password",
              width: MediaQuery.of(context).size.width / 1.3,
              textController: passwordController,
              isObscure: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            isLoading?CircularProgressIndicator(color: Colors.purple,):CustomTextButton(
              borderColor: AppColors.purple,
              backgroundColor: AppColors.purple,
              text: "Login",
              borderWidth: 0,
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 16,
              borderCircularRadius: 22,
              onTap: () async{
                if(emailController.text.isEmpty && passwordController.text.isEmpty)
                {
                  Fluttertoast.showToast(msg: "Please fill all the fields");
                }
                else if(emailController.text.isNotEmpty || emailController.text.isNotEmpty){
                  setState(() {
                    isLoading = true;
                  });
                  loginModel = await UserApiCall().loginUser(emailController.text, passwordController.text);
                  setState(() {
                    isLoading = false;
                  });
                  if (loginModel.accessToken == null) {
                    Fluttertoast.showToast(msg: "Invalid user or password");
                  }
                  else if (loginModel.accessToken != null){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('token', loginModel.accessToken!);
                    prefs.setInt('userId', loginModel.userId!);
                    var user = prefs.getInt('userId');
                    print(user);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
                  }

                }


              },
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 50,
            // ),
            // Text(
            //   "Forgot Passowrd?",
            //   style: TextStyle(color: AppColors.purple),
            // ),
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
