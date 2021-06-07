import 'package:flutter/material.dart';

import 'schedule.dart';

class LightScheduleModel extends ChangeNotifier {
  final ScheduleType type = ScheduleType.FIXED;
  final LightSchedule schedule = FixedSchedule(
    entry: ScheduleEntry(
      dayStart: DateTime.now(),
      nightStart: DateTime.now().add(
        Duration(hours: 12),
      ),
    ),
  );
}
