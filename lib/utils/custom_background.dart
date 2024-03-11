import 'package:documind/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomGreenBackground extends StatefulWidget {
  final Widget child;
  const CustomGreenBackground({super.key, required this.child});

  @override
  State<CustomGreenBackground> createState() => _CustomGreenBackgroundState();
}

class _CustomGreenBackgroundState extends State<CustomGreenBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [
              AppColors.appGreen, // Light blue starting color
              AppColors.appLightGreen, // Purple ending color
            ],
          ),
        ),

        child: widget.child,
      ),
    );
  }
}
