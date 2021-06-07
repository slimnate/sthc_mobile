import 'package:flutter/material.dart';

class ServerTimeModel extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;
}
