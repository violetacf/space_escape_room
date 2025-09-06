import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import 'outside_screen2.dart';

class OutsideScreen1 extends StatefulWidget {
  const OutsideScreen1({super.key});

  @override
  State<OutsideScreen1> createState() => _OutsideScreen1State();
}

class _OutsideScreen1State extends State<OutsideScreen1>
    with SingleTickerProviderStateMixin {
  final Set<String> solvedPuzzles = {};
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration.zero, () {
      _showAstronautIntro();
    });
  }

  void _showAstronautIntro() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        title: "Mensaje del astronauta",
        message:
            "Estamos fuera de la nave.\nResuelve los enigmas de los objetos "
            "espaciales para obtener pistas y avanzar.",
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Empezar a explorar"),
          ),
        ],
      ),
    );
  }

  void _showPuzzleDialog(String puzzleId) {
    String question = '';
    String answer = '';

    if (puzzleId == 'alien') {
      question =
          "El alien sostiene una secuencia de colores: azul, rojo, azul, verde. "
          "¿Cuál es el siguiente color?";
      answer = "azul";
    } else if (puzzleId == 'star') {
      question =
          "La estrella muestra un patrón de números: 2, 4, 6, 8. "
          "¿Cuál es el siguiente número?";
      answer = "10";
    }

    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => FuturisticDialog(
        title: "Puzzle",
        message: question,
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Escribe tu respuesta",
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.trim().toLowerCase() ==
                  answer.toLowerCase()) {
                solvedPuzzles.add(puzzleId);
                Navigator.pop(context);
                setState(() {});

                if (solvedPuzzles.length == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OutsideScreen2()),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Respuesta incorrecta, inténtalo de nuevo"),
                  ),
                );
              }
            },
            child: const Text("Comprobar"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fuera de la nave - Nivel 1")),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 200,
            left: 50,
            width: 100,
            height: 100,
            child: GestureDetector(
              onTap: () => _showPuzzleDialog('alien'),
              child: solvedPuzzles.contains('alien')
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    )
                  : Image.asset('assets/images/alien.png'),
            ),
          ),
          Positioned(
            top: 250,
            left: 220,
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => _showPuzzleDialog('star'),
              child: solvedPuzzles.contains('star')
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    )
                  : Image.asset('assets/images/star.png'),
            ),
          ),
        ],
      ),
    );
  }
}
