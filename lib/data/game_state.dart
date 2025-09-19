class GameState {
  // Singleton instance
  static final GameState _instance = GameState._internal();
  factory GameState() => _instance;
  GameState._internal();

  // Track which puzzles are solved per level
  final Map<int, Set<String>> solvedPuzzles = {};

  // Store answers for each puzzle
  final Map<String, String> puzzleAnswers = {};
}
