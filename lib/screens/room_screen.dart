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
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _initLevel() {
    if (widget.level == "outside") {
      roomItems = [
        RoomItem(
          name: "Astronauta",
          hint:
              "El astronauta señala algo brillante cerca de la nave: ‘A _ S _ R _’",
          top: 250,
          left: 50,
          width: 100,
          height: 150,
          code: "ASTRO",
        ),
        RoomItem(
          name: "Panel de la nave",
          hint:
              "El panel de la nave parpadea: ‘Usa el código que encontraste con el astronauta’",
          top: 200,
          left: 220,
          width: 120,
          height: 100,
          code: "KEY123",
        ),
      ];
    } else {
      roomItems = [
        RoomItem(
          name: "Panel principal",
          hint: "Presiona los botones correctos para activar la cabina",
          top: 180,
          left: 100,
          width: 120,
          height: 100,
          code: "ENTER",
        ),
        RoomItem(
          name: "Caja de suministros",
          hint:
              "Dentro de la caja de suministros ves letras luminosas: ‘SPACE’",
          top: 300,
          left: 220,
          width: 100,
          height: 80,
          code: "SPACE",
        ),
      ];
    }
  }

  void checkItem(RoomItem item) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Interactuando con ${item.name}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.hint),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Introduce el código",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
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
          Image.asset(
            widget.level == "outside"
                ? 'assets/space_outside.jpg'
                : 'assets/space_inside.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: solvedItems.contains(item.name)
                              ? Colors.green
                              : Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: solvedItems.contains(item.name)
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 40,
                            )
                          : null,
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
