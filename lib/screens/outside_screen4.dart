import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/futuristic_dialog.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';
import 'outside_screen3.dart';
import 'panel_screen.dart';

class OutsideScreen4 extends StatefulWidget {
  const OutsideScreen4({super.key});

  @override
  State<OutsideScreen4> createState() => _OutsideScreen4State();
}

class _OutsideScreen4State extends State<OutsideScreen4> {
  void _showColorPatternPuzzle() {
    final parentContext = context;
    List<Color> correctPattern = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.yellow,
    ];
    List<int> playerInput = [];
    Set<int> currentlyTapped = {};

    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FuturisticDialog(
              title: "Level 4 - Color Pattern",
              message:
                  "Tap the colors in the correct order to unlock the spaceship.",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(correctPattern.length, (index) {
                      Color displayColor = correctPattern[index];
                      if (currentlyTapped.contains(index)) {
                        displayColor = displayColor.withOpacity(0.5);
                      }
                      if (playerInput.length > index) {
                        displayColor = playerInput[index] == index
                            ? Colors.green
                            : Colors.red;
                      }

                      return GestureDetector(
                        onTapDown: (_) =>
                            setState(() => currentlyTapped.add(index)),
                        onTapUp: (_) =>
                            setState(() => currentlyTapped.remove(index)),
                        onTapCancel: () =>
                            setState(() => currentlyTapped.remove(index)),
                        onTap: () {
                          HapticFeedback.selectionClick();
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
                                HapticFeedback.lightImpact();
                                Navigator.pop(parentContext);

                                showDialog(
                                  context: parentContext,
                                  barrierDismissible: false,
                                  builder: (_) => FuturisticDialog(
                                    title: "Correct!",
                                    message:
                                        "You’ve completed level 4 🚀\nNow you can enter the panel.",
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(parentContext);
                                          Navigator.push(
                                            parentContext,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const PanelScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text("Continue"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                HapticFeedback.vibrate();
                                playerInput.clear();
                                ScaffoldMessenger.of(
                                  parentContext,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Incorrect sequence, try again",
                                    ),
                                  ),
                                );
                              }
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: displayColor,
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
                  onPressed: () => Navigator.pop(parentContext),
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LevelTopBar(
        onBack: () {
          Navigator.pop(context); // back to OutsideScreen3
        },
      ),
      body: LevelBackground(
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            onPressed: _showColorPatternPuzzle,
            child: const Text(
              "Start the color pattern puzzle",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
