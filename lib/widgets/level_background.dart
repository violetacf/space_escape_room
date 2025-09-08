import 'package:flutter/material.dart';

class LevelBackground extends StatelessWidget {
  final Widget? child;
  final String? backgroundImage;

  const LevelBackground({super.key, this.child, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage ?? 'assets/images/backgrounds/stars_background.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        if (child != null) child!,
      ],
    );
  }
}
