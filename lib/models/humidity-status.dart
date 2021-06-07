import 'package:flutter/material.dart';

class HumidityStatusModel extends ChangeNotifier {
  double _temperature = 85;
  double _humidity = 90;
  bool _atomizerEnabled = false;
  bool _fansEnabled = true;

  double get temperature => _temperature;
  double get humidity => _humidity;
  bool get atomizerEnabled => _atomizerEnabled;
  bool get fansEnabled => _fansEnabled;
}
