import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../audio/ending_music_controller.dart';
import '../story/game_engine.dart';
import '../story/story_data.dart';
import 'game_screen.dart';
import 'start_screen.dart';

class EndingScreen extends StatelessWidget {
  final StoryBeat ending;
  const EndingScreen({super.key, required this.ending});

  String get _title {
    switch (ending.endingType) {
      case EndingType.truePath:
        return 'Congrats, you reached the True Ending';
      case EndingType.neutral:
        return 'Congrats, you reached the Neutral Ending';
      case EndingType.bad:
        return 'You reached the Bad Ending';
      default:
        return 'The End';
    }
  }

  String get _backgroundImage {
    if (ending.endingType == EndingType.bad) {
      return 'assets/images/bloodiedpapet.jpg';
    }
    return 'assets/images/paperbackround.png';
  }

  void _restart(BuildContext context) {
    final beats = buildStoryBeats();
    final state = GameState(currentBeatId: 's1_1');
    unawaited(EndingMusicController.stop());
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => GameScreen(beats: beats, state: state),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
      (_) => false,
    );
  }

  void _goMainMenu(BuildContext context) {
    unawaited(EndingMusicController.stop());
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const StartScreen(),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = (size.height * 0.30).clamp(150.0, 250.0).toDouble();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _backgroundImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF1ECE2)),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 410),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (ending.imagePath != null)
                        Container(
                          height: imageHeight,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black87, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              ending.imagePath!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      Text(
                        _title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoMono(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.22,
                        ),
                      ),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: () => _restart(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87, width: 1),
                          ),
                          child: Text(
                            'Restart',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoMono(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _goMainMenu(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87, width: 1),
                          ),
                          child: Text(
                            'Main Menu',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoMono(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
