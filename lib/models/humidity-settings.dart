import 'package:flutter/material.dart';

class HumiditySettingsModel extends ChangeNotifier {
  final double _target = 90;
  final double _kickOn = 80;
  final int _fanStop = 15;
  final int _updateInterval = 5;

  double get target => _target;
  double get kickOn => _kickOn;
  int get fanStop => _fanStop;
  int get updateInterval => _updateInterval;
}
