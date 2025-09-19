class PuzzlePosition {
  final double top;
  final double left;
  final double width;
  final double height;

  PuzzlePosition(this.top, this.left, this.width, this.height);
}

final Map<int, Map<String, PuzzlePosition>> puzzlePositions = {
  1: {
    'alien': PuzzlePosition(200, 50, 100, 100),
    'star': PuzzlePosition(250, 220, 80, 80),
  },
  2: {
    'planet': PuzzlePosition(200, 50, 100, 100),
    'moon': PuzzlePosition(250, 220, 80, 80),
  },
};
