import 'package:documind/screens/dashboard_screen/dashboard_screen.dart';
import 'package:documind/screens/login/login_screen.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant/colors.dart';
import '../../constant/image_path.dart';
import '../../data/api_call/user_api_call.dart';
import '../../data/model/signup_model.dart';
import '../../utils/custom_container.dart';
import '../../utils/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomGreenBackground(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Image.asset(
                  ImagePath.applogo,
                  height: MediaQuery.of(context).size.width / 6,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                CustomTextFormField(
                  labelText: "Name",
                  width: MediaQuery.of(context).size.width / 1.3,
                  textController: nameController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                CustomTextFormField(
                  labelText: "Email ID",
                  width: MediaQuery.of(context).size.width / 1.3,
                  textController: emailController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                CustomTextFormField(
                  labelText: "Contact no.",
                  width: MediaQuery.of(context).size.width / 1.3,
                  textController: contactController,
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
                isLoading?CircularProgressIndicator(color: Colors.purple,):InkWell(
                  onTap: ()async {
                    SharedPreferences preference =await SharedPreferences.getInstance();
                    preference.setString("name", nameController.text);
                    preference.setString("emailId", emailController.text);
                    preference.setString("contact", contactController.text);
                    preference.setString("password", passwordController.text);
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        contactController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please enter all fields");
                    } else if(
                    contactController.text.length != 10
                    ){
                      Fluttertoast.showToast(
                          msg: "Please enter valid contact no.");
                    }else {
                      SignUpModel signUpModel;

                      setState(() {
                        isLoading = true;
                      });

                      signUpModel = await UserApiCall().signUpUser(
                          nameController.text,
                          emailController.text,
                          contactController.text,
                          passwordController.text);
                      if (signUpModel.id != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Unable to Register");
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }

                  },
                  child: CustomButton(
                    borderColor: AppColors.purple,
                    backgroundColor: AppColors.purple,
                    borderWidth: 0,
                    iconSize: 40,
                    width: MediaQuery.of(context).size.width/5,
                    center: true,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}