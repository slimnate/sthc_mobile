// ==== This file contains all light time scheduling classes ====

enum ScheduleType { FIXED, MONTHLY }

// Represents a schedule entry, containing a day start and night start property
class ScheduleEntry {
  final DateTime dayStart;
  final DateTime nightStart;

  ScheduleEntry({
    required this.dayStart,
    required this.nightStart,
  });
}

// Abstract class representing a generic light schedule
abstract class LightSchedule {
  ScheduleEntry getEntry(DateTime date);
  List<ScheduleEntry> getEntries();
}

// Fixed implementation of abstract light schedule
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

// Monthly implementation of abstract light schedule
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
