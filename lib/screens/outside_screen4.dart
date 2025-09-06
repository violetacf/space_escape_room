import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import 'panel_screen.dart';

class OutsideScreen4 extends StatefulWidget {
  const OutsideScreen4({super.key});

  @override
  State<OutsideScreen4> createState() => _OutsideScreen4State();
}

class _OutsideScreen4State extends State<OutsideScreen4> {
  void _showColorPatternPuzzle() {
    List<Color> correctPattern = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.yellow,
    ];
    List<int> playerInput = [];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FuturisticDialog(
              title: "Nivel 4 - Patrón de colores",
              message:
                  "Toca los colores en el orden correcto para desbloquear la nave.",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(correctPattern.length, (index) {
                      Color displayColor = Colors.grey;

                      if (playerInput.length > index) {
                        displayColor = playerInput[index] == index
                            ? Colors.green
                            : Colors.red;
                      }

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            playerInput.add(index);

                            if (playerInput.length == correctPattern.length) {
                              bool correct = true;
                              for (int i = 0; i < correctPattern.length; i++) {
                                if (playerInput[i] != i) {
                                  correct = false;
                                  break;
                                }
                              }

                              if (correct) {
                                Navigator.pop(context); // cerrar puzzle
                                Future.microtask(() {
                                  showDialog(
                                    context: this
                                        .context, // context del widget padre
                                    barrierDismissible: false,
                                    builder: (_) => FuturisticDialog(
                                      title: "¡Correcto!",
                                      message:
                                          "Has completado el nivel 4 🚀\nAhora puedes entrar al panel.",
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              this.context,
                                            ); // cerrar diálogo
                                            Navigator.pushReplacement(
                                              this.context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const PanelScreen(),
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
                            color: correctPattern[index],
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
    Future.delayed(Duration.zero, _showColorPatternPuzzle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fuera de la nave - Nivel 4")),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
