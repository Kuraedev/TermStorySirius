# Carnelian

**Carnelian of Sirius** — A Choose Your Own Adventure Flutter app  
St. Paul University Philippines | School of Information Technology and Engineering

## Story
Follow Carnelian — a wanderer in the city of Sirius hiding a divine secret — as she
joins a party, confronts her past, and must decide how much of herself to reveal.

Three possible endings:
- **True Ending** — The Crowned Queen of Angels Sanguine  
- **Neutral Ending** — The Journey Continues  
- **Bad Ending** — Rubiel the Sovereign Angel of Blood  

## OOP Concepts Demonstrated (R1)
| Concept | Where |
|---|---|
| **Encapsulation** | `StoryBrain` holds private `_scenes`, `_currentSceneIndex`, `_badPathActive` |
| **Abstraction** | Public API: `getStoryText()`, `getChoices()`, `nextScene()`, `isGameOver()` |
| **Data class** | `Scene` stores all per-scene properties |
| **State flag** | `_badPathActive` tracks narrative path for conditional third choice |

## Technical Requirements Met
- R1 — OOP: `Scene` class + `StoryBrain` encapsulation  
- R2 — `StatefulWidget` + `setState()` for all UI changes  
- R3 — `Scaffold`, `AppBar`, `SafeArea`, `Column`, `Expanded`, `Padding`, `Text`, `ElevatedButton`, `Card`  
- R4 — One image asset per scene, registered in `pubspec.yaml`  
- R5 — `audioplayers` package: looping background music + scene/choice/ending SFX  
- R6 — Dedicated end screen showing which ending was reached + Restart button  
- R7 — Private GitHub repository with commit history  

## Running
```bash
flutter pub get
flutter run
```

*Note: Scene images are AI-generated and declared as such.*
