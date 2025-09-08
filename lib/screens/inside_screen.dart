import 'package:flutter/material.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';

class InsideScreen extends StatelessWidget {
  const InsideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LevelTopBar(
        onBack: () {
          Navigator.pop(context); // go back to PanelScreen or previous
        },
      ),
      body: LevelBackground(
        backgroundImage:
            "assets/images/backgrounds/space_inside.jpg", // custom image
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.cyanAccent, width: 2),
            ),
            child: const Text(
              "You did it! 🔑🚀\n\nYou’ve entered the spaceship. "
              "Now we can return to Earth 🌍",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
