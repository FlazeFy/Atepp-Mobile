String generateLastDate(List<String> val) {
  List<DateTime> dates = val.map((dt) => DateTime.parse(dt)).toList();
  DateTime now = DateTime.now();
  DateTime maxDate = dates
      .reduce((value, element) => value.isAfter(element) ? value : element);
  DateTime today = DateTime(now.year, now.month, now.day);

  Duration difference = today.difference(maxDate);
  int diff = difference.inDays;

  String res = 'undefined';
  if (diff == 0) {
    res = 'Today';
  } else if (diff == 1) {
    res = 'Yesterday';
  } else if (diff <= 7) {
    res = '$diff days ago';
  } else {
    res = '${maxDate.day}/${maxDate.month}/${maxDate.year}';
  }

  return res;
}

getDateToContext(DateTime datetime, String type) {
  if (datetime != null) {
    DateTime result = DateTime.parse(datetime.toString());

    if (type == "full") {
      DateTime now = DateTime.now();
      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      DateTime tomorrow = DateTime.now().add(Duration(days: 1));

      if (result.toLocal().toIso8601String().substring(0, 10) ==
          now.toLocal().toIso8601String().substring(0, 10)) {
        return "Today at ${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
      } else if (result.toLocal().toIso8601String().substring(0, 10) ==
          yesterday.toLocal().toIso8601String().substring(0, 10)) {
        return "Yesterday at ${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
      } else if (result.toLocal().toIso8601String().substring(0, 10) ==
          tomorrow.toLocal().toIso8601String().substring(0, 10)) {
        return "Tomorrow at ${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
      } else {
        return "${result.year.toString()}/${result.month.toString().padLeft(2, '0')}/${result.day.toString().padLeft(2, '0')} ${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
      }
    } else if (type == "24h" || type == "12h") {
      return "${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
    } else if (type == "datetime") {
      return "${result.year.toString()}/${result.month.toString().padLeft(2, '0')}/${result.day.toString().padLeft(2, '0')} ${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
    } else if (type == "date") {
      return "${result.year.toString()}-${result.month.toString().padLeft(2, '0')}-${result.day.toString().padLeft(2, '0')}";
    } else if (type == "calendar") {
      DateTime result = DateTime.parse(datetime.toString());
      int offsetHours = getUTCHourOffset();
      result = result.add(Duration(hours: offsetHours));

      return "${result.year.toString()}-${result.month.toString().padLeft(2, '0')}-${result.day.toString().padLeft(2, '0')} ${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}:00";
    }
  } else {
    return "-";
  }
}

int getUTCHourOffset() {
  DateTime now = DateTime.now();
  return now.timeZoneOffset.inHours;
}
