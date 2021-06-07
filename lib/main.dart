import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'widgets/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HumidityStatusModel>(
            create: (context) => HumidityStatusModel(),
          ),
          ChangeNotifierProvider<HumiditySettingsModel>(
            create: (context) => HumiditySettingsModel(),
          ),
          ChangeNotifierProvider<ServerTimeModel>(
            create: (context) => ServerTimeModel(),
          ),
          ChangeNotifierProvider<LightStatusModel>(
            create: (context) => LightStatusModel(),
          ),
          ChangeNotifierProvider<LightScheduleModel>(
            create: (context) => LightScheduleModel(),
          ),
        ],
        child: MaterialApp(
          title: 'HumidityController',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(routeIndex: 0),
            '/humidity': (context) => HumiditySettingsPage(routeIndex: 1),
            '/lights': (context) => LightSettingsPage(routeIndex: 2),
          },
        ));
  }
}
