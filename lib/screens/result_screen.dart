import 'package:flutter/material.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';
import 'panel_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LevelTopBar(
        onBack: () {
          // Go back to the previous screen, e.g., PanelScreen
          Navigator.pop(context);
        },
      ),
      body: LevelBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Congratulations!\nYou have completed the space adventure 🚀",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
