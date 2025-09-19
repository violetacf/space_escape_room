# space_escape_room

A Flutter-based space-themed escape room game where players explore outside the spaceship, interact with objects, find codes, and unlock the next stages of the adventure.

## Project Description

This project is a mobile Flutter application that combines interactive gameplay with visually engaging assets. Players must explore the spaceship exterior, solve puzzles using clues from objects like aliens and stars, and input the correct codes to progress. The game features:

- Custom animated dialogs with futuristic design (`FuturisticDialog` widget)
- Floating and animated interactive objects
- Sound effects for interactions using `audioplayers`
- Smooth navigation between game screens
- A scalable architecture using `StatefulWidgets` and animations

## Tech Stack

- Flutter 3.9+
- Dart SDK 3.9+
- Packages used:
  - [`audioplayers`](https://pub.dev/packages/audioplayers) — for audio playback
  - [`path_provider`](https://pub.dev/packages/path_provider) — for temporary directories (needed by audioplayers)
- Assets:
  - Images: `.jpg` and `.png`
  - Sounds: `.mp3`

## Getting Started

Follow these instructions to run the project locally.

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install))
- Android Studio or Xcode (for mobile emulators)
- Device or simulator/emulator

### Installation

1. Clone the repository:

```bash
git clone git@github.com:violetacf/space_escape_room.git
cd space_escape_room
```

2. Install dependencies:

```bash
flutter pub get
```

Ensure all assets are included in `pubspec.yaml`.

## Running the App

Run on a connected device or simulator:

```bash
open a- Simulator
flutter run
```

## Project Structure

```bash
lib/
 ├─ main.dart
 ├─ screens/
 │   ├─ home_screen.dart
 │   ├─ outside_screen.dart
 │   └─ panel_screen.dart
 ├─ widgets/
 │   └─ futuristic_dialog.dart
 └─ models/
     └─ outside_item.dart
assets/
 ├─ images/
 └─ sounds/
```

## Run with the script

In your terminal:

```bash
./run_game.sh
```
