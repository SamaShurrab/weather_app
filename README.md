# My Weather 🌤️

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

-   Default Flutter icons\
-   App icon path:

```{=html}
<!-- -->
```
    assets/images/launcherIcon.png

### App Tools

-   flutter_launcher_icons\
-   rename

## 📂 Project Structure

    The project follows a clean and organized directory structure:
        ```plaintext
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

-   App requests location permission\
-   Enter your API key

### Search

-   Tap search icon\
-   Enter city

### Offline Mode

-   Shows last saved data

### Switch Units

-   Tap temperature

## 🎥 Application Demo

🎬 https://www.youtube.com/watch?v=STv2Aqc6vsU

## 📷 Screenshots

```{=html}
<table>
```
```{=html}
<tr>
```
```{=html}
<td align="center">
```
`<b>`{=html}splashScreen`</b>`{=html}`<br>`{=html}
`<img src="assets/screenShots/splashScreen.png" width="250">`{=html}
```{=html}
</td>
```
```{=html}
<td align="center">
```
`<b>`{=html}homeScreen`</b>`{=html}`<br>`{=html}
`<img src="assets/screenShots/homeScreen.png" width="250">`{=html}
```{=html}
</td>
```
```{=html}
</tr>
```
```{=html}
<tr>
```
```{=html}
<td align="center">
```
`<b>`{=html}searchScreen`</b>`{=html}`<br>`{=html}
`<img src="assets/screenShots/searchScreen.png" width="250">`{=html}
```{=html}
</td>
```
```{=html}
<td align="center">
```
`<b>`{=html}chooseCityScreen`</b>`{=html}`<br>`{=html}
`<img src="assets/screenShots/chooseCityScreen.png" width="250">`{=html}
```{=html}
</td>
```
```{=html}
</tr>
```
```{=html}
<tr>
```
```{=html}
<td align="center">
```
`<b>`{=html}changeTemp`</b>`{=html}`<br>`{=html}
`<img src="assets/screenShots/changeTemp.png" width="250">`{=html}
```{=html}
</td>
```
```{=html}
<td align="center">
```
`<b>`{=html}DayWeatherDetails`</b>`{=html}`<br>`{=html}
`<img src="assets/screenShots/DayWeatherDetails.png" width="250">`{=html}
```{=html}
</td>
```
```{=html}
</tr>
```
```{=html}
</table>
```
## 👤 Author

Sama Shurrab

## 📜 License

Open-source
