import 'package:flutter/material.dart';

enum LightStatus { DAY, NIGHT }

class HumidityStatusModel extends ChangeNotifier {
  final double temperature = 85;
  final double humidity = 90;
  final bool atomizerEnabled = false;
  final bool fansEnabled = true;
}

class LightStatusModel extends ChangeNotifier {
  final LightStatus status = LightStatus.DAY;
  final DateTime dayStart = DateTime.now();
  final DateTime nightStart = DateTime.now().add(Duration(hours: 12));
}

class ServerTimeModel extends ChangeNotifier {
  final DateTime dateTime = DateTime.now();
}
