import 'package:flutter/material.dart';

class FloatingImage extends StatelessWidget {
  final Animation<double> animation;
  final String imagePath;
  final double height;

  const FloatingImage({
    super.key,
    required this.animation,
    required this.imagePath,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: Image.asset(imagePath, height: height),
    );
  }
}
