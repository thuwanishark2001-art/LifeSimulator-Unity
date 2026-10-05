# Android build guide

1. Install Unity Hub and Unity 2022.3 LTS.
2. Open this project folder in Unity.
3. In Edit > Project Settings > Player, set:
   - Company Name
   - Product Name
   - Package Name / Bundle Identifier
   - Target Architecture: ARM64 and ARMv7 (if needed)
4. File > Build Settings > Android > Switch Platform.
5. Add scenes if needed, then press Build.
6. Sign the APK with a valid keystore.
7. Install the APK on a real Android device for testing.
8. Use Android App Bundle (AAB) for Play Store publishing.

## Recommended improvements before release

- Add custom 3D models and environment objects
- Create a realistic day/night lighting setup
- Add character animations and sound effects
- Add progression quests and storyline events
- Add save slots and settings menu
- Add quality settings for mobile performance
