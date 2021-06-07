import 'package:flutter/material.dart';

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
        // pop routes instead of pushing when navigating to home page
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
