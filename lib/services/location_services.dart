import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/helper/local_storage_data.dart';
import 'package:weather_app/model/user_location.dart';

class LocationServices {
  static Future<UserLocation?> getCurrentLocation() async {
    try {
      print('التحقق من خدمة الموقع...');
      // Check to location service
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        print('خدمة الموقع غير مفعلة');
        throw Exception(AppStrings.locationNotEnabled);
      }

      // check to permissions
      print(' التحقق من الصلاحيات...');
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        print('طلب الصلاحيات...');
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print(' تم رفض الصلاحيات');
          throw Exception(AppStrings.permissionDeniad);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        print('الصلاحيات مرفوضة نهائياً');
        throw Exception(AppStrings.permissionDeniadForEver);
      }
      // get user Coordinates (latitude,longitude)
      print('جاري جلب الإحداثيات...');
      Position userPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.medium),
      );
      print(
        'تم جلب الإحداثيات: ${userPosition.latitude}, ${userPosition.longitude}',
      );

      UserLocation userLocation = UserLocation(
        latitude: userPosition.latitude,
        longitude: userPosition.longitude,
      );
      print('جاري حفظ الموقع...');
      LocalStorageData.saveUserLocation(userLocation);
      print('تم حفظ الموقع');

      return userLocation;
    } catch (error) {
      print(' خطأ في getCurrentLocation: $error');
      print('محاولة جلب الموقع المخزن...');

      UserLocation? userLocationOffline =
          await LocalStorageData.getUserLocation();
      if (userLocationOffline != null) {
        print('تم استخدام الموقع المخزن: $userLocationOffline');

        return userLocationOffline;
      }
      print(' لا يوجد موقع مخزن');

      throw Exception("${AppStrings.locationError}:$error");
    }
  }
}
