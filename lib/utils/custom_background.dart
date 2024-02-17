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
        child: widget.child,
      ),
    );
  }
}
