import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/extensions.dart';
import '../models/server-time.dart';
import 'labeled_pair.dart';
import 'titled_card.dart';

class ServerTimeCard extends StatelessWidget {
  const ServerTimeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var serverTimeData = context.watch<ServerTimeModel>().dateTime;

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
