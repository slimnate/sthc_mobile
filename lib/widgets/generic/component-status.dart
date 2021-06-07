import 'package:flutter/material.dart';

class ComponentStatus extends StatelessWidget {
  final String name;
  final bool enabled;

  ComponentStatus({Key? key, this.enabled = false, required this.name})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          children: [
            buildIcon(),
            Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }

  Icon buildIcon() {
    return Icon(
      Icons.blur_circular,
      color: enabled ? Colors.green : Colors.red,
      size: 40,
      semanticLabel: 'Icon indicating atomizer status',
    );
  }
}
