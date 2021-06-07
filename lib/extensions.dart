extension StringBuilder on DateTime {
  String buildDateString() {
    String year = this.year.toString();
    String month = this.month.toString();
    String day = this.day.toString();

    return month + "/" + day + "/" + year;
  }

  String buildPaddedTimeString() {
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String second = this.second.toString().padLeft(2, '0');

    return hour + ":" + minute + ":" + second;
  }
}

extension TimeBuilder on String {
  DateTime parseTime() {
    return DateTime.parse("19700101 " + this.trim());
  }
}
