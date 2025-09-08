import 'package:flutter/material.dart';

class PuzzleObject extends StatefulWidget {
  final String puzzleId;
  final bool solved;
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback onTap;

  const PuzzleObject({
    super.key,
    required this.puzzleId,
    required this.solved,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  State<PuzzleObject> createState() => _PuzzleObjectState();
}

class _PuzzleObjectState extends State<PuzzleObject>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          );
        },
        child: widget.solved
            ? const Icon(Icons.check_circle, color: Colors.green, size: 50)
            : Image.asset(
                widget.imagePath,
                width: widget.width,
                height: widget.height,
              ),
      ),
    );
  }
}
