# Export Instructions

To download and test this project in Godot:

1. Clone or download this repository as ZIP
2. Extract the ZIP folder
3. Open Godot 4.x
4. Click "Import" and select the extracted folder
5. Open the project
6. Open `scenes/MainGame.tscn`
7. Press F5 to run and test

## What you'll see when you run it:

- A life simulation with character stats
- 11 action buttons (Work, Eat, Sleep, Relax, Shower, Social, Study, Workout, Meditate, Shop, Home+)
- Real-time stat bars that decay
- A day/night progression system
- Auto-save every 30 seconds
- Save/load functionality
- Achievement tracking

## To export as Android APK:

1. File > Export
2. Create new Android export preset
3. Configure your package name and settings
4. Build and sign the APK

## Project files included:

- `scripts/LifeStats.gd` - Game state logic
- `scripts/LifeManager.gd` - Main game loop
- `scripts/LifeHUD.gd` - UI system
- `scripts/StatBarUI.gd` - Stat bar component
- `scripts/SaveSystem.gd` - Save/load system
- `scenes/MainGame.tscn` - Main scene
- `project.godot` - Project configuration

This is a functional, playable game foundation ready for Godot development.
