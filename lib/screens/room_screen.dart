import 'package:flutter/material.dart';
import '../models/room_item.dart';
import 'result_screen.dart';

class RoomScreen extends StatefulWidget {
  final String level;
  const RoomScreen({super.key, required this.level});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    with SingleTickerProviderStateMixin {
  final Set<String> solvedItems = {};
  late List<RoomItem> roomItems;

  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _initLevel();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _initLevel() {
    if (widget.level == "outside") {
      roomItems = [
        RoomItem(
          name: "Alien",
          hint: "El alien parece señalar algo...",
          top: 250,
          left: 50,
          width: 100,
          height: 100,
          code: "ALIEN",
        ),
        RoomItem(
          name: "Star",
          hint: "La estrella brilla con un código secreto",
          top: 200,
          left: 220,
          width: 80,
          height: 80,
          code: "STAR",
        ),
      ];
    } else {
      roomItems = [
        RoomItem(
          name: "Astronaut",
          hint: "El astronauta señala algo brillante cerca de la nave",
          top: 180,
          left: 100,
          width: 120,
          height: 120,
          code: "ASTRO",
        ),
        RoomItem(
          name: "Panel",
          hint: "El panel de la nave parpadea con un código secreto",
          top: 300,
          left: 220,
          width: 120,
          height: 100,
          code: "KEY123",
        ),
      ];
    }
  }

  void checkItem(RoomItem item) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.cyanAccent.shade200, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Interactuando con ${item.name}",
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 4,
                      color: Colors.blueAccent,
                    ),
                    Shadow(
                      offset: Offset(-1, -1),
                      blurRadius: 4,
                      color: Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                item.hint,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Introduce el código",
                  hintStyle: const TextStyle(color: Colors.white38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyanAccent.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.shade200,
                  foregroundColor: Colors.black,
                  elevation: 6,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (controller.text.trim().toUpperCase() ==
                      item.code.toUpperCase()) {
                    solvedItems.add(item.name);
                    Navigator.pop(context);
                    setState(() {});
                    _checkLevelCompletion();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Código incorrecto, inténtalo de nuevo"),
                      ),
                    );
                  }
                },
                child: const Text("Comprobar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkLevelCompletion() {
    if (solvedItems.length == roomItems.length) {
      if (widget.level == "outside") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoomScreen(level: "inside")),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ResultScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.level == "outside" ? "Fuera de la nave" : "Dentro de la nave",
        ),
      ),
      body: Stack(
        children: [
          // Fondo estrellado
          Image.asset(
            'assets/images/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Objetos interactivos
          for (var item in roomItems)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top:
                      item.top +
                      (_floatAnimation.value *
                          (item.name.hashCode % 2 == 0 ? 1 : -1)),
                  left: item.left,
                  width: item.width,
                  height: item.height,
                  child: GestureDetector(
                    onTap: () => checkItem(item),
                    child: solvedItems.contains(item.name)
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          )
                        : Image.asset(
                            'assets/images/${item.name.toLowerCase()}.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
