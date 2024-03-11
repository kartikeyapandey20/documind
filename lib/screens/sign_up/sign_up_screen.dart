import 'package:documind/screens/dashboard_screen/dashboard_screen.dart';
import 'package:documind/screens/login/login_screen.dart';
import 'package:documind/utils/custom_background.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/image_path.dart';
import '../../utils/custom_container.dart';
import '../../utils/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomGreenBackground(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                labelText: "Company Name",
                width: MediaQuery.of(context).size.width / 1.3,
                textController: companyNameController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
        ));
  }
}