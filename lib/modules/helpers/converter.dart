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
