import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import '../widgets/puzzle_object.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';
import '../data/puzzles_data.dart';
import 'outside_screen1.dart';
import 'outside_screen3.dart';

class OutsideScreen2 extends StatefulWidget {
  const OutsideScreen2({super.key});

  @override
  State<OutsideScreen2> createState() => _OutsideScreen2State();
}

class _OutsideScreen2State extends State<OutsideScreen2>
    with SingleTickerProviderStateMixin {
  final Set<String> solvedPuzzles = {};
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  Map<String, Map<String, String>> get puzzles => puzzlesData[2]!;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration.zero, () {
      _showAstronautHint();
    });
  }

  void _showAstronautHint() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        title: "Astronaut",
        message:
            "You’ve reached level 2. Solve these new puzzles to collect more clues.",
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Let’s go"),
          ),
        ],
      ),
    );
  }

  void _showPuzzleDialog(String puzzleId) {
    final puzzle = puzzles[puzzleId];
    if (puzzle == null) return;

    final String question = puzzle['question']!;
    final String answer = puzzle['answer']!;
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => FuturisticDialog(
        title: "Puzzle",
        message: question,
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
              if (controller.text.trim().toLowerCase() ==
                  answer.toLowerCase()) {
                solvedPuzzles.add(puzzleId);
                Navigator.pop(context);
                setState(() {});

                if (solvedPuzzles.length == puzzles.length) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OutsideScreen3()),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Incorrect answer, try again.")),
                );
              }
            },
            child: const Text("Check"),
          ),
        ],
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
      appBar: LevelTopBar(
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OutsideScreen1()),
          );
        },
      ),
      body: LevelBackground(
        child: Stack(
          children: [
            Positioned(
              top: 180,
              left: 70,
              child: PuzzleObject(
                puzzleId: 'planet',
                solved: solvedPuzzles.contains('planet'),
                imagePath: 'assets/images/planet.png',
                width: 100,
                height: 100,
                onTap: () => _showPuzzleDialog('planet'),
              ),
            ),
            Positioned(
              top: 260,
              left: 220,
              child: PuzzleObject(
                puzzleId: 'moon',
                solved: solvedPuzzles.contains('moon'),
                imagePath: 'assets/images/moon.png',
                width: 80,
                height: 80,
                onTap: () => _showPuzzleDialog('moon'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
