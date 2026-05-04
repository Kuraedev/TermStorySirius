import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../audio/ending_music_controller.dart';
import '../story/game_engine.dart';
import 'ending_screen.dart';

class GameScreen extends StatefulWidget {
  final Map<String, StoryBeat> beats;
  final GameState state;

  const GameScreen({super.key, required this.beats, required this.state});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  StoryBeat get _current => widget.beats[widget.state.currentBeatId]!;

  String get _backgroundImage {
    final route = widget.state.getFlag('ending_route');
    if (route == 'bad') {
      return 'assets/images/bloodiedpapet.jpg';
    }
    return 'assets/images/paperbackround.png';
  }

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _updateEndingRoute(String targetId) {
    if (targetId == 's9_true_1' || targetId.startsWith('true_')) {
      widget.state.setFlag('ending_route', 'true');
      return;
    }
    if (targetId == 's9_neutral_1' || targetId.startsWith('neutral_')) {
      widget.state.setFlag('ending_route', 'neutral');
      return;
    }
    if (targetId.startsWith('bad_')) {
      widget.state.setFlag('ending_route', 'bad');
    }
  }

  void _triggerScene9Music(String targetId) {
    if (targetId == 's9_true_1') {
      unawaited(EndingMusicController.playForRoute(EndingRoute.truePath));
      return;
    }
    if (targetId == 's9_neutral_1') {
      unawaited(EndingMusicController.playForRoute(EndingRoute.neutral));
      return;
    }
    if (targetId == 's8c_1') {
      unawaited(EndingMusicController.playForRoute(EndingRoute.bad));
    }
  }

  void _goTo(String id, {StoryChoice? choice}) {
    if (choice?.setsFlag != null) {
      widget.state.setFlag(choice!.setsFlag!, choice.setsFlagValue ?? '');
    }

    if (choice?.setsFlag == 'scene7' && choice?.setsFlagValue == 'B') {
      widget.state.setFlag('scene7_bad', 'true');
    }

    _updateEndingRoute(id);
    _triggerScene9Music(id);

    setState(() {
      widget.state.currentBeatId = id;
    });

    final next = widget.beats[id];
    if (next != null && next.isEnding) {
      Future.delayed(const Duration(milliseconds: 180), () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => EndingScreen(ending: next),
            transitionDuration: const Duration(milliseconds: 350),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      });
      return;
    }

    _fadeCtrl
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final beat = _current;
    final size = MediaQuery.of(context).size;
    final imageHeight = (size.height * 0.33).clamp(170.0, 290.0).toDouble();

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
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (beat.imagePath != null)
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
                                beat.imagePath!,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: Colors.black12),
                              ),
                            ),
                          ),
                        if (beat.sceneLabel.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            beat.sceneLabel,
                            style: GoogleFonts.robotoMono(
                              fontSize: 11,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  beat.text,
                                  style: GoogleFonts.robotoMono(
                                    fontSize: 15,
                                    color: Colors.black,
                                    height: 1.55,
                                  ),
                                ),
                                if (beat.redWarningText != null) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    beat.redWarningText!,
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 13.5,
                                      color: const Color(0xFF8B1A1A),
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 18),
                                if (beat.hasChoices)
                                  _ChoiceButtons(
                                    beat: beat,
                                    state: widget.state,
                                    onChoice: (choice) =>
                                        _goTo(choice.nextId, choice: choice),
                                  )
                                else if (beat.nextId != null && !beat.isEnding)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _ContinueButton(
                                      onTap: () => _goTo(beat.nextId!),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _ChoiceButtons extends StatelessWidget {
  final StoryBeat beat;
  final GameState state;
  final void Function(StoryChoice) onChoice;

  const _ChoiceButtons({
    required this.beat,
    required this.state,
    required this.onChoice,
  });

  @override
  Widget build(BuildContext context) {
    final visible = state.availableChoices(beat.choices!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'CHOOSE YOUR PATH',
          style: GoogleFonts.robotoMono(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        ...visible.map((c) => _ChoiceTile(choice: c, onTap: () => onChoice(c))),
      ],
    );
  }
}

class _ChoiceTile extends StatefulWidget {
  final StoryChoice choice;
  final VoidCallback onTap;

  const _ChoiceTile({required this.choice, required this.onTap});

  @override
  State<_ChoiceTile> createState() => _ChoiceTileState();
}

class _ChoiceTileState extends State<_ChoiceTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isWarn = widget.choice.isWarning;
    final borderColor = isWarn ? const Color(0xFF5A0707) : Colors.black87;
    final labelColor = isWarn ? const Color(0xFFFFC9C9) : Colors.black87;
    final textColor = isWarn ? const Color(0xFFFFE4E4) : Colors.black;
    final warnBase = const Color(0xFF3A0707);
    final warnPressed = const Color(0xFF2A0202);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          color: isWarn
              ? (_pressed ? warnPressed : warnBase)
              : (_pressed ? Colors.black.withOpacity(0.06) : Colors.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.choice.label}. ',
              style: GoogleFonts.robotoMono(
                fontSize: 13,
                color: labelColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Text(
                widget.choice.text,
                style: GoogleFonts.robotoMono(
                  fontSize: 13.4,
                  color: textColor,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ContinueButton({required this.onTap});

  @override
  State<_ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<_ContinueButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87, width: 1),
          color: _pressed ? Colors.black.withOpacity(0.06) : Colors.transparent,
        ),
        child: Text(
          'Continue',
          style: GoogleFonts.robotoMono(
            fontSize: 13.2,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
