import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/extensions.dart';
import '../models/all.dart';
import 'titled_card.dart';
import 'labeled_pair.dart';

class LightStatusWidget extends StatelessWidget {
  const LightStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightStatus = context.watch<LightStatusModel>();

    return TitledColumnCard(
      title: "Light Status",
      children: [
        DayNightDisplay(
          status: lightStatus.status,
        ),
        DualLabeledPairRow(
          data: [
            LabeledPair(
                key: "Day Start",
                value: lightStatus.dayStart.buildPaddedTimeString()),
            LabeledPair(
                key: "Night Start",
                value: lightStatus.nightStart.buildPaddedTimeString()),
          ],
        ),
      ],
    );
  }
}

class DayNightDisplay extends StatelessWidget {
  final LightStatus status;
  const DayNightDisplay({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildIcon(),
        Text(
          status == LightStatus.DAY ? "Day" : "Night",
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }

  Icon buildIcon() {
    return Icon(
      status == LightStatus.DAY ? Icons.wb_sunny : Icons.nightlight,
      size: 48,
      color: status == LightStatus.DAY ? Colors.yellow : Colors.grey.shade600,
    );
  }
}

// ==== LightScheduleEditor ====

class LightScheduleEditor extends StatefulWidget {
  LightScheduleEditor({Key? key}) : super(key: key);

  @override
  _LightScheduleEditorState createState() => _LightScheduleEditorState();
}

class _LightScheduleEditorState extends State<LightScheduleEditor> {
  ScheduleType? scheduleType;

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<LightScheduleModel>();
    var dropdownItems = buildDropdownValues(context);

    if (scheduleType == null) {
      scheduleType = settings.type;
    }

    return TitledColumnCard(
      title: "Update Light Schedule",
      children: [
        Table(
          columnWidths: {
            0: FractionColumnWidth(.5),
            1: FractionColumnWidth(.3)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text("Schedule Type: "),
                DropdownButton(
                  value: scheduleType,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 32,
                  elevation: 20,
                  style: TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  items: dropdownItems,
                  onChanged: (ScheduleType? t) {
                    setState(
                      () => scheduleType = t as ScheduleType,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        buildListEditor(scheduleType),
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () => {
              onUpdatePressed(context),
            },
            child: Text("Update Settings"),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<ScheduleType>> buildDropdownValues(
      BuildContext context) {
    return ScheduleType.values
        .map(
          (scheduleType) => DropdownMenuItem<ScheduleType>(
            value: scheduleType,
            child: Text(scheduleType
                .toString()
                .substring(scheduleType.toString().indexOf('.') + 1)),
          ),
        )
        .toList();
  }

  buildListEditor(ScheduleType? t) {
    if (t == ScheduleType.FIXED) {
      return FixedScheduleEditor();
    } else {
      return MonthlyScheduleEditor();
    }
  }

  void onUpdatePressed(BuildContext context) {}
}

abstract class AbstractScheduleProvider extends StatefulWidget {
  LightSchedule getLocalSchedule();
}

// ==== Fixed Schedule Editor ====

class FixedScheduleEditor extends StatefulWidget {
  FixedScheduleEditor({Key? key}) : super(key: key);

  @override
  _FixedScheduleEditorState createState() => _FixedScheduleEditorState();
}

class _FixedScheduleEditorState extends State<FixedScheduleEditor> {
  final dayStartCtrl = TextEditingController();
  final nightStartCtrl = TextEditingController();

  @override
  void dispose() {
    dayStartCtrl.dispose();
    nightStartCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<LightScheduleModel>();

    dayStartCtrl.text = settings.schedule
        .getEntry(DateTime.now())
        .dayStart
        .buildPaddedTimeString();
    nightStartCtrl.text = settings.schedule
        .getEntry(DateTime.now())
        .nightStart
        .buildPaddedTimeString();
    return Container(
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.25),
          1: FractionColumnWidth(.25),
          2: FractionColumnWidth(.25),
          3: FractionColumnWidth(.25),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              Text("Day Start:"),
              TextField(
                textAlign: TextAlign.left,
                controller: dayStartCtrl,
              ),
              Text("Night Start:"),
              TextField(
                textAlign: TextAlign.left,
                controller: nightStartCtrl,
              ),
            ],
          )
        ],
      ),
    );
  }

  LightSchedule getSchedule() {
    return FixedSchedule(
      entry: ScheduleEntry(
        dayStart: dayStartCtrl.text.parseTime(),
        nightStart: nightStartCtrl.text.parseTime(),
      ),
    );
  }
}

// ==== Monthly Schedule Editor ====

class MonthlyScheduleEditor extends StatefulWidget {
  MonthlyScheduleEditor({Key? key}) : super(key: key);

  @override
  _MonthlyScheduleEditorState createState() => _MonthlyScheduleEditorState();
}

class _MonthlyScheduleEditorState extends State<MonthlyScheduleEditor> {
  static const int CONTROLLER_COUNT = 12;
  final List<TextEditingController> dayStartCtrls = List.filled(
    CONTROLLER_COUNT,
    TextEditingController(),
  );
  final List<TextEditingController> nightStartCtrls = List.filled(
    CONTROLLER_COUNT,
    TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<LightScheduleModel>();

    fillControllerValues(settings.schedule);

    return Container(
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.25),
          1: FractionColumnWidth(.25),
          2: FractionColumnWidth(.25),
          3: FractionColumnWidth(.25),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: buildTableRows(),
      ),
    );
  }

  void fillControllerValues(LightSchedule schedule) {
    bool isMonthly = (schedule is MonthlySchedule);

    for (int i = 0; i < CONTROLLER_COUNT; i++) {
      //populate entries based on existing schedule type in model
      ScheduleEntry entry;
      if (isMonthly) {
        // populate individual entries if monthly schedule
        entry = schedule.getEntries()[i];
      } else {
        // populate entries with default otherwise
        entry = schedule.getEntry(DateTime.now());
      }

      print(entry);

      dayStartCtrls[i].text = entry.dayStart.buildPaddedTimeString();
      nightStartCtrls[i].text = entry.nightStart.buildPaddedTimeString();
    }
  }

  List<TableRow> buildTableRows() {
    List<TableRow> rows = List.empty(growable: true);
    for (int i = 0; i < CONTROLLER_COUNT; i++) {
      rows.add(
        TableRow(
          children: [
            Text("Day Start:"),
            TextField(
              textAlign: TextAlign.left,
              controller: dayStartCtrls[i],
            ),
            Text("Night Start:"),
            TextField(
              textAlign: TextAlign.left,
              controller: nightStartCtrls[i],
            ),
          ],
        ),
      );
    }
    return rows;
  }
}
