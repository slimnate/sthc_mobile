import 'package:flutter/material.dart';

import '../generic/routed-list-page.dart';
import '../humidity.dart';

class HumiditySettingsPage extends StatelessWidget {
  final int routeIndex;

  const HumiditySettingsPage({
    Key? key,
    required this.routeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoutedListPage(
      title: "Humidity Settings",
      routeIndex: routeIndex,
      children: [
        HumidityStatus(),
        HumiditySettingsEditor(),
      ],
    );
  }
}
