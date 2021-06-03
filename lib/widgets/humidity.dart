import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sthc_mobile/widgets/titled_card.dart';
import '../models.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

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
