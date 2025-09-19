import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import '../data/game_state.dart';

enum DialogType { puzzle, summary, info, nextLevel, wrongAnswer }

class DialogUtils {
  static void showDialogWithType({
    required BuildContext context,
    required DialogType type,
    String? title,
    String? message,
    Widget? content,
    List<Widget>? actions,
    Widget? image,
  }) {
    showDialog(
      context: context,
      barrierDismissible:
          type == DialogType.info || type == DialogType.nextLevel
          ? false
          : true,
      builder: (_) => FuturisticDialog(
        title: title ?? "Message",
        message: message ?? "",
        content: content,
        image: image,
        actions:
            actions ??
            [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
      ),
    );
  }

  static void showPuzzleDialog({
    required BuildContext context,
    required int level,
    required String puzzleId,
    required Map<String, Map<String, String>> puzzles,
    required Map<String, String> dialogImages,
    required GameState gameState,
    required VoidCallback onSolved,
  }) {
    final puzzle = puzzles[puzzleId];
    if (puzzle == null) return;

    final controller = TextEditingController(
      text: gameState.puzzleAnswers[puzzleId] ?? '',
    );

    showDialogWithType(
      context: context,
      type: DialogType.puzzle,
      title: "Puzzle",
      message: puzzle['question'],
      image: dialogImages[puzzleId] != null
          ? Image.asset(dialogImages[puzzleId]!, width: 100)
          : null,
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Type your answer",
          hintStyle: TextStyle(color: Colors.white38),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final answer = controller.text.trim();
            gameState.puzzleAnswers[puzzleId] = answer;

            if (answer.toLowerCase() == puzzle['answer']!.toLowerCase()) {
              gameState.solvedPuzzles[level] ??= {};
              gameState.solvedPuzzles[level]!.add(puzzleId);
              Navigator.pop(context);
              onSolved();
            } else {
              showDialogWithType(
                context: context,
                type: DialogType.wrongAnswer,
                title: "Wrong Answer",
                message: "Incorrect answer, try again.",
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              );
            }
          },
          child: const Text("Check"),
        ),
      ],
    );
  }

  static void showSummaryDialog({
    required BuildContext context,
    required int level,
    required Map<String, Map<String, String>> puzzles,
    required GameState gameState,
    required String title,
  }) {
    showDialogWithType(
      context: context,
      type: DialogType.summary,
      title: title,
      message: "Your answers so far:",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: puzzles.keys.map((puzzleId) {
          final answer = gameState.puzzleAnswers[puzzleId] ?? "(no answer)";
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(puzzleId, style: const TextStyle(color: Colors.white)),
                Text(answer, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
