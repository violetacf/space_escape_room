import 'package:flutter/material.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';

class InsideScreen extends StatelessWidget {
  const InsideScreen({super.key});

  void _showSummaryDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: const Text("Summary"),
        content: const Text("You’ve entered the spaceship! 🎉"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LevelTopBar(
        onSummary: () => _showSummaryDialog(context),
        showDebugMenu: true, // optional, keep consistent with other screens
      ),
      body: LevelBackground(
        backgroundImage: "assets/images/backgrounds/space_inside.jpg",
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
