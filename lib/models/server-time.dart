import 'package:flutter/material.dart';
import 'package:sthc_mobile/extensions/extensions.dart';

class ServerTimeModel extends ChangeNotifier {
  /// private field backing [dateTime]
  DateTime _dateTime = DateTime.now();

  /// Get the current Date and Time of the remote web server
  DateTime get dateTime => _dateTime;

  /// Get a string representation of the current date (excluding time)
  String get dateString => _dateTime.buildDateString();

  /// Get a string representation of the current time (excluding date, padded
  /// to two digits per part)
  String get timeString => _dateTime.buildPaddedTimeString();

  /// Update current stored [dateTime] and notify listeners
  set dateTime(DateTime newDateTime) {
    _dateTime = newDateTime;
    notifyListeners();
  }
}
