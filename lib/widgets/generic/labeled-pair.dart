import 'package:flutter/material.dart';

class LabeledPair {
  final String key, value;

  const LabeledPair({
    required this.key,
    required this.value,
  });
}

class LabeledValue extends StatelessWidget {
  final LabeledPair data;

  const LabeledValue({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var keyStyle = Theme.of(context).textTheme.caption;
    var valueStyle = Theme.of(context).textTheme.headline5;

    return Container(
      child: Expanded(
        child: Column(
          children: [
            Text(data.key, style: keyStyle),
            Text(
              data.value,
              style: valueStyle,
            )
          ],
        ),
      ),
    );
  }
}

class DualLabeledPairRow extends StatelessWidget {
  final List<LabeledPair> data;
  const DualLabeledPairRow({
    Key? key,
    required this.data,
  })  : assert(data.length == 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LabeledValue(
          data: data[0],
        ),
        LabeledValue(
          data: data[1],
        ),
      ],
    );
  }
}
