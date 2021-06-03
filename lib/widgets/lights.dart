import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sthc_mobile/widgets/titled_card.dart';
import '../models.dart';
import 'labeled_pair.dart';
import '../extensions.dart';

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
