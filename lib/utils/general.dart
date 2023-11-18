bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

String beautifyTime(DateTime dateTime) {
  dateTime = dateTime.toLocal();
  DateTime now = DateTime.now();
  String amPm = dateTime.hour < 12 ? 'AM' : 'PM';
  int hour = dateTime.hour % 12;
  if (hour == 0 && amPm == "PM") hour = 12;
  String formattedTime =
      '$hour:${dateTime.minute.toString().padLeft(2, '0')} $amPm';
  // I know on 1st of month, yesterday's message will be shown with complete date, similarly with year
  if (dateTime.year == now.year && dateTime.month == now.month) {
    if (dateTime.day == now.day - 1) {
      return '$formattedTime, yesterday';
    }
    if (dateTime.day == now.day) {
      return formattedTime;
    }
  }

  String formattedDate =
      '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}';
  return '$formattedTime, $formattedDate';
}
