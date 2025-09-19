import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

enum LevelDialogType { intro, nextLevel, wrongAnswer, puzzle }

class FuturisticDialog extends StatefulWidget {
  final String title;
  final String message;
  final Widget? content;
  final List<Widget> actions;
  final LevelDialogType type;
  final Widget? image;

  const FuturisticDialog({
    super.key,
    required this.title,
    required this.message,
    this.content,
    required this.actions,
    this.type = LevelDialogType.puzzle,
    this.image,
  });

  @override
  State<FuturisticDialog> createState() => _FuturisticDialogState();
}

class _FuturisticDialogState extends State<FuturisticDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBeep();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  Future<void> _playBeep() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/beep.mp3'));
    } catch (e) {
      print("Error reproduciendo sonido: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define icon and title color based on dialog type
    Widget? dialogIcon;
    Color titleColor = Colors.cyanAccent;

    switch (widget.type) {
      case LevelDialogType.intro:
        dialogIcon = const Icon(
          Icons.rocket,
          size: 50,
          color: Colors.cyanAccent,
        );
        break;
      case LevelDialogType.nextLevel:
        dialogIcon = const Icon(
          Icons.star,
          size: 50,
          color: Colors.greenAccent,
        );
        titleColor = Colors.greenAccent;
        break;
      case LevelDialogType.wrongAnswer:
        dialogIcon = const Icon(Icons.error, size: 50, color: Colors.redAccent);
        titleColor = Colors.redAccent;
        break;
      case LevelDialogType.puzzle:
        dialogIcon = null;
        break;
    }

    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.85),
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ScannerBorderPainter(progress: _controller.value),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.black, Color(0xFF0A1A2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: titleColor.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.message,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              if (widget.image != null) ...[
                const SizedBox(height: 12),
                widget.image!,
              ],
              if (dialogIcon != null) ...[
                const SizedBox(height: 12),
                dialogIcon,
              ],
              if (widget.content != null) ...[
                const SizedBox(height: 15),
                widget.content!,
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.actions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScannerBorderPainter extends CustomPainter {
  final double progress;

  ScannerBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final scannerPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.cyanAccent, Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(20),
    );
    canvas.drawRRect(rect, borderPaint);

    final path = Path()..addRRect(rect);
    final metric = path.computeMetrics().first;
    final length = metric.length;

    final start = progress * length;
    final end = start + length * 0.2;

    final extract = metric.extractPath(start, end % length);
    canvas.drawPath(extract, scannerPaint);
  }

  @override
  bool shouldRepaint(covariant ScannerBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
