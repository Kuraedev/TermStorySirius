// ─────────────────────────────────────────────────────────────────────────────
// story_data.dart  —  Complete story beats for Carnelian
// Image filenames mapped exactly to the project assets folder.
// ─────────────────────────────────────────────────────────────────────────────

import 'game_engine.dart';

// ── Asset-path constants ──────────────────────────────────────────────────────
const _scene1        = 'assets/images/scene1.jpg';
const _scene2a       = 'assets/images/scene2a.png';
const _scene2b       = 'assets/images/scene2b.jpg';
const _scene2c       = 'assets/images/scene2c.png';
const _scene2d       = 'assets/images/scene2d.png';
const _scene3a       = 'assets/images/scene3a.png';
const _scene3b       = 'assets/images/scene3b.png';
const _scene4choice  = 'assets/images/scene4choice.png';
const _scene5a       = 'assets/images/scene5a.png';
const _scene5b       = 'assets/images/scene5b.png';
const _scene6a       = 'assets/images/scene6a.png';
const _scene6b       = 'assets/images/scene6b.png';
const _scene6c       = 'assets/images/scene6c.png';
const _scene6d       = 'assets/images/scene6d.png';
const _scene6e       = 'assets/images/scene6e.png';
const _scene6f       = 'assets/images/scene6f.png';
const _scene7a       = 'assets/images/scene7a.png';
const _scene7b       = 'assets/images/scene7b.png';
const _scene7choice  = 'assets/images/scene7choice.png';
const _scene8a       = 'assets/images/scene8a.png';
const _scene8b       = 'assets/images/scene8b.png';
const _scene8c       = 'assets/images/scene8c.png';
const _scene8choicec = 'assets/images/scene8_choicec.png';
const _badEnda       = 'assets/images/bad_enda.png';
const _badEndb       = 'assets/images/bad_endb.png';
const _badEndc       = 'assets/images/bad_endc.png';
const _scene9        = 'assets/images/scene9.png';
const _trueEnda      = 'assets/images/true_enda.png';
const _trueEndb      = 'assets/images/true_endb.png';
const _neutralEnda   = 'assets/images/neutral_enda.png';
const _neutralEndb   = 'assets/images/neutral_endb.jpg';

// ─────────────────────────────────────────────────────────────────────────────

