import 'package:flutter/material.dart';
import '../widgets/puzzle_object.dart';
import '../widgets/level_background.dart';
import '../widgets/level_top_bar.dart';
import '../data/puzzles_data.dart';
import '../data/levels_config.dart';
import '../data/puzzle_positions.dart';
import '../data/game_state.dart';
import '../utils/dialog_utils.dart';
import '../widgets/futuristic_dialog.dart';
import 'outside_screen3.dart';

class OutsideScreen2 extends StatefulWidget {
  const OutsideScreen2({super.key});

  @override
  State<OutsideScreen2> createState() => _OutsideScreen2State();
}

class _OutsideScreen2State extends State<OutsideScreen2> {
  final GameState gameState = GameState();
  final int level = 2;
  late final LevelConfig config;

  @override
  void initState() {
    super.initState();
    config = levelsConfig[level]!;

    // Intro only for this level
    Future.delayed(Duration.zero, _showIntro);
  }

  void _showIntro() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        type: LevelDialogType.intro,
        title: "Welcome to Level $level",
        message: config.introMessage,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Let’s go"),
          ),
        ],
      ),
    );
  }

  void _showNextLevelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        type: LevelDialogType.nextLevel,
        title: "Next Level!",
        message:
            "Congratulations! You solved all the puzzles.\nGet ready for the next level.",
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OutsideScreen3()),
              );
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final puzzles = puzzlesData[level]!;

    return Scaffold(
      appBar: LevelTopBar(
        onSummary: () => DialogUtils.showSummaryDialog(
          context: context,
          level: level,
          puzzles: puzzles,
          gameState: gameState,
          title: config.summaryTitle,
        ),
        showDebugMenu: true,
      ),
      body: LevelBackground(
        child: Stack(
          children: puzzlePositions[level]!.entries.map((entry) {
            final puzzleId = entry.key;
            final pos = entry.value;

            return Positioned(
              top: pos.top,
              left: pos.left,
              child: PuzzleObject(
                puzzleId: puzzleId,
                solved:
                    gameState.solvedPuzzles[level]?.contains(puzzleId) ?? false,
                imagePath: config.puzzleImages[puzzleId]!,
                width: pos.width,
                height: pos.height,
                onTap: () => DialogUtils.showPuzzleDialog(
                  context: context,
                  level: level,
                  puzzleId: puzzleId,
                  puzzles: puzzles,
                  dialogImages: config.dialogImages,
                  gameState: gameState,
                  onSolved: () {
                    setState(() {});
                    if (gameState.solvedPuzzles[level]!.length ==
                        puzzles.length) {
                      _showNextLevelDialog();
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
