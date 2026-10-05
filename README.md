# Godot Life Simulator - Complete Game Project

A functional mobile life simulation game built with Godot 4.x and ready for Android export.

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

## Android export

1. Install Godot and Android build templates
2. Go to Project > Export Presets
3. Create Android export preset
4. Set up Android SDK/NDK paths in Godot settings
5. Configure your package name (e.g., com.yourname.lifesimulator)
6. Generate a keystore for signing
7. Click Export to create APK
8. Install and test on real Android device

## Project structure

```
scripts/
  LifeStats.gd          - Core game state and actions
  LifeManager.gd        - Main game loop and logic
  LifeHUD.gd            - UI management and rendering
  StatBarUI.gd          - Individual stat bar component
  SaveSystem.gd         - Save/load and persistence

scenes/
  MainGame.tscn         - Main game scene

docs/
  AndroidExportChecklist.md
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

This is a fully functional game prototype and Android-ready project foundation. It is not a complete AAA commercial game with custom 3D art, professional voice acting, or advanced AI systems. It is designed as a solid base for further development and customization.

The game runs well on mobile devices and is optimized for Android phones. Further enhancements can include:
- Custom 2D/3D graphics and animations
- More detailed story and character systems
- Music and sound effects
- Additional gameplay systems
- Network/cloud save integration
- Tablet-specific UI layouts

## License

MIT License
