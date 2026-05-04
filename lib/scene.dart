// A Segment is one block of text paired with one image.
// The image stays on screen until the next segment loads.
class Segment {
  final String image;  // asset path
  final String text;
  const Segment(this.image, this.text);
}

class Scene {
  // R1 required fields
  final List<String> choices;
  final List<int>    nextScenes;

  // One scene = one or more segments (image changes mid-scene)
  final List<Segment> segments;

  final String?  endingTitle;
  final bool     isTitleScreen;
  final bool     setsBadFlag;

  const Scene({
    required this.choices,
    required this.nextScenes,
    required this.segments,
    this.endingTitle,
    this.isTitleScreen = false,
    this.setsBadFlag   = false,
  });

  // R1 storyText: full text of the scene (all segments joined)
  String get storyText =>
      segments.map((s) => s.text).join('\n\n');

  bool get isEnding      => endingTitle != null;
  bool get isAutoAdvance => choices.isEmpty && !isEnding && !isTitleScreen;
  String get firstImage  => segments.isNotEmpty ? segments.first.image : '';
}
