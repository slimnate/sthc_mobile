import 'package:flutter/material.dart';

import '../generic/routed-list-page.dart';
import '../lights.dart';

class LightSettingsPage extends StatelessWidget {
  final int routeIndex;

  const LightSettingsPage({
    Key? key,
    required this.routeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoutedListPage(
      title: "Light Schedule",
      routeIndex: routeIndex,
      children: [
        LightScheduleEditor(),
      ],
    );
  }
}
