import 'package:flutter/material.dart';
import 'room_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escape Room Espacial")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RoomScreen(level: "outside"),
              ),
            );
          },
          child: const Text("Empezar aventura"),
        ),
      ),
    );
  }
}
