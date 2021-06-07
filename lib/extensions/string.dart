extension TimeBuilder on String {
  DateTime parseTime() {
    return DateTime.parse("19700101 " + this.trim());
  }
}
