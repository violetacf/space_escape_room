import 'package:flutter/material.dart';
import '../widgets/futuristic_dialog.dart';
import '../widgets/puzzle_object.dart';
import '../widgets/level_top_bar.dart';
import 'outside_screen2.dart';

class OutsideScreen1 extends StatefulWidget {
  const OutsideScreen1({super.key});

  @override
  State<OutsideScreen1> createState() => _OutsideScreen1State();
}

class _OutsideScreen1State extends State<OutsideScreen1>
    with SingleTickerProviderStateMixin {
  final Set<String> solvedPuzzles = {};
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  final Map<String, Map<String, String>> puzzles = {
    'alien': {
      'question':
          "The alien is holding a color sequence: blue, red, blue, green.\nWhat’s the next color?",
      'answer': "blue",
    },
    'star': {
      'question':
          "The star shows a number pattern: 2, 4, 6, 8.\nWhat’s the next number?",
      'answer': "10",
    },
  };

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
      _showAstronautIntro();
    });
  }

  void _showAstronautIntro() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FuturisticDialog(
        title: "Message from the astronaut",
        message:
            "We are outside the spaceship.\nSolve the puzzles of the space objects to collect clues and move forward.",
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Start exploring"),
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
                    MaterialPageRoute(builder: (_) => const OutsideScreen2()),
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
      appBar: LevelTopBar(), // <-- replaced AppBar
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/stars_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 200,
            left: 50,
            child: PuzzleObject(
              puzzleId: 'alien',
              solved: solvedPuzzles.contains('alien'),
              imagePath: 'assets/images/alien.png',
              width: 100,
              height: 100,
              onTap: () => _showPuzzleDialog('alien'),
            ),
          ),
          Positioned(
            top: 250,
            left: 220,
            child: PuzzleObject(
              puzzleId: 'star',
              solved: solvedPuzzles.contains('star'),
              imagePath: 'assets/images/star.png',
              width: 80,
              height: 80,
              onTap: () => _showPuzzleDialog('star'),
            ),
          ),
        ],
      ),
    );
  }
}
