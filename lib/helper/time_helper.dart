import 'package:intl/intl.dart';

class TimeHelper {
  String dayName = DateFormat("EEE").format(DateTime.now());
  String dayNameFull = DateFormat("EEEE").format(DateTime.now());
  int dayNumber = DateTime.now().day;
  String monthName = DateFormat("MMMM").format(DateTime.now());
  int monthNumber = DateTime.now().month;
  int year = DateTime.now().year;
  String timePeriod = DateFormat("a").format(DateTime.now());
  String currentDtTxt = "";
  int currentHour = 0;

  String getDayName(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat("EEEE").format(date);
  } //getDayName()

  String getNearestTime() {
    List<int> timeInApi = [00, 03, 06, 09, 12, 15, 18, 21];
    currentHour = int.parse(DateFormat("HH").format(DateTime.now()));
    for (int i = 0; i < timeInApi.length; i++) {
      if (i == timeInApi.length - 1) {
        currentHour = timeInApi[0];
        break;
      }
      if (currentHour > timeInApi[i] && currentHour <= timeInApi[i + 1]) {
        currentHour = timeInApi[i + 1];
        break;
      }

      //if()
    } //for()
    return currentHour.toString().padLeft(2, "0");
  } //getNearestTime()

  String buildCurrentDtTxt() {
    currentDtTxt =
        "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${getNearestTime()}:00:00";
    return currentDtTxt;
  }
} //TimeHelper class
