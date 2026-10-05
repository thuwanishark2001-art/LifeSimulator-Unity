# Life Simulator - Godot Engine Mobile Prototype

This repository contains a mobile-ready life simulation prototype built for the **Godot Engine** (4.x) and optimized for Android APK export.

## What is included

- Character stats system: energy, hunger, happiness, cleanliness, health, money
- Day/night progression and date tracking
- Jobs, routine actions, and life loop simulation
- Save/load system using Godot's ConfigFile
- Modern mobile HUD UI built with Godot UI nodes
- Android build guidance for Godot
- Complete Godot project structure (scenes and scripts)

## File overview

- `game/LifeStats.gd` - Core stats management
- `game/LifeManager.gd` - Main game controller
- `game/SaveSystem.gd` - Persistent save/load logic
- `ui/LifeHUD.gd` - HUD display and refresh
- `ui/StatBarUI.gd` - Individual stat bar UI component
- `scenes/MainGame.tscn` - Main game scene
- `project.godot` - Godot project configuration
- `export_presets.cfg` - Android export preset

## Godot usage

1. Install Godot Engine 4.x (free and open-source)
2. Open this folder in Godot
3. Open `scenes/MainGame.tscn`
4. Press F5 or click Play to run the game
5. Export > Android > Select Android export preset > Export APK

## Android notes

- Install Android SDK and NDK via Godot project settings
- Generate a valid keystore for signing
- Set `application/config/name` and `application/package/unique_name`
- Test on a real Android device before publishing
- Consider adding custom art, animations, and sound

## Key Godot differences from Unity

- Uses GDScript (Python-like scripting language)
- Scene-based architecture instead of GameObject hierarchies
- Signals system for event communication
- ConfigFile for save data (instead of JSON)
- Built-in Node and Control UI system
- Export as APK directly from editor

## License

MIT
