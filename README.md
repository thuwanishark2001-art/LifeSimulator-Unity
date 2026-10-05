# LifeSimulator - Godot Edition

A professional life simulation game built with Godot 4.x and optimized for Android export.

## Features

- Character stats system (energy, hunger, happiness, health, cleanliness)
- Job progression with multiple career levels
- Daily actions (work, eat, sleep, relax, shower, socialize, study, workout, meditate, shop)
- Home upgrades and quality progression
- Fitness and skill development systems
- Relationship tracking
- Achievement system
- Multiple save slots
- Save/load with persistent data
- Modern mobile UI
- Real-time day progression
- Status indicators and warnings
- Responsive button layout
- Color-coded health bars

## How to run

1. Open this project folder in Godot 4.x
2. Open `scenes/MainGame.tscn`
3. Press F5 or click Play
4. Interact with buttons to take actions
5. Game auto-saves every 30 seconds

## Clean Unity leftovers

Run the repository cleanup script before opening the project in Godot:

```bash
chmod +x remove_unity.sh
./remove_unity.sh
```

## Android export

1. Install Godot and Android build templates
2. Go to Project > Export Presets
3. Create an Android export preset
4. Set up Android SDK/NDK paths in Godot settings
5. Configure your package name (for example, `com.yourname.lifesimulator`)
6. Generate a keystore for signing
7. Click Export to create APK
8. Install and test on a real Android device

## Project structure

```
scenes/
  MainGame.tscn
scripts/
  LifeStats.gd
  LifeManager.gd
  LifeHUD.gd
  StatBarUI.gd
  SaveSystem.gd
ui/
  ...
game/
  ...
docs/
  AndroidExportChecklist.md
project.godot
icon.svg
```

## Gameplay tips

- Balance your stats to stay healthy and happy
- Work regularly to earn money for upgrades
- Keep energy and hunger balanced
- Shower regularly for cleanliness
- Socialize to increase happiness and relationships
- Study to increase skills for better jobs
- Workout to improve health and fitness
- Meditate for mental health boosts
- Shop to get items and boost happiness
- Complete achievements for additional goals

## Important notes

This project is designed as a Godot-based mobile game prototype and Android-ready foundation. The project uses GDScript and Godot-native architecture rather than Unity.

## License

MIT License
