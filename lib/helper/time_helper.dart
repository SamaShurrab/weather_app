import 'package:intl/intl.dart';

class TimeHelper {
  String get dayName => DateFormat("EEE").format(DateTime.now());
  String get dayNameFull => DateFormat("EEEE").format(DateTime.now());
  int get dayNumber => DateTime.now().day;
  String get monthName => DateFormat("MMMM").format(DateTime.now());
  int get monthNumber => DateTime.now().month;
  int get year => DateTime.now().year;
  String get timePeriod => DateFormat("a").format(DateTime.now());
  String get currentDtTxt => buildCurrentDtTxt();

  String getDayName(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat("EEEE").format(date);
  } //getDayName()

  String getNearestTime() {
    List<int> timeInApi = [00, 03, 06, 09, 12, 15, 18, 21];
    int currentHour = DateTime.now().hour;
    for (int time in timeInApi) {
      if (currentHour <= time) return time.toString().padLeft(2, "0");
    }
    return timeInApi.first.toString().padLeft(2, "0");
  } //getNearestTime()

  String buildCurrentDtTxt() {
    return "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${getNearestTime()}:00:00";
  }
} //TimeHelper class
