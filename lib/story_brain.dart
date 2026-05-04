import 'scene.dart';

String _i(String n) => 'assets/images/$n';
Segment s(String img, String txt) => Segment(_i(img), txt);

class StoryBrain {
  int  _sceneIndex    = 0;
  int  _segIndex      = 0;
  bool _badPathActive = false;

  final List<Scene> _scenes = [

    // 0: Title
    Scene(segments: [], choices: ['start'], nextScenes: [1], isTitleScreen: true),

    // 1: Scene 1 — Opening (Carnelian alone)
    Scene(
      segments: [
        s('s2_e.png',   // lone figure in snowy forest = Carnelian wandering alone
          'Scene 1: Opening Scene, No choice\n\n'
          'Carnelian ventures into Sirius alone, A wanderer of unremarkable status. '
          'She stops at a familiar scent, the scent of a sweet yet nostalgic bread — '
          'without even a second thought she has bought some.'),
      ],
      choices: [], nextScenes: [2],
    ),

    // 2: Scene 2 — Introduction of Characters
    Scene(
      segments: [
        s('s1_a.png',   // quest board — party at notice board
          'Scene 2: No Choice, Introduction of Characters.\n\n'
          'She enters the commissions hall of the Questoris Assembly. '
          'She stares at the notice board which she notices a gold marked notice.\n\n'
          'Carnelian: "Hmm. Alright this will do, the pay is decent at the very least..."\n'
          'She murmurs "Party needed, oh come on where am I supposed to find one"'),
        s('s2_d.png',   // Carnelian — pale girl looking up "Huh?"
          'A tall figure approaches behind her looking down on the notice.\n\n'
          'Heller: "Oh, don\'t tell me you\'re going to do it alone wont you? Little girl thats risky you know?"\n\n'
          'With no noise another figure has been there for a while.\n\n'
          'Azdhe: "Alright two more to go."\n\n'
          'Carnelian: "Huh? Where did you even come from?!?"'),
        s('s7_b.png',   // party around table — the group forming together
          'Skane: "The pay is really good! Call me in too! Its not as much as those Platinum or Diamond marked ones but its good enough."\n\n'
          'Vita: "Talk about a rarity, the only gold one there is, guess thats about a full party for it now?"\n\n'
          'Carnelian still confused on how quickly these people came to band together, by the next day she is now going with them.'),
      ],
      choices: [], nextScenes: [3],
    ),

    // 3: Scene 3 — Decision Point 1
    Scene(
      segments: [
        s('s5_b.png',   // inquisitor figures at ruins entrance — party arriving at ruins
          'Scene 3: First Major Scene, Decision Point 1\n\n'
          'Going to the marked ruins they talk to each other and introduced themselves one by one, '
          'none of them questions what each other does and what each can do. '
          'First initial engagements reveal a little about each character. '
          'Heller fights like a High Order Paladin perhaps he\'s a former? '
          'Vita is a gravity mage. Azdhe a fast moving assassin like fighter like a Manticore, '
          'Skane a Alchemist with ready made concoctions and a knack for weird mixes, '
          'and finally Carnelian as noted by Vita fights like an Assault Warglaive of a Skyreaper Lance Squadron.'),
        s('s3_a.png',   // giant monster vs warrior — Goliath Despoiler fight
          'As they get familiar with each other and deeper inside the ruins, '
          'the quest objective was right infront of them when an ambush from a Goliath Despoiler. '
          'They fight but decide to retreat — Carnelian in covering Skane from its claws gets a hit, '
          'she writhes and a wing of blood forces through her back. '
          'She knocks the Goliath back then takes Skane and flees. '
          'Outside fatigued she faints the wing liquifies she collapses.\n\n'
          'Three days later they ask:'),
        s('s3_c.png',   // dark crowned Carnelian with blood — the reveal moment
          'Skane: "Carnelian what was that"\n\n'
          'As they all wait for her answer.'),
      ],
      choices: [
        'A (Good Path): "I was approached by an angel at a young age I do not know what she gifted me but now..."',
        'B (Neutral/Bad Split): "I\'m sorry... I wish I would know, I need some time to process it, I-I\'m scared..."',
      ],
      nextScenes: [4, 5],
    ),

    // 4: Scene 4A — Choice A
    Scene(
      segments: [
        s('s2_b.png',   // two girls (Carnelian confiding, warm moment)
          'Scene 4A - Choice A:\n\n'
          'Carnelian: "I wish I never approached that angel back then, I have no control whenever it comes out. '
          'It is extremely painful my mind and vision gets flooded with nothing but bloodlust. '
          'I was able to save Skane before it completely took over... I-"\n\n'
          'Heller: "It\'s enough... I wont push it any further, I\'ll watch over you, '
          'after all it\'s a Paladin\'s job to heal and protect the people with them."\n\n'
          'Skane: "Carnelian we wont be afraid, but feel free to tell me when you\'re comfortable. '
          'I\'ll study it to see how we can help. I am an alchemist but well... '
          'medical training comes far may as well learn it for what I do"\n\n'
          'The night continues and they chat at the warm little campfire against the dark surroundings.'),
      ],
      choices: [], nextScenes: [6],
    ),

    // 5: Scene 4B — Choice B
    Scene(
      segments: [
        s('s6_e.png',   // moonlit campfire by lake — isolated, alone by the fire
          'Scene 4AB - Choice B:\n\n'
          'She gives them nothing more, they dont push nor ask smaller questions. '
          'Careful, controlled... and Isolation of herself from the group.\n\n'
          'Will you really take on the cost yourself?\n\n'
          'Carnelian slightly apart, and spacing out anxiously into the night. '
          'They chat the night but she never brought up any more of it.'),
      ],
      choices: [], nextScenes: [6],
    ),

    // 6: Scene 5 — Incarnadines
    Scene(
      segments: [
        s('neutral.png',  // fantasy city — City of Incarnadines arriving
          'Scene 5\n\n'
          'The party arrives at the City of Incarnadines. Carnelian sees a statue of an angel — '
          'she is reminded of her dark past back when the Angel Rubiel ran away for a sin '
          'she herself can never forgive yet it shows the people has long forgiven her.'),
        s('s6_d.png',   // crowned veiled stone statue — the Rubiel statue!
          'Carnelian looks at her former self — the divine silvery white angel with deep crimson red eyes. '
          'Vita tells her she\'ll go find the party an inn. '
          'Carnelian places a Camelia flower on the Rubiel Statue. Her statue. '
          'Her disguise: a deep dark shade of purple with carnelian colored eyes.\n\n'
          'While walking lost in thought she observed the children roleplaying as the Angel Rubiel '
          'bringing vengeance and punishment to the Tyrant who once ruled the city. '
          'She then remembers the bakery she used to always visit 5 years ago '
          'before she isolated and sealed her identity for good.\n\n'
          'She overhears a conversation of Heller encountering a powerful angel like what the statue '
          'in the center of Incarnadines built. Never saw the face but he was glad he survived.'),
      ],
      choices: [], nextScenes: [7],
    ),

    // 7: Scene 6 — Decision Point 2
    Scene(
      segments: [
        s('s7_b.png',   // party at table — Questoris Assembly taking the quest
          'Scene 6: Second Major Scene, Decision Point 2\n\n'
          'Within the Questoris Assembly of Incarnadines they take up a Platinum marked quest.\n\n'
          'Vita: "Investigation of an anomalous area."\n'
          'Azdhe: "No animals, tons of missing people and the air that reeks of blood..."'),
        s('s3_b.png',   // dark misty skeleton forest — the rotting forest
          'Skane: "Whats the matter Heller?"'),
        s('s5_b.png',   // inquisitor ruins scene — the investigation
          'Carnelian: "Heller we\'ll be fine, if it comes to it then its up to us to cover them. '
          'Still though, Kingdom Knights and other Adventurers its an entire team of 30. '
          'It\'s a real headache alright."\n\n'
          'The investigation proceeds hours of just nothing in this rotting forest '
          'until they come across something, brutal and divine yet it looks like absolute horror. '
          'A high ranking angel blinded by the Black Rage far from being saved.'),
        s('s6_b.png',   // bound winged angel with eye-rings — Lady Rubiel!
          '"Lady Rubiel?" as it tilts its head.\n\n'
          'Heller: "Everyone make ready! These things are not something we can take on easily, '
          'I\'ve seen one of them with 4 wings take on even hundreds of kingdom knights"\n\n'
          'Heller can take on the 4 winged angels easily back then, but this sudden encounter '
          'with six and a blood wheel of eyes. It is a serious matter.'),
        s('s5_a.png',   // epic battle scene — the angel fight
          'Carnelian out of instinct her Angel abilities materializes 2 wings ready as weapons and her dual swords.\n\n'
          '"My... I thought she was back, yet you carry her scent" '
          'The angel suddenly appeared infront of Carnelian '
          '"What a sad excuse of an angel you are!" and in one moment '
          'Carnelian is kicked into the mountainside, her wings liquifies and she looks beat.'),
        s('s6_e.png',   // campfire aftermath — "After setting up camp"
          'After setting up camp the aftermath.'),
      ],
      choices: [
        'A (Good Path): Let the team close ranks around her. Accept that they saw everything and trust them.',
        'B (Bad Path): Pull away after the incident. Tell them she can manage it, and in secret push the seal hard from training. It has not cleansed the Black Rage yet.',
      ],
      nextScenes: [8, 9],
    ),

    // 8: Scene 6A
    Scene(
      segments: [
        s('s6_e.png',
          'She lets the team close ranks around her. '
          'They saw everything — and she trusts them to understand.\n\n'
          'They do not pry. They do not push. '
          'Heller keeps watch. Skane quietly takes notes. Vita stays close.\n\n'
          'She is not alone in this anymore.'),
      ],
      choices: [], nextScenes: [10],
    ),

    // 9: Scene 6B [BAD FLAG]
    Scene(
      segments: [
        s('s6_e.png',
          'She pulls away after the incident. Tells them she can manage it.\n\n'
          'That night, while they sleep, she presses hard against the seal — '
          'forcing the power inward, training in secret.\n\n'
          'It has not cleansed the Black Rage yet.'),
      ],
      choices: [], nextScenes: [10], setsBadFlag: true,
    ),

    // 10: Scene 7 — Decision Point 3
    Scene(
      segments: [
        s('s6_a.png',   // blood wheel of red eyes — the cult chamber!
          'Scene 7: Third Major Scene, Decision Point 3\n\n'
          '1 week later. Deeper exploration with just the Carnelian\'s Party and the rest heads back.\n\n'
          'A cult chamber, upon entering they witness the creation of something vile and forbidden, '
          'the bloodwings struggling to form and the wheels of blood mustering itself '
          'with the few eyes in a expression of deep rage and pain.'),
        s('s7_a.png',   // giant white angel statue — holy/divine atmosphere of the angel
          'Heller recognizes it as he rushes in to purify the area the angel screams the name "Rubiel."\n\n'
          'Carnelian was far inside the chamber and was there first she froze because of what she is witnessing '
          'before Heller was able to destroy it malformed angel it caressed the head of Carnelian.\n\n'
          'Heller carried Carnelian but before they reached the door she suddenly started moving '
          'out of control and screeching in agony. '
          'The seals strains and fragments of a crown of blood and thorns press outward of her head.'),
        s('s3_c.png',   // dark Carnelian — the choice moment
          'What will you do?'),
      ],
      choices: [
        'A: Desperately pull back the manifestation costing you everything. Act out the child responding to deep trauma.',
        'B: Go after the remaining cultists and heretic guards.',
      ],
      nextScenes: [11, 12],
    ),

    // 11: Scene 7A
    Scene(
      segments: [
        s('s3_c.png',
          'Scene 7A - Choice A:\n\n'
          'Heller: "Azdhe! with me! lets clear out the remaining forces"\n'
          'Vita: "Skane and I will carry out Carnelian go on ahead"\n\n'
          'Carnelian has collapsed, shaking and fading out of consciousness but the seal retains itself.'),
      ],
      choices: [], nextScenes: [13],
    ),

    // 12: Scene 7B [BAD FLAG]
    Scene(
      segments: [
        s('s3_c.png',
          'Scene 7B - Choice B:\n\n'
          'Azdhe: "Carnelian?!?"\n'
          'Heller & Vita: "Hey Carnelian stop! its over!"\n'
          'Skane: "Hold her down! I\'ll try to subdue her!"\n\n'
          'Carnelian collapses from Skane\'s Concoction but it\'s now too late, '
          'the seal had weaken to a critical point, it\'s healing would take a miracle to.\n\n'
          'Do you really think you are doing the right thing?'),
      ],
      choices: [], nextScenes: [13], setsBadFlag: true,
    ),

    // 13: Scene 8 — Decision Point 4
    Scene(
      segments: [
        s('s2_c.png',   // dark campfire under huge tree — starry night campfire
          'Scene 8: Fourth Major Scene, Decision Point 4\n\n'
          'The Party has gone weary of Carnelian\'s condition.\n\n'
          'A starry night. The Party is around a campfire. '
          'Each one of them have been carrying something since the Cult Chamber incident.\n\n'
          'Azdhe the person who rarely speaks in the group breaks the silence.\n\n'
          'Azdhe: "We\'ve all been together for months now. Seems like this party is hiding more than I thought."\n\n'
          'Skane: "Well uhh... I am one of the few Warfare Alchemist, My practices contain forbidden things, '
          'and I never mentioned it but I am actually forbidden from entering 6 kingdoms or cities whatever they may be now."\n\n'
          'Azdhe: "Perhaps heard the name \'Manticore\'? I do fetch for a high price to hire, '
          'but the time with this party more than pays for it now"\n\n'
          'Vita: "I stepped down my post to live a more normal and free life. Grand Sorceress is a pain to handle. '
          'I am Singularitas, I would rather have you guys call me Vita the Singularity Mage '
          'hence my supreme level affinity to Gravity Magic."'),
        s('s6_e.png',   // moonlit campfire — Heller's solemn confession by firelight
          'Heller: "Former Commander of the 1st order of the Questoris Hospitalier Paladins. '
          'The only hospitalier left alive. I made an oath to never draw Lightbringer again. '
          'in shame of not dying with my brothers. '
          'They were wiped out fighting what I want to call the Queen of the Blood Angels."\n\n'
          'Heller: "So tell us Carnelian. Whatever may that be the source of your sorrows, '
          'Is it getting harder to hold?"'),
      ],
      choices: [
        'A (Good Path): "Yes, I\'m afraid to hurt any more people. But I trust you guys."',
        'B (Neutral): "I\'m managing."',
        'C (Bad - Available if choice B was taken in scene 7): Nod and smile.',
      ],
      nextScenes: [14, 15, 16],
    ),

    // 14: Scene 8A
    Scene(
      segments: [
        s('s6_e.png',
          'Scene 8A - Choice A:\n\n'
          'Carnelian Relaxes and falls into slumber from the built up fatigue of the day, '
          'They gather around each other as one big group with a new found trust with each other.'),
      ],
      choices: [], nextScenes: [17],
    ),

    // 15: Neutral Ending
    Scene(
      segments: [
        s('s6_e.png',
          'Scene 8B - Choice B:\n\n'
          'Carnelian smiles and assures them to not worry, '
          'Heller steps up pets her on the head before everyone gathers together around to support her.'),
        s('neutral.png',  // city of Sirius — "The Journey of Carnelian continues"
          'Neutral Ending:\n\n'
          'She turns away from the statue. She walks back to the party. She says nothing. '
          'The seal is still holding — barely, slowly decaying — but she is Carnelian and she will '
          'be Carnelian for as long as she can manage it. '
          'The party continues down the road. Her secrets travel with her.\n\n'
          'The Journey of Carnelian continues without ever telling the entire party of what you truly are, '
          'Withheld secrets till the ends of time. '
          'This is the most peaceful way to go, the pacifist route. '
          'This power within however will not last eons as a secret, the sacred seal shall continue to decay.'),
      ],
      choices: [], nextScenes: [], endingTitle: 'Neutral Ending',
    ),

    // 16: Scene 8C [BAD] → Bad Ending
    Scene(
      segments: [
        s('s8c.png',    // red-haired Carnelian with wings — she nods and smiles, cracking
          'Scene 8C - Choice C:\n\n'
          'Carnelian says nothing and gives them a nod and smile. '
          'Heller notices spots of red on her Carnelian colored eyes, '
          'but pays no mind it may just be the suddenness of the curse.\n\n'
          'But in reality the seal has cracked and now its steadily worsening '
          'and the unpurified power is leaking out faster and faster. '
          'The Red on her eyes was the sign. Her demeanor has shifted.'),
      ],
      choices: [], nextScenes: [18], setsBadFlag: true,
    ),

    // 17: Scene 9 → True Ending
    Scene(
      segments: [
        s('s8_a.png',   // festive city with fireworks — the ceremony in full swing!
          'Scene 9 - Holy Saint of Sirius Ceremony: Good and Neutral Paths converge here\n\n'
          'The ceremony in town is in full swing, The celebration of Sister Ruby\'s memory, '
          'The angel of light, the angel of justice that once descended down.\n\n'
          'Carnelian stands with the crowd then infront of the statue.'),
      ],
      choices: [], nextScenes: [19],
    ),

    // 18: Bad Ending
    Scene(
      segments: [
        s('bad_a.png',  // dark warrior standing in blood — Vanadyr / party death
          'Bad Ending:\n\n'
          'You never make it back to Sirius. '
          'The seal has been broken wide open forcibly and abruptly '
          'while defending a town under attack from heretic forces.\n\n'
          'Vanadyr lays the death of your party by your hands and the manifestation of the 8 Winged '
          'and Three Blood Wheels of Eyes corrupted by the Black Rage.'),
        s('bad_b.png',  // dark wings on blood red — Rubiel the Sovereign Angel
          'Now face the full consequence. The Angels that once were are once again rampaging across the world. '
          'Carnelian did not find redemption but eternal destruction...\n\n'
          'Thus it has begun, The Second Coming of the angels of blood, '
          'their queen within Carnelian has been corrupted by the Black Rage. '
          'May the world find peace in death.\n\n'
          'Rubiel The Sovereign Angel of Blood.'),
      ],
      choices: [], nextScenes: [], endingTitle: 'Bad Ending',
    ),

    // 19: True Ending
    Scene(
      segments: [
        s('s8_b.png',   // grand plaza with rose petals — the crowd, the revelation
          'True Ending - The Crowned Queen of Angels Sanguine:\n\n'
          'She steps forward at the ceremony. Not dramatically — simply. '
          'She walks to the statue. She kisses the stone forehead and tells her she can rest now. '
          'She turns to the crowd. The thorns have become vines. '
          'The crown that once pierced inward has become something that grows outward. '
          'She reveals herself not as a monster returning but as the woman who left, who learned, who came back changed.'),
        s('s8c.png',    // Carnelian with wings revealed — the true queen
          'Carnelian has come to terms with herself and everyone around her. '
          'The seal mended with the love that the angels are born with '
          'turned the thorns to vines of a gentle garden. '
          'No longer is the suffering from a crown of blood and thorns.\n\n'
          'Carnelian attends the Holy Saint of Sirius ceremony and reveals the people and her friends '
          'that the one they worshiped for so long is the one and true, '
          'The Crowned Queen of the Angels Sanguine. '
          'May her true name echo once more in the cheers of the people,\n\n'
          'Rubiel.'),
      ],
      choices: [], nextScenes: [], endingTitle: 'True Ending — The Crowned Queen of Angels Sanguine',
    ),
  ];

