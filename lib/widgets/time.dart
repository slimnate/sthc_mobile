import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sthc_mobile/widgets/titled_card.dart';
import '../models.dart';
import 'labeled_pair.dart';
import '../extensions.dart';

class ServerTimeCard extends StatelessWidget {
  const ServerTimeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var serverTimeData = context.watch<ServerTimeModel>().dateTime;

    var headingStyle = Theme.of(context).textTheme.headline6;

    return TitledColumnCard(title: "Server Time", children: [
      DualLabeledPairRow(
        data: [
          LabeledPair(
            key: "Date",
            value: serverTimeData.buildDateString(),
          ),
          LabeledPair(
            key: "Time",
            value: serverTimeData.buildPaddedTimeString(),
          ),
        ],
      ),
    ]);
  }
}
