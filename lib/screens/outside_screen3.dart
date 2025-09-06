import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import 'outside_screen4.dart';

class OutsideScreen3 extends StatefulWidget {
  const OutsideScreen3({super.key});

  @override
  State<OutsideScreen3> createState() => _OutsideScreen3State();
}

class _OutsideScreen3State extends State<OutsideScreen3> {
  void _showPanelPuzzle() {
    List<int> correctSequence = [1, 3, 2, 4];
    List<int> playerInput = [];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FuturisticDialog(
              title: "Panel de luces",
              message: "Toca los cuadrados en el orden correcto.",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(4, (index) {
                      Color color = Colors.grey;
                      if (playerInput.isNotEmpty &&
                          playerInput.length <= correctSequence.length &&
                          playerInput.last == index + 1) {
                        color =
                            correctSequence[playerInput.length - 1] == index + 1
                            ? Colors.green
                            : Colors.red;
                      }

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            playerInput.add(index + 1);

                            if (playerInput.length == correctSequence.length) {
                              if (List.generate(
                                    4,
                                    (i) => playerInput[i],
                                  ).join() ==
                                  correctSequence.join()) {
                                Navigator.pop(context); // cerrar puzzle

                                // Navegar después de cerrar el diálogo
                                Future.microtask(() {
                                  showDialog(
                                    context: this
                                        .context, // context del widget padre
                                    barrierDismissible: false,
                                    builder: (_) => FuturisticDialog(
                                      title: "¡Secuencia correcta!",
                                      message:
                                          "Has completado el nivel 3 🚀\nContinúa al siguiente nivel.",
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              this.context,
                                            ); // cerrar dialogo
                                            Navigator.pushReplacement(
                                              this.context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const OutsideScreen4(),
                                              ),
                                            );
                                          },
                                          child: const Text("Continuar"),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              } else {
                                playerInput.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Secuencia incorrecta, inténtalo de nuevo",
                                    ),
                                  ),
                                );
                              }
                            }
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => FuturisticDialog(
          title: "Astronauta",
          message:
              "Nivel final: toca los cuadrados en el orden correcto para desbloquear la nave.",
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Vamos allá"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fuera de la nave - Nivel 3")),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
              ),
              onPressed: _showPanelPuzzle,
              child: const Text(
                "Interactúa con el panel de luces",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
