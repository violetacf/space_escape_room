import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LevelButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