  // ── Public API ─────────────────────────────────────────────────────────────
  Scene get _scene => _scenes[_sceneIndex];
  Segment? get _seg => _scene.segments.isNotEmpty ? _scene.segments[_segIndex] : null;

  String getStoryText()   => _seg?.text ?? '';
  String getImageAsset()  => _seg?.image ?? '';
  String getEndingTitle() => _scene.endingTitle ?? 'The End';

  bool isGameOver()    => _scene.isEnding;
  bool isTitleScreen() => _scene.isTitleScreen;
  bool isBadPath()     => _badPathActive;
  bool isLastSegment() => _segIndex >= _scene.segments.length - 1;

  List<String> getChoices() {
    if (!isLastSegment()) return [];
    final c = _scene.choices;
    if (_sceneIndex == 13 && !_badPathActive) return List.unmodifiable(c.take(2).toList());
    return List.unmodifiable(c);
  }

  bool canTapAdvance() => _scene.choices.isEmpty && !_scene.isEnding && !_scene.isTitleScreen;

  bool advanceSegment() {
    if (_segIndex < _scene.segments.length - 1) { _segIndex++; return false; }
    return true;
  }

  void nextScene(int choiceIndex) {
    if (isGameOver()) return;
    if (_scene.setsBadFlag) _badPathActive = true;
    List<int> targets = (_sceneIndex == 13 && !_badPathActive)
        ? [14, 15] : _scene.nextScenes;
    if (choiceIndex < 0 || choiceIndex >= targets.length) return;
    _sceneIndex = targets[choiceIndex];
    _segIndex   = 0;
    if (_scenes[_sceneIndex].setsBadFlag) _badPathActive = true;
  }

  void restart() { _sceneIndex = 0; _segIndex = 0; _badPathActive = false; }
}
