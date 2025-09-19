import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';
import '../data/game_state.dart';
import 'outside_screen4.dart';

class OutsideScreen3 extends StatefulWidget {
  const OutsideScreen3({super.key});

  @override
  State<OutsideScreen3> createState() => _OutsideScreen3State();
}

class _OutsideScreen3State extends State<OutsideScreen3> {
  final GameState gameState = GameState();
  List<int> playerInput = [];

  void _showPanelPuzzle() {
    final List<int> correctSequence = [1, 3, 2, 4];
    playerInput = List.from(
      gameState.puzzleAnswers['level3_panel']?.split(',').map(int.parse) ?? [],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FuturisticDialog(
              title: "Light Panel",
              message: "Tap the squares in the correct order.",
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
                            gameState.puzzleAnswers['level3_panel'] =
                                playerInput.join(',');

                            if (playerInput.length == correctSequence.length) {
                              if (List.generate(
                                    4,
                                    (i) => playerInput[i],
                                  ).join() ==
                                  correctSequence.join()) {
                                Navigator.pop(context); // close puzzle

                                Future.microtask(() {
                                  showDialog(
                                    context: this.context,
                                    barrierDismissible: false,
                                    builder: (_) => FuturisticDialog(
                                      title: "Correct Sequence!",
                                      message:
                                          "You’ve completed level 3 🚀\nContinue to the next level.",
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(this.context);
                                            Navigator.pushReplacement(
                                              this.context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const OutsideScreen4(),
                                              ),
                                            );
                                          },
                                          child: const Text("Continue"),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              } else {
                                playerInput.clear();
                                gameState.puzzleAnswers.remove('level3_panel');
                                ScaffoldMessenger.of(context).showSnackBar(
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
                  child: const Text("Close"),
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: gameState.puzzleAnswers.entries.map((entry) {
            return Text(
              "${entry.key}: ${entry.value}",
              style: const TextStyle(color: Colors.white),
            );
          }).toList(),
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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => FuturisticDialog(
          title: "Astronaut",
          message:
              "Final level: tap the squares in the correct order to unlock the spaceship.",
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Let’s go"),
            ),
          ],
        ),
      );
    });
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
            onPressed: _showPanelPuzzle,
            child: const Text(
              "Interact with the light panel",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
