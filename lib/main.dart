import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'widgets/time.dart';
import 'widgets/humidity.dart';
import 'widgets/lights.dart';

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
            '/': (context) => Homepage(routeIndex: 0),
            '/humidity': (context) => HumiditySettingsPage(routeIndex: 1),
            '/lights': (context) => LightSettingsPage(routeIndex: 2),
          },
        ));
  }
}

class RoutedListPage extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final int routeIndex;

  const RoutedListPage({
    Key? key,
    required this.title,
    required this.children,
    required this.routeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routeIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_rounded),
            label: "Humidity Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: "Light Settings",
          ),
        ],
        onTap: (index) => {switchToPage(context, index)},
      ),
    );
  }

  void switchToPage(BuildContext context, int index) {
    if (index == routeIndex) {
      return; // do nothing if the icon for this page was clicked.
    }
    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.settings.name == '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/humidity');
        break;
      case 2:
        Navigator.pushNamed(context, '/lights');
        break;
    }
  }
}

class Homepage extends StatelessWidget {
  final int routeIndex;
  const Homepage({
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
        //HumidityStatus(),
        HumiditySettingsEditor(),
      ],
    );
  }
}

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
