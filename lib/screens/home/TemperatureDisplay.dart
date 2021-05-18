import 'package:flutter/material.dart';
import 'package:flutter_thermometer/thermometer.dart';

class ThermometerDisplay extends StatefulWidget {
  @override
  _ThermometerDisplayState createState() => _ThermometerDisplayState();
}

class _ThermometerDisplayState extends State<ThermometerDisplay> with TickerProviderStateMixin{

  double teperatureValue = 55;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        height: 150,
        width: 60,
        child: Center(
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 2200),
            tween: Tween<double>(begin: 0, end: teperatureValue),
            builder: (BuildContext context, double tempValue, Widget child) {
              return Thermometer(
                value: tempValue,
                minValue: 0,
                maxValue: 100,
                radius: 20.0,
                barWidth: 20.0,
                outlineThickness: 3.0,
                setpoint: Setpoint(38, size: 9, color: Colors.blue, side: SetpointSide.both),
                mercuryColor: (tempValue < 25) ? Colors.blue : (tempValue < 40) ? Colors.amber : Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }
}
