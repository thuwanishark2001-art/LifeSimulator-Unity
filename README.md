# Life Simulator mobile prototype

This repository contains a mobile-first life simulation prototype built to be opened in Unity and exported to Android APK/AAB.

## What is included

- Character stats: energy, hunger, happiness, cleanliness, health, money
- Day/night progression and date tracking
- Jobs, routine actions, and life loop simulation
- Save/load system using `Application.persistentDataPath`
- Modern mobile HUD UI
- Android build guidance

## File overview

- `Assets/Scripts/Game/LifeStats.cs`
- `Assets/Scripts/Game/LifeManager.cs`
- `Assets/Scripts/Game/SaveSystem.cs`
- `Assets/Scripts/Game/LifeSaveData.cs`
- `Assets/Scripts/UI/LifeHUD.cs`
- `Assets/Scripts/UI/StatBarUI.cs`
- `Assets/Scripts/Game/BootSceneSetup.cs`
- `Assets/Scripts/Game/AndroidBuildGuide.md`

## Unity usage

1. Open the folder in Unity Hub as a Unity project.
2. Create a new scene and add an empty GameObject called `LifeSimulator`.
3. Attach the `BootSceneSetup` script to it.
4. Press Play.
5. Build Settings -> Android -> Switch Platform -> Build APK.

## Android notes

- Use a valid keystore.
- Set `Bundle Identifier` and `Application Identifier`.
- Test on a real Android device before publishing.
- Consider adding your own art, animations, sound, and progression content.

## Disclaimer

This is a complete playable starter foundation for a life sim and Android export workflow. It is not a full commercial AAA game with licensed art, advanced 3D assets, or cinematic realism. It is designed as a strong foundation for expansion.
