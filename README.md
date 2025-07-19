
# 🧠 Mind Mate – Mental Wellness Companion App

Mind Mate is a **Flutter-based mental wellness mobile app** tailored for university students.  
It allows users to track moods, journal emotions, access meditation guides, connect anonymously with peers, and contact emergency help — **all offline** using local storage via **Hive**.

---

## ✨ Features

### 🌈 Mood Tracker
- Add, edit, or delete moods using swipe gestures
- View mood history in a scrollable card list
- Long-press or swipe right to edit, left to delete

### 📔 Journal
- Write and save private journal entries
- View and manage past reflections
- Local-only, secure, and fast

### 💬 Peer Chat (Anonymous)
- Chat anonymously with others in a peer-support format
- (Currently simulates interaction — can be extended to real-time Firebase or AI)

### 🧘 Meditation Timer
- Timer for guided breathing or meditation sessions
- Includes calming animations (Lottie/GIF)

### 📞 Emergency Contacts
- One-tap call to school helpline or mental support
- All numbers are hardcoded for offline use

### 🗃️ Offline-First Architecture
- All data (moods, journals) stored using Hive
- Lightweight and efficient, works without internet

---

## 📁 Project Structure

```

lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── local/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── repositories/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── providers/

````

---

## 🚀 Getting Started

### 📦 Requirements
- Flutter 3.3.0+
- Dart SDK
- Android Studio or VS Code
- Emulator/device setup

### ⚙️ Setup Instructions

```bash
git clone https://github.com/YourUsername/mind_mate.git
cd mind_mate
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run
````

---

## 🖼️ Screenshots

> Replace these with real screenshots stored under `/screenshots/`

| Home Screen                   | Mood Tracker                  | Journal                             |
| ----------------------------- | ----------------------------- | ----------------------------------- |
| ![Home](screenshots/home.png) | ![Mood](screenshots/mood.png) | ![Journal](screenshots/journal.png) |

| Peer Chat                     | Meditation                                | Emergency                               |
| ----------------------------- | ----------------------------------------- | --------------------------------------- |
| ![Chat](screenshots/chat.png) | ![Meditation](screenshots/meditation.png) | ![Emergency](screenshots/emergency.png) |

---

## 📦 APK Build

> You can share this build for demo or evaluation purposes.

```bash
android/app/build/outputs/flutter-apk/app-debug.apk
```

📎 [Download APK](https://github.com/YourUsername/mind_mate/releases)

---

## ✅ Best Practices Followed

* ✅ Modular architecture (domain/data/presentation)
* ✅ Offline storage (Hive)
* ✅ Swipe to edit/delete (AnimatedList + Dismissible)
* ✅ Theming & dark mode
* ✅ Easy-to-maintain codebase
* ✅ Developer documentation (README)

---

## 🎯 Bonus Implementations

| Bonus Feature               | Status |
| --------------------------- | ------ |
| Swipe to Edit/Delete        | ✅ Done |
| Animated Dialogs & Feedback | ✅ Done |
| Hive HiveAdapter Setup      | ✅ Done |
| Dark Theme                  | ✅ Done |
| Chat Simulator              | ✅ Done |
| Meditation Timer with GIFs  | ✅ Done |
| Offline Functionality       | ✅ Done |

---

## 👨‍🎓 Student Information

* **Name**: NGABONZIZA Hugues
* **Student ID**: 26148
* **University**: Adventist University of Central Africa (AUCA)
* **Course**: Mobile Programming
* **Instructor**: *\[Insert Instructor's Name]*
* **Submission Date**: July 19, 2025

---

## 📜 License

This project is licensed under the MIT License.
Feel free to fork and customize for personal or educational use.

---

## 🙏 Final Notes

This project was developed with a focus on **clean architecture**, **usability**, and **offline support**, reflecting real-world mobile app standards. Every line of code has a purpose, and every feature is made to enhance mental wellness.

If you're a student, mentor, or just someone curious — thank you for checking out **Mind Mate**!

---

> *“Your mind is a garden. Your thoughts are the seeds. You can grow flowers or you can grow weeds.” 🌱*

```
```
