# My Weather 🌤️

![Flutter](https://img.shields.io/badge/Flutter-3.16-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.5-blue?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
![Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![Stars](https://img.shields.io/github/stars/SamaShurrab/weather_app?style=social)

---

## 📚 Table of Contents
- [🎯 Project Introduction](#-project-introduction)
- [📱 Features](#-features)
- [🛠️ Technologies Used](#️-technologies-used)
- [📂 Project Structure](#-project-structure)
- [🚀 Usage](#-usage)
- [🎨 App Launcher Icon](#-app-launcher-icon)
- [🎥 Application Demo](#-application-demo)
- [📱 Screenshots](#-application-screens)
- [📦 Installation](#-installation-for-developers)
- [⚙️ Configuration](#️-setup--configuration)
- [🤝 Contributing](#-contributing)
- [🐛 Reporting Issues](#-reporting-issues)
- [📞 Contact](#-contact--support)
- [⭐ Support](#-supporting-the-project)

---

## 🎯 Project Introduction
A Flutter weather application that displays current weather conditions
and 5-day forecasts, supports offline mode, and provides an elegant and
simple user experience.

## 📱 Features

-   🌍 Search weather for any city worldwide
-   📍 Automatic location detection using GPS
-   🌡️ Temperature display (°C / °F)
-   💨 Humidity and wind speed details
-   ☀️ Dynamic weather icons based on current conditions
-   📅 5-day weather forecast
-   💾 Offline support using locally stored data
-   🔍 City search with a built-in picker
-   🎨 Clean, simple, user-friendly UI

📋 System Requirements:

    - Android: 6.0 (Marshmallow) or higher
    -Internet: Required for weather data updates
    -Location: GPS service (optional)
    -Storage: 50MB free space

## 🛠️ Technologies Used

### Frontend

-   Flutter 3.16
-   Dart 3.0

### HTTP Client

-   http package

### API

    https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={long}&appid={apiKey}&units={unit}

### Location Services

-   geolocator
-   geocoding

### UI Components

-   uni_country_city_picker

### Date Formatting

-   intl

### Local Storage

-   shared_preferences

### Network Status

-   connectivity_plus

### Icons

-   Default Flutter icons

### App Tools

-   flutter_launcher_icons
-   rename


## 📂 Project Structure

    The project follows a clean and organized directory structure:
        ```
        assets
        ├─ fonts
        └─ images

        build
        └─ <build files>

        lib
        ├─ constant/
        ├─ helper/
        ├─ model/
        ├─ customWidget/
        ├─ services/
        ├─ screens/
        └─ main.dart

        test
        └─ widget_test.dart
        ```

## 🚀 Usage

### First Launch

-   App requests location permission
-   Enter your API key

### Search

-   Tap search icon
-   Enter city

### Offline Mode

-   Shows last saved data

### Switch Units

-   Tap temperature
  
## 🎨 App Launcher Icon

<div align="center"> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/images/launcherIcon.png?raw=true" width="200" alt="My Weather App Icon"> </div>

## 🎥 Application Demo

🎬 https://www.youtube.com/watch?v=STv2Aqc6vsU

## 📱 Application Screens

Splash & Home & Day Weather Details Screens
<p float="left"> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/screenShots/splashScreen.png?raw=true" width="30%" alt="Splash Screen" /> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/screenShots/homeScreen.png?raw=true" width="30%" alt="Home Screen" /> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/screenShots/DayWeatherDetails.png?raw=true" width="30%" alt="Weather Details" /> </p>

Search & City Selection & Change Temperature
<p float="left"> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/screenShots/searchScreen.png?raw=true" width="30%" alt="Search Screen" /> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/screenShots/chooseCityScreen.png?raw=true" width="30%" alt="City Selection" /> <img src="https://github.com/SamaShurrab/weather_app/blob/main/assets/screenShots/changeTemp.png?raw=true" width="30%" alt="Temperature Settings" /> </p>

## 📦 APK Download

Download the latest version of **My Weather** from GitHub Releases:

👉 [Download Latest APK](https://github.com/SamaShurrab/Modern-Quiz-App-Ui/releases/latest)

## 🐛 Reporting Issues

If you find a bug or have a suggestion:
    1. Search Issues first
    2. If not found, create a new Issue
    3. Include:
        - Problem description
        - Reproduction steps
        - Screenshot if possible
        - App version

## 📜 License

Open-source

## 📞 Contact & Support

Developer: Sama Abdallah Shurrab
Email: smshorap@gmail.com

## 🙏 Acknowledgements

- OpenWeatherMap - For the great free API
- Flutter Team - For the excellent framework
- Contributors - For their valuable efforts
- Users - For their trust and support

## ⭐ Supporting the Project

### If you like the project:
- ⭐ Give it a star on GitHub
- 🔄 Share it with friends
- 🐛 Help find bugs
- 💻 Contribute to development
    
## Developed with ❤️ by Sama Shurrab
