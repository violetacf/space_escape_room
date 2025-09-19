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
import 'outside_screen2.dart';

class OutsideScreen1 extends StatefulWidget {
  const OutsideScreen1({super.key});

  @override
  State<OutsideScreen1> createState() => _OutsideScreen1State();
}

class _OutsideScreen1State extends State<OutsideScreen1> {
  final GameState gameState = GameState();
  final int level = 1;
  late final LevelConfig config;

  @override
  void initState() {
    super.initState();
    config = levelsConfig[level]!;
    Future.delayed(Duration.zero, _showIntro);
  }

  // Intro dialog
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
            child: const Text("Start exploring"),
          ),
        ],
      ),
    );
  }

  // Next level dialog
  void _showNextLevelDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        type: LevelDialogType.nextLevel,
        title: "Next Level!",
        message: config.nextLevelMessage,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OutsideScreen2()),
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
