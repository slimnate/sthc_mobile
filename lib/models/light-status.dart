import 'package:flutter/material.dart';

import 'schedule.dart';

enum LightStatus { DAY, NIGHT }

class LightStatusModel extends ChangeNotifier {
  final LightStatus status = LightStatus.DAY;
  late DateTime dayStart;
  late DateTime nightStart;
  final LightSchedule schedule = FixedSchedule(
    entry: ScheduleEntry(
      dayStart: DateTime.now(),
      nightStart: DateTime.now().add(
        Duration(hours: 12),
      ),
    ),
  );

  LightStatusModel() {
    dayStart = schedule.getEntry(DateTime.now()).dayStart;
    nightStart = schedule.getEntry(DateTime.now()).nightStart;
  }
}
