import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import 'panel_screen.dart';

class OutsideScreen2 extends StatefulWidget {
  const OutsideScreen2({super.key});

  @override
  State<OutsideScreen2> createState() => _OutsideScreen2State();
}

class _OutsideScreen2State extends State<OutsideScreen2>
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
      _showAstronautHint();
    });
  }

  void _showAstronautHint() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        title: "Astronauta",
        message:
            "Has avanzado al segundo nivel. Resuelve estos nuevos enigmas para conseguir más pistas.",
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Vamos allá"),
          ),
        ],
      ),
    );
  }

  void _showPuzzleDialog(String puzzleId) {
    String question = '';
    String answer = '';

    if (puzzleId == 'planet') {
      question =
          "El planeta tiene letras desordenadas: R M E C U R I O. "
          "Reordénalas para formar el nombre del planeta.";
      answer = "mercurio";
    } else if (puzzleId == 'moon') {
      question =
          "La luna muestra números: 5, 10, 15, ?. ¿Cuál es el siguiente número?";
      answer = "20";
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
                    MaterialPageRoute(builder: (_) => const PanelScreen()),
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
      appBar: AppBar(title: const Text("Fuera de la nave - Nivel 2")),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 180,
            left: 70,
            width: 100,
            height: 100,
            child: GestureDetector(
              onTap: () => _showPuzzleDialog('planet'),
              child: solvedPuzzles.contains('planet')
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    )
                  : Image.asset('assets/images/planet.png'),
            ),
          ),
          Positioned(
            top: 260,
            left: 220,
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () => _showPuzzleDialog('moon'),
              child: solvedPuzzles.contains('moon')
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    )
                  : Image.asset('assets/images/moon.png'),
            ),
          ),
        ],
      ),
    );
  }
}
