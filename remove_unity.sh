#!/usr/bin/env bash
set -eu

echo "Removing Unity files from project..."

rm -rf ./Assets ./Packages ./ProjectSettings ./Library ./Temp ./Logs ./obj ./Build ./Builds ./MemoryCaptures ./UserSettings ./.vs ./.vscode

find . -type f \( \
  -name "*.cs" -o \
  -name "*.csproj" -o \
  -name "*.unity" -o \
  -name "*.unityproj" -o \
  -name "*.sln" -o \
  -name "*.asmdef" -o \
  -name "*.meta" -o \
  -name "*.pidb" -o \
  -name "*.booproj" -o \
  -name "*.svd" -o \
  -name "*.pdb" -o \
  -name "*.mdb" -o \
  -name "*.opendb" -o \
  -name "*.VC.db" -o \
  -name "*.user" -o \
  -name "*.userprefs" -o \
  -name "*.tmp" -o \
  -name "*.apk" -o \
  -name "*.aab" -o \
  -name "*.keystore" \
\) -delete

find . -type d \( \
  -name "Library" -o \
  -name "Temp" -o \
  -name "Logs" -o \
  -name "Build" -o \
  -name "Builds" -o \
  -name "obj" -o \
  -name ".vs" -o \
  -name ".vscode" -o \
  -name "MemoryCaptures" -o \
  -name "UserSettings" \
\) -prune -exec rm -rf {} +

echo "Unity cleanup complete. Open project.godot in Godot."
