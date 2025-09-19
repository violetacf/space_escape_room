import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/futuristic_dialog.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';
import 'panel_screen.dart';

class OutsideScreen4 extends StatefulWidget {
  const OutsideScreen4({super.key});

  @override
  State<OutsideScreen4> createState() => _OutsideScreen4State();
}

class _OutsideScreen4State extends State<OutsideScreen4> {
  void _showColorPatternPuzzle() {
    final parentContext = context;

    final List<int> fullPattern = [0, 2, 0, 3, 1];
    final List<Color> starColors = [
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green,
    ];

    List<int> playerInput = [];
    int? blinkingStar;
    bool patternPlaying = false;

    Future<void> playPattern(Function setStateCallback) async {
      setStateCallback(() {
        patternPlaying = true;
        blinkingStar = null;
        playerInput.clear();
      });

      for (int index in fullPattern) {
        setStateCallback(() => blinkingStar = index);
        await Future.delayed(const Duration(milliseconds: 1000));
        setStateCallback(() => blinkingStar = null);
        await Future.delayed(const Duration(milliseconds: 600));
      }

      setStateCallback(() => patternPlaying = false);
    }

    Widget starWidget(int index) {
      Color baseColor = starColors[index];
      bool isBlinking = blinkingStar == index;

      Color displayColor = isBlinking
          ? baseColor.withOpacity(1.0)
          : baseColor.withOpacity(0.3);

      return GestureDetector(
        onTap: patternPlaying
            ? null
            : () {
                HapticFeedback.selectionClick();
                setState(() {
                  playerInput.add(index);
                  int currentStep = playerInput.length - 1;

                  if (playerInput[currentStep] != fullPattern[currentStep]) {
                    HapticFeedback.vibrate();
                    playerInput.clear();
                    ScaffoldMessenger.of(parentContext).showSnackBar(
                      const SnackBar(
                        content: Text("Incorrect sequence, try again"),
                      ),
                    );
                    return;
                  }

                  if (playerInput.length == fullPattern.length) {
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
                                  builder: (_) => const PanelScreen(),
                                ),
                              );
                            },
                            child: const Text("Continue"),
                          ),
                        ],
                      ),
                    );
                  }
                });
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: displayColor,
            boxShadow: isBlinking
                ? [
                    BoxShadow(
                      color: baseColor.withOpacity(0.8),
                      blurRadius: 20,
                      spreadRadius: 6,
                    ),
                    BoxShadow(
                      color: baseColor.withOpacity(0.5),
                      blurRadius: 40,
                      spreadRadius: 12,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: baseColor.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
          ),
          child: const Icon(Icons.star, color: Colors.white, size: 36),
        ),
      );
    }

    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FuturisticDialog(
              title: "Level 4 - Star Pattern",
              message:
                  "Repeat the sequence of stars in the correct order to unlock the spaceship.",
              content: SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(top: 0, left: 80, child: starWidget(0)),
                    Positioned(top: 80, left: 0, child: starWidget(1)),
                    Positioned(top: 80, right: 0, child: starWidget(2)),
                    Positioned(bottom: 0, left: 80, child: starWidget(3)),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(parentContext),
                  child: const Text("Close"),
                ),
                TextButton(
                  onPressed: patternPlaying
                      ? null
                      : () {
                          playPattern(setState);
                        },
                  child: const Text("Repeat Pattern"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (_) => FuturisticDialog(
        title: "Summary of Answers",
        message: "Here are the answers you've provided so far:",
        content: const Text(
          "Level 4 puzzle not saved yet.",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LevelTopBar(onSummary: _showSummaryDialog, showDebugMenu: true),
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
