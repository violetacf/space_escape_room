class LevelConfig {
  final Map<String, String> puzzleImages;
  final Map<String, String> dialogImages;
  final String introMessage;
  final String summaryTitle;
  final String nextLevelMessage;

  LevelConfig({
    required this.puzzleImages,
    required this.dialogImages,
    required this.introMessage,
    required this.summaryTitle,
    required this.nextLevelMessage,
  });
}

final Map<int, LevelConfig> levelsConfig = {
  1: LevelConfig(
    puzzleImages: {
      'alien': 'assets/images/alien.png',
      'star': 'assets/images/star.png',
    },
    dialogImages: {
      'alien': 'assets/images/puzzles/puzzle1.png',
      'star': 'assets/images/puzzles/puzzle2.png',
    },
    introMessage:
        "We are outside the spaceship.\nSolve the puzzles of the space objects to collect clues and move forward.",
    summaryTitle: "Level 1 Summary",
    nextLevelMessage:
        "Congratulations! You solved all the puzzles in level 1.\nGet ready for the next level!",
  ),
  2: LevelConfig(
    puzzleImages: {
      'planet': 'assets/images/planet.png',
      'moon': 'assets/images/moon.png',
    },
    dialogImages: {
      'planet': 'assets/images/planet.png',
      'moon': 'assets/images/moon.png',
    },
    introMessage:
        "Great job reaching level 2!\nNew space objects await you with fresh puzzles to solve.",
    summaryTitle: "Level 2 Summary",
    nextLevelMessage:
        "Congratulations! You solved all the puzzles in level 2.\nGet ready for the next level!",
  ),
  // TODO: Agregar más niveles aquí
};
