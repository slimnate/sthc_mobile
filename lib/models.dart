import 'package:flutter/material.dart';

enum LightStatus { DAY, NIGHT }

class HumidityStatusModel extends ChangeNotifier {
  final double temperature = 85;
  final double humidity = 90;
  final bool atomizerEnabled = false;
  final bool fansEnabled = true;
}

class HumiditySettingsModel extends ChangeNotifier {
  final double target = 90;
  final double kickOn = 80;
  final int fanStop = 15;
  final int updateInterval = 5;
}

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

class ServerTimeModel extends ChangeNotifier {
  final DateTime dateTime = DateTime.now();
}

class ScheduleEntry {
  final DateTime dayStart;
  final DateTime nightStart;

  ScheduleEntry({
    required this.dayStart,
    required this.nightStart,
  });
}

// ==== Scheduling classess ====

enum ScheduleType { FIXED, MONTHLY }

abstract class LightSchedule {
  ScheduleEntry getEntry(DateTime date);
  List<ScheduleEntry> getEntries();
}

class FixedSchedule extends LightSchedule {
  ScheduleEntry entry;

  FixedSchedule({
    required this.entry,
  });

  ScheduleEntry getEntry(DateTime date) {
    return entry;
  }

  List<ScheduleEntry> getEntries() {
    return [entry];
  }
}

class MonthlySchedule extends LightSchedule {
  List<ScheduleEntry> entries;

  MonthlySchedule({
    required this.entries,
  });

  ScheduleEntry getEntry(DateTime date) {
    return entries[date.month - 1];
  }

  List<ScheduleEntry> getEntries() {
    return entries;
  }
}
