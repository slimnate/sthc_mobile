import 'package:flutter/material.dart';

class TitledColumnCard extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const TitledColumnCard({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headingStyle = Theme.of(context).textTheme.headline6;

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: headingStyle,
            ),
            Divider(),
            ...children
          ],
        ),
      ),
    );
  }
}
