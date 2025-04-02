# firebase_getx_auth_crud

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Flutter Project Setup Guide

🚀 Getting Started

Follow these steps to set up and run the Flutter project.

📌 **Prerequisites**
-> Install Flutter SDK
->Install Android Studio

REQUIRED FLUTTER VERSION : 3.29


Check Flutter Version by running below Command:
-> flutter --version

Install dependencies Run Command:  
    -> flutter pub get

🛠️ **Setup Instructions**
git clone https://github.com/your-repo-name.git
cd your-project-folder

**Generate Firebase SHA Keys**
To generate SHA keys for Firebase authentication:

For Windows:
        keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android

For macOS/Linux:
        keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android


-> Send Your SHA-1 & SHA256 for check in debug

**Run the Project**

Run below Command:
-> flutter run

**Build APK**
For Build Apk run below command
-> flutter build apk --release



Assumptions :
Regarding the Country list I need to manage in single list from api and firebase I don't know so I made 2 different list and display.


If Phone number Login not working then try login with below credentials:

Mobile: +91 9712345678
OTP: 111111