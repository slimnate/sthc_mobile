import 'package:flutter/material.dart';

import '../generic/routed-list-page.dart';
import '../humidity.dart';
import '../lights.dart';
import '../server-time.dart';

class HomePage extends StatelessWidget {
  final int routeIndex;
  const HomePage({
    Key? key,
    required this.routeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoutedListPage(
      title: "Home",
      routeIndex: routeIndex,
      children: [
        ServerTimeCard(),
        HumidityStatus(),
        LightStatusWidget(),
      ],
    );
  }
}
