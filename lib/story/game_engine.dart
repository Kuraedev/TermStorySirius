// ─────────────────────────────────────────────────────────────────────────────
// game_engine.dart  —  Data models and game-state for Carnelian
// ─────────────────────────────────────────────────────────────────────────────

enum EndingType { truePath, neutral, bad }

/// A single "beat" — one unit of story progress (text + optional image).
class StoryBeat {
  final String id;
  final String sceneLabel;
  final String text;

  /// Asset path, e.g. 'assets/images/scene1.jpg'
  final String? imagePath;

  /// Displayed in red beneath the main text when set.
  final String? redWarningText;

  /// ID of the next beat (used when there are no choices).
  final String? nextId;

  /// When present the player must pick one; [nextId] is ignored.
  final List<StoryChoice>? choices;

  /// Non-null only on ending beats.
  final EndingType? endingType;

  const StoryBeat({
    required this.id,
    this.sceneLabel = '',
    required this.text,
    this.imagePath,
    this.redWarningText,
    this.nextId,
    this.choices,
    this.endingType,
  });

  bool get isEnding  => endingType != null;
  bool get hasChoices => choices != null && choices!.isNotEmpty;
}

/// One selectable option inside a [StoryBeat].
class StoryChoice {
  final String label;   // "A" / "B" / "C"
  final String text;    // display text of the option
  final String nextId;  // beat to jump to when selected

  /// If true, render the option text in red.
  final bool isWarning;

  /// If non-null, the choice is only shown when [GameState] has this flag.
  /// Supported value: 'scene7_bad'
  final String? requiresFlag;

  /// If non-null, sets [setsFlag] → [setsFlagValue] in [GameState].
  final String? setsFlag;
  final String? setsFlagValue;

  const StoryChoice({
    required this.label,
    required this.text,
    required this.nextId,
    this.isWarning    = false,
    this.requiresFlag,
    this.setsFlag,
    this.setsFlagValue,
  });
}

/// Mutable game state — tracks current position and player decisions.
class GameState {
  String currentBeatId;
  final Map<String, String> _flags = {};

  GameState({this.currentBeatId = 's1_1'});

  void setFlag(String key, String value) => _flags[key] = value;
  String? getFlag(String key)             => _flags[key];

  bool _checkRequirement(String? requirement) {
    if (requirement == null) return true;
    if (requirement == 'scene7_bad') return _flags['scene7'] == 'B' || _flags['scene7_bad'] == 'true';
    return false;
  }

  /// Returns only choices the player is currently allowed to see.
  List<StoryChoice> availableChoices(List<StoryChoice> all) =>
      all.where((c) => _checkRequirement(c.requiresFlag)).toList();

  void reset() {
    currentBeatId = 's1_1';
    _flags.clear();
  }
}
