import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../models/models.dart';
import 'titled_card.dart';

class HumidityStatus extends StatelessWidget {
  const HumidityStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var humidityStatus = context.watch<HumidityStatusModel>();

    return TitledColumnCard(title: "Climate Status", children: [
      Row(
        children: [
          TemperatureWidget(
            temperature: humidityStatus.temperature,
          ),
          HumidityWidget(
            humidity: humidityStatus.humidity,
          ),
        ],
      ),
      Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          children: [
            ComponentStatus(
              name: "Atomizer",
              enabled: humidityStatus.atomizerEnabled,
            ),
            ComponentStatus(
              name: "Fans",
              enabled: humidityStatus.fansEnabled,
            ),
          ],
        ),
      ),
    ]);
  }
}

class ComponentStatus extends StatelessWidget {
  final String name;
  final bool enabled;

  ComponentStatus({Key? key, this.enabled = false, required this.name})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          children: [
            buildIcon(),
            Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }

  Icon buildIcon() {
    return Icon(
      Icons.blur_circular,
      color: enabled ? Colors.green : Colors.red,
      size: 40,
      semanticLabel: 'Icon indicating atomizer status',
    );
  }
}

class TemperatureWidget extends StatelessWidget {
  final double temperature;

  const TemperatureWidget({
    Key? key,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 120,
              child: buildProgressBar(),
            ),
            Column(
              children: [
                buildLabel(context),
                buildValue(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  FAProgressBar buildProgressBar() {
    return FAProgressBar(
      border: Border.all(color: Colors.black),
      direction: Axis.vertical,
      verticalDirection: VerticalDirection.up,
      maxValue: 100,
      currentValue: temperature.toInt(),
      displayText: '°F',
    );
  }

  Text buildLabel(BuildContext context) {
    return Text(
      "Temperature:",
      style: Theme.of(context).textTheme.caption,
    );
  }

  Text buildValue(BuildContext context) {
    return Text(
      temperature.toStringAsFixed(1) + '°F',
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class HumidityWidget extends StatelessWidget {
  final double humidity;

  const HumidityWidget({
    Key? key,
    required this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 120,
              child: buildProgressBar(),
            ),
            Column(
              children: [
                buildLabel(context),
                buildValue(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  FAProgressBar buildProgressBar() {
    return FAProgressBar(
      border: Border.all(color: Colors.black),
      progressColor: Colors.blue,
      direction: Axis.vertical,
      verticalDirection: VerticalDirection.up,
      maxValue: 100,
      currentValue: humidity.toInt(),
      displayText: '%',
    );
  }

  Text buildLabel(BuildContext context) {
    return Text(
      "Humidity:",
      style: Theme.of(context).textTheme.caption,
    );
  }

  Text buildValue(BuildContext context) {
    return Text(
      humidity.toStringAsFixed(1) + "%",
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class HumiditySettingsEditor extends StatefulWidget {
  HumiditySettingsEditor({Key? key}) : super(key: key);

  @override
  _HumiditySettingsEditorState createState() => _HumiditySettingsEditorState();
}

class _HumiditySettingsEditorState extends State<HumiditySettingsEditor> {
  final targetCtrl = TextEditingController();
  final kickOnCtrl = TextEditingController();
  final fanStopCtrl = TextEditingController();
  final updateCtrl = TextEditingController();

  @override
  void dispose() {
    targetCtrl.dispose();
    kickOnCtrl.dispose();
    fanStopCtrl.dispose();
    updateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<HumiditySettingsModel>();

    targetCtrl.text = settings.target.toStringAsFixed(1);
    kickOnCtrl.text = settings.kickOn.toStringAsFixed(1);
    fanStopCtrl.text = settings.fanStop.toString();
    updateCtrl.text = settings.updateInterval.toString();

    return TitledColumnCard(
      title: "Update Humidity Settings",
      children: [
        Table(
          columnWidths: {
            0: FractionColumnWidth(.5),
            1: FractionColumnWidth(.4),
            2: FractionColumnWidth(.1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            buildFormRow("Target Humidity:", targetCtrl, '%'),
            buildFormRow("Kick-On Humidity:", kickOnCtrl, '%'),
            buildFormRow("Fan Stop Delay:", fanStopCtrl, 's'),
            buildFormRow("Update Interval:", updateCtrl, 's'),
          ],
        ),
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

  void onUpdatePressed(BuildContext context) {
    var settings = Provider.of<HumiditySettingsModel>(context, listen: false);

    double target = double.parse(targetCtrl.text);
    double kickOn = double.parse(kickOnCtrl.text);
    int fanStop = int.parse(fanStopCtrl.text);
    int update = int.parse(updateCtrl.text);

    //TODO: Update model
  }

  TableRow buildFormRow(
      String label, TextEditingController ctrl, String postLabel) {
    return TableRow(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        TextField(
          textAlign: TextAlign.end,
          controller: ctrl,
        ),
        Text(
          postLabel,
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
