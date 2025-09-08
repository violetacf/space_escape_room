import 'package:flutter/material.dart';

class PuzzleObject extends StatelessWidget {
  final String puzzleId;
  final bool solved;
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback onTap;

  const PuzzleObject({
    super.key,
    required this.puzzleId,
    required this.solved,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: solved
          ? const Icon(Icons.check_circle, color: Colors.green, size: 50)
          : Image.asset(imagePath, width: width, height: height),
    );
  }
}
