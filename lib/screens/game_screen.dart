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
    final imageHeight = (size.height * 0.29).clamp(140.0, 235.0).toDouble();
    final storyFontSize = size.width < 390 ? 19.0 : 20.5;
    final choicesPanelMaxHeight =
        (size.height * 0.34).clamp(165.0, 320.0).toDouble();
    final visibleChoices =
        beat.hasChoices ? widget.state.availableChoices(beat.choices!) : const <StoryChoice>[];
    final hasChoices = visibleChoices.isNotEmpty;
    final canContinue = beat.nextId != null && !beat.isEnding && !hasChoices;

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
                constraints: const BoxConstraints(maxWidth: 860),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: hasChoices
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: _StoryPane(
                                  beat: beat,
                                  imageHeight: imageHeight,
                                  storyFontSize: storyFontSize,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _BottomChoicesBar(
                                choices: visibleChoices,
                                maxHeight: choicesPanelMaxHeight,
                                onChoice: (choice) => _goTo(choice.nextId, choice: choice),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: _StoryPane(
                                    beat: beat,
                                    imageHeight: imageHeight,
                                    storyFontSize: storyFontSize,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 112,
                                child: _ContinueRailButton(
                                  enabled: canContinue,
                                  onTap: canContinue ? () => _goTo(beat.nextId!) : null,
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

class _StoryPane extends StatelessWidget {
  final StoryBeat beat;
  final double imageHeight;
  final double storyFontSize;

  const _StoryPane({
    required this.beat,
    required this.imageHeight,
    required this.storyFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (beat.imagePath != null)
          SizedBox(
            height: imageHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                beat.imagePath!,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(color: Colors.black12),
              ),
            ),
          ),
        if (beat.sceneLabel.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            beat.sceneLabel,
            style: GoogleFonts.robotoMono(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  beat.text,
                  style: GoogleFonts.ebGaramond(
                    fontSize: storyFontSize,
                    color: Colors.black,
                    height: 1.68,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (beat.redWarningText != null) ...[
                  const SizedBox(height: 14),
                  Text(
                    beat.redWarningText!,
                    style: GoogleFonts.ebGaramond(
                      fontSize: storyFontSize - 1.5,
                      color: const Color(0xFF8B1A1A),
                      fontWeight: FontWeight.w700,
                      height: 1.6,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomChoicesBar extends StatelessWidget {
  final List<StoryChoice> choices;
  final double maxHeight;
  final void Function(StoryChoice) onChoice;

  const _BottomChoicesBar({
    required this.choices,
    required this.maxHeight,
    required this.onChoice,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'CHOOSE YOUR PATH',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: choices
                    .map(
                      (choice) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _ChoiceTile(
                          choice: choice,
                          onTap: () => onChoice(choice),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          color: isWarn
              ? (_pressed ? warnPressed : warnBase)
              : (_pressed ? Colors.black.withOpacity(0.08) : Colors.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.choice.label}. ',
              style: GoogleFonts.robotoMono(
                fontSize: 13.4,
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueRailButton extends StatefulWidget {
  final bool enabled;
  final VoidCallback? onTap;

  const _ContinueRailButton({
    required this.enabled,
    required this.onTap,
  });

  @override
  State<_ContinueRailButton> createState() => _ContinueRailButtonState();
}

class _ContinueRailButtonState extends State<_ContinueRailButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final disabled = !widget.enabled || widget.onTap == null;
    return Column(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: disabled ? null : widget.onTap,
          onTapDown: disabled ? null : (_) => setState(() => _pressed = true),
          onTapUp: disabled ? null : (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: disabled ? Colors.black45 : Colors.black87,
                width: 1,
              ),
              color: disabled
                  ? Colors.black.withOpacity(0.05)
                  : (_pressed
                      ? Colors.black.withOpacity(0.10)
                      : Colors.transparent),
            ),
            child: Column(
              children: [
                Text(
                  'NEXT',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoMono(
                    fontSize: 13.8,
                    color: disabled ? Colors.black54 : Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoMono(
                    fontSize: 11.2,
                    color: disabled ? Colors.black54 : Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
