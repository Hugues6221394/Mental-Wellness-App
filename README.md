# � Mind Mate – Mental Wellness Companion App  
**A Flutter-Based Offline Solution for Student Well-Being**  

Mind Mate is a **secure, offline-first mobile application** designed to support the mental wellness of university students. Built with Flutter and powered by **Hive** for local storage, it offers mood tracking, journaling, peer support, meditation tools, and emergency contacts—all without requiring an internet connection.  

---

## ✨ Key Features  

### **Core Functionalities**  
| Feature                | Description                                                                 | Tech Used          |  
|------------------------|-----------------------------------------------------------------------------|--------------------|  
| **🌱 Mood Tracker**    | Log, edit (swipe-right), or delete (swipe-left) daily moods with animations | `Hive` + `Dismissible` |  
| **📖 Secure Journal**  | Encrypted local journal entries with CRUD operations                        | `Hive` + `AES`     |  
| **💬 Peer Chat**       | Anonymous support chat (simulated; extendable to Firebase/AI)               | `Mock Service`     |  
| **🧘 Guided Meditation** | Timer with calming Lottie animations for breathing exercises               | `Lottie`           |  
| **🆘 Emergency Links** | One-tap access to university counseling/emergency contacts (hardcoded)      | `url_launcher`     |  

### **Technical Highlights**  
✅ **Offline-First Architecture**: All user data persists locally via Hive (NoSQL)  
✅ **Clean Architecture**: Separation of concerns (Domain/Data/Presentation)  
✅ **Responsive UI**: Dark/light theme support with adaptive widgets  
✅ **Interactive UX**: Swipe gestures, animated dialogs, and feedback  

---

## 🏗️ Project Structure (Modular Design)  
```bash
lib/
├── core/               # App-wide utilities
│   ├── theme/          # Material3 theming
│   └── constants/      # Routes, strings, etc.
├── data/               # Data layer
│   ├── models/         # Hive adapters
│   └── repositories/   # Local data sources
├── domain/             # Business logic
│   ├── entities/       # Pure Dart classes
│   └── use_cases/      # Feature-specific logic
└── presentation/       # UI layer
    ├── pages/          # Feature screens
    ├── widgets/        # Reusable components
    └── providers/      # State management
```

---

## ⚙️ Installation & Setup  

### **Prerequisites**  
- Flutter 3.3.0+  
- Dart 2.18+  
- Android Studio/VSCode with Flutter plugin  

### **Run Locally**  
```bash
git clone https://github.com/YourUsername/mind_mate.git
cd mind_mate
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs  # Generate Hive adapters
flutter run -d chrome  # For web testing (or use device/emulator)
```

---

## 📸 Application Screenshots  

| **Home Screen** | **Mood Tracker** | **Journal** |  
|-----------------|------------------|-------------|  
| ![Home](screenshots/home.png) | ![Mood](screenshots/mood.png) | ![Journal](screenshots/journal.png) |  

| **Peer Chat** | **Meditation** | **Emergency** |  
|--------------|----------------|---------------|  
| ![Chat](screenshots/chat.png) | ![Meditation](screenshots/meditation.png) | ![Emergency](screenshots/emergency.png) |  

*(Replace placeholders with actual screenshots in `/screenshots/`)*  

---

## 📦 Deployment  
### **Debug APK**  
```bash
flutter build apk --debug  # Output: build/app/outputs/flutter-apk/app-debug.apk
```  
🔗 **[Download APK](https://github.com/hugues6221394/Mental-Wellness-App/releases)**  

---

## ✅ Best Practices Implemented  
| Category               | Implementation Details                          |  
|------------------------|------------------------------------------------|  
| **Architecture**       | Clean Architecture + Repository Pattern        |  
| **State Management**   | Provider for scalable state                    |  
| **Performance**        | Hive for low-latency local storage             |  
| **Security**           | Journal encryption (AES)                       |  
| **Maintainability**    | Documented code + modular structure            |  

---

## 📜 Academic Submission Details  
- **Student**: NGABONZIZA Hugues  
- **ID**: 26148  
- **Institution**: Adventist University of Central Africa (AUCA)  
- **Course**: Mobile Programming  
- **Instructor**: Regis Safi 
- **Submission Date**: July 19, 2025  

---

## 🔐 License  
MIT License. Open-source for educational use.  

---  

## 🎯 Why This Project Stands Out  
1. **Real-World Relevance**: Addresses student mental health with offline accessibility.  
2. **Technical Rigor**: Adheres to industry standards (clean architecture, SOLID principles).  
3. **User-Centric Design**: Intuitive gestures, animations, and privacy-focused features.  

> *"Mental health is not a destination, but a process. It’s about how you drive, not where you’re going."* — Noam Shpancer  

---  
