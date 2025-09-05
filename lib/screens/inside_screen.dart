import 'package:flutter/material.dart';

class InsideScreen extends StatelessWidget {
  const InsideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dentro de la nave")),
      body: Stack(
        children: [
          Image.asset(
            'assets/space_inside.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.cyanAccent, width: 2),
              ),
              child: const Text(
                "¡Lo lograste! 🔑🚀\n\nHas entrado en la nave de nuevo. "
                "Ahora podemos regresar a la Tierra 🌍",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
