import 'package:audioplayers/audioplayers.dart';

enum EndingRoute { truePath, neutral, bad }

class EndingMusicController {
  static final AudioPlayer _player = AudioPlayer();
  static EndingRoute? _currentRoute;
  static bool _ready = false;

  static Future<void> _ensureReady() async {
    if (_ready) return;
    await _player.setReleaseMode(ReleaseMode.loop);
    _ready = true;
  }

  static String _assetFor(EndingRoute route) {
    switch (route) {
      case EndingRoute.truePath:
        return 'audio/Chinmoku no Majo.mp3';
      case EndingRoute.bad:
        return 'audio/TrenchPrayer.mp3';
      case EndingRoute.neutral:
        return 'audio/WhenTheBirdGlides.mp3';
    }
  }

  static Future<void> playForRoute(EndingRoute route) async {
    await _ensureReady();
    if (_currentRoute == route && _player.state == PlayerState.playing) return;

    _currentRoute = route;
    await _player.stop();
    await _player.play(AssetSource(_assetFor(route)));
  }

  static Future<void> stop() async {
    _currentRoute = null;
    await _player.stop();
  }
}
