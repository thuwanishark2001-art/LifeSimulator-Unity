# Life Simulator

This repository now contains a Godot Engine mobile life-simulation prototype for Android export.

What is inside:
- Godot project configuration
- GDScript life simulation logic
- save/load system using ConfigFile
- modern mobile HUD built in GDScript
- Android export-ready setup instructions

Core files:
- `project.godot`
- `scripts/LifeStats.gd`
- `scripts/SaveSystem.gd`
- `scripts/LifeManager.gd`
- `scripts/LifeHUD.gd`
- `scripts/StatBarUI.gd`
- `scenes/MainGame.tscn`

How to run:
1. Open the folder in Godot 4.x
2. Press F5 to run the project
3. Export > Android > Export APK

Notes:
- This is a strong game foundation, not a full commercial AAA title with custom art, realistic animation, and advanced world simulation.
- You still need Android SDK/NDK setup and signing for actual APK production.

MIT License
