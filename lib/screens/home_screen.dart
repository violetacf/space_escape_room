import 'package:flutter/material.dart';
import 'outside_screen1.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/space_outside.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/astronaut.png", height: 150),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.cyanAccent, width: 2),
                  ),
                  child: const Text(
                    "¡Estamos atrapados fuera de la nave! 🚀\n\n"
                    "Necesitamos observar nuestro entorno y resolver enigmas "
                    "para descubrir la clave que nos permitirá volver a entrar.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OutsideScreen1()),
                    );
                  },
                  child: const Text("Empezar aventura"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
