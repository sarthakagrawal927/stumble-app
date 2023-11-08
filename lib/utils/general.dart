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
  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    // If it's today, return "hh:mm AM/PM" format
    String formattedTime =
        '${dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')} $amPm';
    return formattedTime;
  } else if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day - 1) {
    // If it's yesterday, return "hh:mm AM/PM, yesterday" format
    String formattedTime =
        '${dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')} $amPm';
    return '$formattedTime, yesterday';
  } else {
    // For any other day, return "hh:mm AM/PM ddMM" format
    String formattedTime =
        '${dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')} $amPm';
    String formattedDate =
        '${dateTime.day.toString().padLeft(2, '0')}${dateTime.month.toString().padLeft(2, '0')}';
    return '$formattedTime $formattedDate';
  }
}
