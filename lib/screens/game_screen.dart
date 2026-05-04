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
    final imageHeight = (size.height * 0.30).clamp(150.0, 245.0).toDouble();

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
                constraints: const BoxConstraints(maxWidth: 430),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final actionWidth = constraints.maxWidth >= 400 ? 132.0 : 114.0;
                      return FadeTransition(
                        opacity: _fadeAnim,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
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
                                          fontSize: 12.5,
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
                                                fontSize: 20,
                                                color: Colors.black,
                                                height: 1.62,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (beat.redWarningText != null) ...[
                                              const SizedBox(height: 14),
                                              Text(
                                                beat.redWarningText!,
                                                style: GoogleFonts.ebGaramond(
                                                  fontSize: 18,
                                                  color: const Color(0xFF8B1A1A),
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.55,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: actionWidth,
                              child: _ActionRail(
                                beat: beat,
                                state: widget.state,
                                onChoice: (choice) => _goTo(choice.nextId, choice: choice),
                                onContinue: beat.nextId != null && !beat.isEnding
                                    ? () => _goTo(beat.nextId!)
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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

class _ActionRail extends StatelessWidget {
  final StoryBeat beat;
  final GameState state;
  final void Function(StoryChoice) onChoice;
  final VoidCallback? onContinue;

  const _ActionRail({
    required this.beat,
    required this.state,
    required this.onChoice,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final visibleChoices =
        beat.hasChoices ? state.availableChoices(beat.choices!) : const <StoryChoice>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (beat.hasChoices) ...[
          Text(
            'PATH',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              fontSize: 11.5,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: visibleChoices
                    .map(
                      (choice) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _SideActionButton(
                          label: '${choice.label}',
                          detail: choice.text,
                          isWarning: choice.isWarning,
                          onTap: () => onChoice(choice),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ] else ...[
          const Spacer(),
          if (onContinue != null)
            _SideActionButton(
              label: 'NEXT',
              detail: 'Continue',
              onTap: onContinue!,
            ),
          const Spacer(),
        ],
      ],
    );
  }
}

class _SideActionButton extends StatefulWidget {
  final String label;
  final String detail;
  final bool isWarning;
  final VoidCallback onTap;

  const _SideActionButton({
    required this.label,
    required this.detail,
    this.isWarning = false,
    required this.onTap,
  });

  @override
  State<_SideActionButton> createState() => _SideActionButtonState();
}

class _SideActionButtonState extends State<_SideActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isWarn = widget.isWarning;
    final borderColor = isWarn ? const Color(0xFF5A0707) : Colors.black87;
    final labelColor = isWarn ? const Color(0xFFFFC9C9) : Colors.black;
    final detailColor = isWarn ? const Color(0xFFFFE4E4) : Colors.black87;
    final warnBase = const Color(0xFF3A0707);
    final warnPressed = const Color(0xFF2A0202);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          color: isWarn
              ? (_pressed ? warnPressed : warnBase)
              : (_pressed ? Colors.black.withOpacity(0.08) : Colors.transparent),
        ),
        child: Column(
          children: [
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(
                fontSize: 13.5,
                color: labelColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.detail,
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.robotoMono(
                fontSize: 10.5,
                height: 1.35,
                color: detailColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
