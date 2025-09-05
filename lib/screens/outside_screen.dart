import 'package:flutter/material.dart';
import '/models/outside_item.dart';
import 'panel_screen.dart';

class OutsideScreen extends StatefulWidget {
  const OutsideScreen({super.key});

  @override
  State<OutsideScreen> createState() => _OutsideScreenState();
}

class _OutsideScreenState extends State<OutsideScreen>
    with SingleTickerProviderStateMixin {
  final Set<String> solvedItems = {};
  late List<OutsideItem> outsideItems;

  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    outsideItems = [
      OutsideItem(
        name: "Alien",
        hint: "El alien susurra: ‘Usa ASTRO como parte de la clave’",
        top: 250,
        left: 50,
        width: 100,
        height: 100,
        code: "ASTRO",
      ),
      OutsideItem(
        name: "Star",
        hint: "La estrella brilla y revela: ‘STAR’",
        top: 200,
        left: 220,
        width: 80,
        height: 80,
        code: "STAR",
      ),
    ];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void checkItem(OutsideItem item) {
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
              const SizedBox(height: 10),
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
                    borderSide: BorderSide(color: Colors.cyanAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.shade200,
                  foregroundColor: Colors.black,
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
                    if (solvedItems.length == outsideItems.length) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const PanelScreen()),
                      );
                    }
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fuera de la nave")),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          for (var item in outsideItems)
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
