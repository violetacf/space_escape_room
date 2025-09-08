import 'package:flutter/material.dart';

class LevelBackground extends StatelessWidget {
  final Widget? child;

  const LevelBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/backgrounds/stars_background.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        if (child != null) child!,
      ],
    );
  }
}
