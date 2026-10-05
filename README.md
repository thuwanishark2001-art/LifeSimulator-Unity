# Life Simulator - Android Mobile Unity Prototype

This repository contains a mobile-ready Unity life simulation starter project designed for Android APK export. It includes:

- day/night progression
- hunger, energy, mood, cleanliness, health systems
- money and job progression
- simple activity buttons
- save/load system
- modern mobile UI layout
- Unity project metadata for Android-ready setup

Important notice:

This is a complete playable starter project foundation, not a high-end commercial AAA game with custom art, 3D models, voice acting, or studio-grade realism. The project is structured to be opened in Unity on a PC and built for Android. It is designed to be expanded with your own art, animations, and gameplay systems.

## Project structure

- `Assets/Scripts/Game/LifeSaveData.cs`
- `Assets/Scripts/Game/SaveSystem.cs`
- `Assets/Scripts/Game/LifeSimulatorBootstrap.cs`
- `Packages/manifest.json`
- `ProjectSettings/ProjectVersion.txt`

## How to use in Unity

1. Open this folder in Unity Hub as a Unity project.
2. Create a new empty scene or open any existing one.
3. Add an empty GameObject named `LifeSimulator`.
4. Attach the `LifeSimulatorBootstrap` script.
5. Press Play to run the game.
6. Build Settings -> Android -> Switch Platform -> Build APK.

## Android export notes

- Set `Player Settings > Company Name`, `Product Name`, and `Bundle Identifier`.
- Set `Target Architectures` to ARM64 / ARMv7 as required.
- Enable `Android` in Build Settings.
- Use a valid Keystore for signing.
- Test on an Android device before release.

## Suggested upgrades

- add character art and 3D environment
- add inventory and furniture system
- add schedules, relationships, and events
- add day-to-day goals and quest system
- add sound and animations
- add tablet-friendly UI layouts

## License

MIT