Map<String, StoryBeat> buildStoryBeats() {
  final list = <StoryBeat>[

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 1  —  Opening Scene, No Choice
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's1_1',
      sceneLabel: 'Scene 1',
      imagePath: _scene1,
      text:
          'Carnelian ventures into Sirius alone — a wanderer of unremarkable status.\n\n'
          'She stops at a familiar scent, the scent of a sweet yet nostalgic bread. '
          'Without even a second thought, she has bought some.',
      nextId: 's2_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 2  —  No Choice, Introduction of Characters
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's2_1',
      sceneLabel: 'Scene 2',
      imagePath: _scene2a,
      text:
          'She enters the commissions hall of the Questoris Assembly. She stares at the '
          'notice board, which she notices has a gold marked notice.\n\n'
          'Carnelian: "Hmm. Alright, this will do — the pay is decent at the very '
          'least..." She murmurs: "Party needed... oh, come on — where am I supposed '
          'to find one?"',
      nextId: 's2_heller',
    ),

    StoryBeat(
      id: 's2_heller',
      sceneLabel: 'Scene 2',
      imagePath: _scene2b,
      text:
          'A tall figure approaches behind her, looking down on the notice.\n\n'
          'Heller: "Oh — don\'t tell me you\'re going to do it alone, won\'t you? '
          'Little girl, that\'s risky, you know?"',
      nextId: 's2_azdhe',
    ),

    StoryBeat(
      id: 's2_azdhe',
      sceneLabel: 'Scene 2',
      imagePath: _scene2c,
      text:
          'With no noise, another figure has been there for a while.\n\n'
          'Azdhe: "Alright — two more to go."',
      nextId: 's2_party',
    ),

    StoryBeat(
      id: 's2_party',
      sceneLabel: 'Scene 2',
      imagePath: _scene2d,
      text:
          'Carnelian: "Huh? Where did you even come from?!?"\n\n'
          'Skane: "The pay is really good! Call me in too! It\'s not as much as those '
          'Platinum or Diamond marked ones — but it\'s good enough."\n\n'
          'Vita: "Talk about a rarity — the only gold one there is. Guess that\'s about '
          'a full party for it now?"\n\n'
          'Carnelian, still confused on how quickly these people came to band together, '
          'by the next day she is now going with them.',
      nextId: 's3_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 3  —  First Major Scene, Decision Point 1
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's3_1',
      sceneLabel: 'Scene 3',
      text:
          'Going to the marked ruins, they talk to each other and introduce themselves '
          'one by one. None of them questions what each other does or what each can do.\n\n'
          'First initial engagements reveal a little about each character.\n\n'
          'Heller fights like a High Order Paladin — perhaps he\'s a former? Vita is a '
          'gravity mage. Azdhe: a fast-moving assassin-like fighter akin to a Manticore. '
          'Skane: an Alchemist with ready-made concoctions and a knack for weird mixes. '
          'And finally Carnelian — as noted by Vita — fights like an Assault Warglaive '
          'of a Skyreaper Lance Squadron.',
      nextId: 's3_ambush',
    ),

    StoryBeat(
      id: 's3_ambush',
      sceneLabel: 'Scene 3',
      imagePath: _scene3a,
      text:
          'As they get familiar with each other, deeper inside the ruins the quest '
          'objective was right in front of them — when an ambush from a Goliath '
          'Despoiler struck.\n\n'
          'They fight, but decide to retreat. Carnelian, covering Skane from its claws, '
          'gets a hit. She writhes — and a wing of blood forces through her back. '
          'She knocks the Goliath back, takes Skane, and flees.\n\n'
          'Outside, fatigued, she faints. The wing liquifies. She collapses.',
      nextId: 's3_wake',
    ),

    StoryBeat(
      id: 's3_wake',
      sceneLabel: 'Scene 3',
      imagePath: _scene3b,
      text:
          'Three days later they ask:\n\n'
          'Skane: "Carnelian... what was that?"\n\n'
          'As they all wait for her answer.',
      choices: [
        StoryChoice(
          label: 'A',
          text: '"I was approached by an angel at a young age. I do not know what she '
                'gifted me — but now..."',
          nextId: 's4a_1',
          setsFlag: 'scene3',
          setsFlagValue: 'A',
        ),
        StoryChoice(
          label: 'B',
          text: '"I\'m sorry... I wish I would know. I need some time to process it. '
                'I-I\'m scared..."',
          nextId: 's4b_1',
          setsFlag: 'scene3',
          setsFlagValue: 'B',
        ),
      ],
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 4A  —  Good Path
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's4a_1',
      sceneLabel: 'Scene 4 — Good Path',
      imagePath: _scene4choice,
      text:
          'Carnelian: "I wish I never approached that angel back then. I have no control '
          'whenever it comes out. It is extremely painful — my mind and vision get '
          'flooded with nothing but bloodlust. I was able to save Skane before it '
          'completely took over... I—"\n\n'
          'Heller: "It\'s enough... I won\'t push it any further. I\'ll watch over you '
          '— after all, it\'s a Paladin\'s job to heal and protect the people '
          'with them."\n\n'
          'Skane: "Carnelian, we won\'t be afraid. But feel free to tell me when '
          'you\'re comfortable. I\'ll study it to see how we can help. I am an '
          'alchemist — but medical training comes far. May as well learn it for '
          'what I do."\n\n'
          'The night continues and they chat at the warm little campfire against '
          'the dark surroundings.',
      nextId: 's5_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 4B  —  Neutral / Bad Split
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's4b_1',
      sceneLabel: 'Scene 4 — Neutral / Bad Split',
      imagePath: _scene4choice,
      text:
          'She gives them nothing more. They don\'t push, nor ask smaller questions. '
          'Careful, controlled...\n\n'
          'Isolation of herself from the group.\n\n'
          'Carnelian, slightly apart, spaces out anxiously into the night. They chat '
          'the night away — but she never brought up any more of it.',
      redWarningText: 'Will you really take on the cost yourself?',
      nextId: 's5_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 5
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's5_1',
      sceneLabel: 'Scene 5',
      imagePath: _scene5a,
      text: 'The party arrives at the City of Incarnadines.',
      nextId: 's5_statue',
    ),

    StoryBeat(
      id: 's5_statue',
      sceneLabel: 'Scene 5',
      imagePath: _scene5b,
      text:
          'Carnelian sees a statue of an angel. She is reminded of her dark past — '
          'back when the Angel Rubiel ran away for a sin she herself can never forgive, '
          'yet the city shows the people have long forgiven her.\n\n'
          'Carnelian looks at her former self: the divine silvery white angel with '
          'deep crimson red eyes.\n\n'
          'Vita tells her she\'ll go find the party an inn. Carnelian places a '
          'Camellia flower on the Rubiel Statue — her statue. Her disguise: a deep '
          'dark shade of purple with carnelian colored eyes.',
      nextId: 's5_town',
    ),

    StoryBeat(
      id: 's5_town',
      sceneLabel: 'Scene 5',
      text:
          'While walking, lost in thought, she observes the children roleplaying '
          'as the Angel Rubiel — bringing vengeance and punishment to the Tyrant who '
          'once ruled the city. She then remembers the bakery she used to always visit '
          '5 years ago, before she isolated and sealed her identity for good.\n\n'
          'She overhears a conversation of Heller encountering a powerful angel — like '
          'the one the statue in the center of Incarnadines was built for. He never '
          'saw the face, but he was glad he survived.',
      nextId: 's6_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 6  —  Second Major Scene, Decision Point 2
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's6_1',
      sceneLabel: 'Scene 6',
      imagePath: _scene6a,
      text:
          'Within the Questoris Assembly of Incarnadines, they take up a Platinum '
          'marked quest.\n\n'
          'Vita: "Investigation of an anomalous area."',
      nextId: 's6_forest',
    ),

    StoryBeat(
      id: 's6_forest',
      sceneLabel: 'Scene 6',
      text:
          'Azdhe: "No animals, tons of missing people — and the air that reeks '
          'of blood..."\n\n'
          'The investigation proceeds. Hours of just nothing in this rotting forest.',
      nextId: 's6_angel',
    ),

    StoryBeat(
      id: 's6_angel',
      sceneLabel: 'Scene 6',
      imagePath: _scene6b,
      text:
          'Until they come across something — brutal and divine, yet it looks like '
          'absolute horror. A high ranking angel, blinded by the Black Rage, '
          'far from being saved.',
      nextId: 's6_rubiel',
    ),

    StoryBeat(
      id: 's6_rubiel',
      sceneLabel: 'Scene 6',
      imagePath: _scene6c,
      text:
          '"Lady Rubiel?" — as it tilts its head.\n\n'
          'Skane: "What\'s the matter, Heller?"',
      nextId: 's6_ready',
    ),

    StoryBeat(
      id: 's6_ready',
      sceneLabel: 'Scene 6',
      imagePath: _scene6d,
      text:
          'Carnelian: "Heller, we\'ll be fine. If it comes to it, then it\'s up to us '
          'to cover them. Still though — Kingdom Knights and other Adventurers... '
          'it\'s an entire team of 30. It\'s a real headache alright."\n\n'
          'Heller: "Everyone make ready! These things are not something we can take '
          'on easily — I\'ve seen one of them with 4 wings take on even hundreds of '
          'Kingdom Knights."\n\n'
          'Heller can take on the 4-winged angels easily back then — but this sudden '
          'encounter with six wings and a blood wheel of eyes is a serious matter.\n\n'
          'Carnelian, out of instinct, materializes 2 wings ready as weapons and '
          'her dual swords.',
      nextId: 's6_kicked',
    ),

    StoryBeat(
      id: 's6_kicked',
      sceneLabel: 'Scene 6',
      imagePath: _scene6e,
      text:
          '"My... I thought she was back, yet you carry her scent." The angel '
          'suddenly appeared in front of Carnelian.\n\n'
          '"What a sad excuse of an angel you are!"\n\n'
          'And in one moment, Carnelian is kicked into the mountainside. Her wings '
          'liquify. She looks beat.',
      nextId: 's6_aftermath',
    ),

    StoryBeat(
      id: 's6_aftermath',
      sceneLabel: 'Scene 6',
      imagePath: _scene6f,
      text:
          'After setting up camp, the aftermath.\n\n'
          'The team gathers around, shaken but together.',
      choices: [
        StoryChoice(
          label: 'A',
          text: 'Let the team close ranks around her. Accept that they saw '
                'everything and trust them to interpret it as the curse reacting '
                '— explaining to the others.',
          nextId: 's7_1',
          setsFlag: 'scene6',
          setsFlagValue: 'A',
        ),
        StoryChoice(
          label: 'B',
          text: 'Pull away after the incident. Tell them she can manage it. '
                'In secret, push the seal hard from training. It has not cleansed '
                'the Black Rage yet.',
          nextId: 's7_1',
          setsFlag: 'scene6',
          setsFlagValue: 'B',
        ),
      ],
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 7  —  Third Major Scene, Decision Point 3
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's7_1',
      sceneLabel: 'Scene 7',
      imagePath: _scene7a,
      text:
          '1 week later.\n\n'
          'Deeper exploration with just Carnelian\'s party — the rest heads back.\n\n'
          'A cult chamber. Upon entering, they witness the creation of something '
          'vile and forbidden — the bloodwings struggling to form and the wheels '
          'of blood mustering itself with the few eyes in an expression of deep '
          'rage and pain.',
      nextId: 's7_malformed',
    ),

    StoryBeat(
      id: 's7_malformed',
      sceneLabel: 'Scene 7',
      imagePath: _scene7b,
      text:
          'Heller recognizes it and rushes in to purify the area. The angel '
          'screams the name "Rubiel."\n\n'
          'Carnelian was far inside the chamber and was there first — she froze '
          'at what she was witnessing. Before Heller was able to destroy it, the '
          'malformed angel caressed the head of Carnelian.\n\n'
          'Heller carried Carnelian — but before they reached the door, she '
          'suddenly started moving out of control and screeching in agony. The '
          'seals strain and fragments of a crown of blood and thorns press '
          'outward from her head.',
      nextId: 's7_choice',
    ),

    StoryBeat(
      id: 's7_choice',
      sceneLabel: 'Scene 7',
      imagePath: _scene7choice,
      text:
          'The crown presses outward. The seal is fracturing. A choice must be made.',
      choices: [
        StoryChoice(
          label: 'A',
          text: 'Desperately pull back the manifestation — costing you everything. '
                'Act out the child responding to deep trauma.',
          nextId: 's7a_1',
          setsFlag: 'scene7',
          setsFlagValue: 'A',
        ),
        StoryChoice(
          label: 'B',
          text: 'Go after the remaining cultists and heretic guards.',
          nextId: 's7b_1',
          isWarning: false,
          setsFlag: 'scene7',
          setsFlagValue: 'B',
        ),
      ],
    ),

    // ─── Scene 7A ─────────────────────────────────────────────────────────

    StoryBeat(
      id: 's7a_1',
      sceneLabel: 'Scene 7A — Good Path',
      text:
          'Heller: "Azdhe! With me! Let\'s clear out the remaining forces!"\n\n'
          'Vita: "Skane and I will carry Carnelian. Go on ahead."\n\n'
          'Carnelian has collapsed, shaking and fading out of consciousness — '
          'but the seal retains itself.',
      nextId: 's8_1',
    ),

    // ─── Scene 7B ─────────────────────────────────────────────────────────

    StoryBeat(
      id: 's7b_1',
      sceneLabel: 'Scene 7B — Bad Path',
      text:
          'Azdhe: "Carnelian?!?"\n\n'
          'Heller & Vita: "Hey, Carnelian — stop! It\'s over!"\n\n'
          'Skane: "Hold her down! I\'ll try to subdue her!"\n\n'
          'Carnelian collapses from Skane\'s concoction — but it\'s now too late. '
          'The seal has weakened to a critical point. Its healing would take a miracle.',
      redWarningText: 'Do you really think you are doing the right thing?',
      nextId: 's8_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 8  —  Fourth Major Scene, Decision Point 4
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's8_1',
      sceneLabel: 'Scene 8',
      imagePath: _scene8a,
      text:
          'The party has gone weary of Carnelian\'s condition.\n\n'
          'A starry night. The party is around a campfire. Each one of them has '
          'been carrying something since the Cult Chamber incident.',
      nextId: 's8_secrets',
    ),

    StoryBeat(
      id: 's8_secrets',
      sceneLabel: 'Scene 8',
      text:
          'Azdhe — the person who rarely speaks in the group — breaks the silence.\n\n'
          'Azdhe: "We\'ve all been together for months now. Seems like this party '
          'is hiding more than I thought."\n\n'
          'Skane: "Well, uhh... I am one of the few Warfare Alchemists. My practices '
          'contain forbidden things. And I never mentioned it — but I am actually '
          'forbidden from entering 6 kingdoms or cities, whatever they may be now."\n\n'
          'Azdhe: "Perhaps heard the name \'Manticore\'? I do fetch for a high price '
          'to hire — but the time with this party more than pays for it now."\n\n'
          'Vita: "I stepped down from my post to live a more normal and free life. '
          'Grand Sorceress is a pain to handle. I am Singularitas — I would rather '
          'have you call me Vita the Singularity Mage, hence my supreme level '
          'affinity to Gravity Magic."',
      nextId: 's8_heller',
    ),

    StoryBeat(
      id: 's8_heller',
      sceneLabel: 'Scene 8',
      imagePath: _scene8b,
      text:
          'Heller: "Former Commander of the 1st Order of the Questoris '
          'Hospitalier Paladins. The only Hospitalier left alive. I made an oath '
          'to never draw Lightbringer again — in shame of not dying with my brothers. '
          'They were wiped out fighting what I want to call the Queen of the '
          'Blood Angels."',
      nextId: 's8_question',
    ),

    StoryBeat(
      id: 's8_question',
      sceneLabel: 'Scene 8',
      imagePath: _scene8c,
      text:
          'Heller: "So tell us, Carnelian. Whatever may be the source of your '
          'sorrows — is it getting harder to hold?"',
      choices: [
        StoryChoice(
          label: 'A',
          text: 'Yes. I\'m afraid to hurt any more people. But I trust you guys.',
          nextId: 's8a_1',
        ),
        StoryChoice(
          label: 'B',
          text: 'I\'m managing.',
          nextId: 's8b_1',
        ),
        StoryChoice(
          label: 'C',
          text: '[Nod and smile]',
          nextId: 's8c_1',
          isWarning: true,
          requiresFlag: 'scene7_bad',
        ),
      ],
    ),

    // ─── Scene 8A (Good Path) ─────────────────────────────────────────────

    StoryBeat(
      id: 's8a_1',
      sceneLabel: 'Scene 8A — Good Path',
      text:
          'Carnelian relaxes and falls into slumber from the built-up fatigue '
          'of the day. They gather around each other as one big group — with '
          'a newfound trust with each other.',
      nextId: 's9_true_1',
    ),

    // ─── Scene 8B (Neutral Path) ──────────────────────────────────────────

    StoryBeat(
      id: 's8b_1',
      sceneLabel: 'Scene 8B — Neutral Path',
      text:
          'Carnelian smiles and assures them not to worry. Heller steps up and '
          'pets her on the head before everyone gathers together around to '
          'support her.',
      nextId: 's9_neutral_1',
    ),

    // ─── Scene 8C (Bad Path) ──────────────────────────────────────────────

    StoryBeat(
      id: 's8c_1',
      sceneLabel: 'Scene 8C — Bad Path',
      imagePath: _scene8choicec,
      text:
          'Carnelian says nothing and gives them a nod and smile.\n\n'
          'Heller notices spots of red on her carnelian colored eyes — but pays '
          'no mind. It may just be the suddenness of the curse.\n\n'
          'But in reality, the seal has cracked. Now it\'s steadily worsening '
          'and the unpurified power is leaking out faster and faster. The red '
          'on her eyes was the sign. Her demeanor has shifted.',
      nextId: 'bad_1',
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // BAD ENDING
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 'bad_1',
      sceneLabel: 'Bad Ending',
      imagePath: _badEnda,
      text:
          'You never make it back to Sirius.\n\n'
          'The seal has been broken wide open — forcibly and abruptly — while '
          'defending a town under attack from heretic forces. Vanadyr lays the '
          'death of your party by your hands, and the manifestation of the '
          '8 Winged and Three Blood Wheels of Eyes corrupted by the Black Rage.',
      nextId: 'bad_2',
    ),

    StoryBeat(
      id: 'bad_2',
      sceneLabel: 'Bad Ending',
      imagePath: _badEndb,
      text:
          'Now face the full consequence. The Angels that once were are once '
          'again rampaging across the world. Carnelian did not find redemption, '
          'but eternal destruction...\n\n'
          'Thus it has begun — The Second Coming of the Angels of Blood, their '
          'queen within Carnelian corrupted by the Black Rage. May the world '
          'find peace in death.\n\n'
          'Rubiel The Sovereign Angel of Blood.',
      nextId: 'bad_end',
    ),

    StoryBeat(
      id: 'bad_end',
      sceneLabel: 'Bad Ending',
      imagePath: _badEndc,
      text: 'The End.',
      endingType: EndingType.bad,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 9 → TRUE ENDING
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's9_true_1',
      sceneLabel: 'Scene 9 — Holy Saint of Sirius Ceremony',
      imagePath: _scene9,
      text:
          'The ceremony in town is in full swing — the celebration of Sister '
          'Ruby\'s memory, the angel of light, the angel of justice that once '
          'descended down.\n\n'
          'Carnelian stands with the crowd, then before the statue.',
      nextId: 'true_1',
    ),

    StoryBeat(
      id: 'true_1',
      sceneLabel: 'True Ending',
      imagePath: _trueEnda,
      text:
          'She steps forward at the ceremony. Not dramatically — simply. She '
          'walks to the statue. She kisses the stone forehead and tells her she '
          'can rest now. She turns to the crowd.\n\n'
          'The thorns have become vines. The crown that once pierced inward has '
          'become something that grows outward. She reveals herself — not as a '
          'monster returning, but as the woman who left, who learned, who came '
          'back changed.\n\n'
          'Carnelian has come to terms with herself and everyone around her. The '
          'seal mended with the love that the angels are born with — turning the '
          'thorns to vines of a gentle garden. No longer the suffering from a '
          'crown of blood and thorns.\n\n'
          'Carnelian attends the Holy Saint of Sirius ceremony and reveals to the '
          'people and her friends that the one they worshipped for so long is the '
          'one and true: The Crowned Queen of the Angels Sanguine.\n\n'
          'May her true name echo once more in the cheers of the people.\n\n'
          'Rubiel.',
      nextId: 'true_end',
    ),

    StoryBeat(
      id: 'true_end',
      sceneLabel: 'True Ending',
      imagePath: _trueEndb,
      text: 'The End.',
      endingType: EndingType.truePath,
    ),

    // ═══════════════════════════════════════════════════════════════════════
    // SCENE 9 → NEUTRAL ENDING
    // ═══════════════════════════════════════════════════════════════════════

    StoryBeat(
      id: 's9_neutral_1',
      sceneLabel: 'Scene 9 — Holy Saint of Sirius Ceremony',
      imagePath: _scene9,
      text:
          'The ceremony in town is in full swing — the celebration of Sister '
          'Ruby\'s memory, the angel of light, the angel of justice that once '
          'descended down.\n\n'
          'Carnelian stands with the crowd, then before the statue.',
      nextId: 'neutral_1',
    ),

    StoryBeat(
      id: 'neutral_1',
      sceneLabel: 'Neutral Ending',
      imagePath: _neutralEnda,
      text:
          'She turns away from the statue. She walks back to the party. She says '
          'nothing. The seal is still holding — barely, slowly decaying — but she '
          'is Carnelian and she will be Carnelian for as long as she can manage it. '
          'The party continues down the road. Her secrets travel with her.\n\n'
          'The Journey of Carnelian continues without ever telling the entire '
          'party of what you truly are. Withheld secrets till the ends of time.\n\n'
          'This is the most peaceful way to go — the pacifist route. This power '
          'within, however, will not last eons as a secret. The sacred seal shall '
          'continue to decay.',
      nextId: 'neutral_end',
    ),

    StoryBeat(
      id: 'neutral_end',
      sceneLabel: 'Neutral Ending',
      imagePath: _neutralEndb,
      text: 'The End.',
      endingType: EndingType.neutral,
    ),
  ];

  return {for (final b in list) b.id: b};
}
