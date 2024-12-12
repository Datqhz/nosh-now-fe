# Nosh Now System

## Overview
This project have 2 application
- NoshNow: This app is an application to interact with user who is eater
- NoshNow Management: This app is a system to manage all of things being show on NoshNow

## Tech Stacks
- Programing language: Dart
- Framework: Flutter

## Getting Started
### Prerequesites
- Dart SDK
- Flutter SDK
- Your device and server connected to same network
### Installations
1. **Move to application project**
    - To build NoshNow app:
        ```
        cd nosh_now_application
        ```
    - To build NoshNow Management app:
        ```
        cd management_app
        ```
2. **Install all library/package**  
    - Clear all package was installed:  
        ```
        flutter clean
        ```
    - Run command in terminal to install all required package for app
        ```
        flutter pub get
        ```

3. **Config host to connect to Back-end server**
    - **Get host**:
    Go to `Settings` -->  `Network & Internet` --> Click `Properties` in current wifi connected (or some network) --> get `IPv4 Address`, this value is host to connect between app and server
    - **Set host for `GlobalVariable`**:  
    1. Open file GlobalVariable:  
    Find file with path `lib/core/constants/global_variable.dart`, and open it.  
    2. Set host:  
    Set your host your take from above
    ```dart
    class GlobalVariable {
        static String url = 'http://{host}:5235';
        static String hubUrl = 'http://{host}:5044';
        static String jwt = "";
        static String scope = "";
        static ProfileData? profile;
    }
    ```
4. **Build .apk file**  
    Run this command
    ```
    flutter build apk --release
    ```
    .apk file will be added with path: `build/app/outputs/flutter-apk/app-release.apk`

5. **Install app in your device**
Send your .apk file from `step 4` to your deviec and install it.

**Note**:  
Here is something you need to follow:
- Host: your host will be change when you connect to new network, or it will be changed automatic after a time. So, when this thing is happen, you need to do re-build from `step 3` to the end.
- App: 2 app have a same way to build and install, just different at `step 1`.
