import 'package:flutter/material.dart';
import 'dart:math';

class HumidityDisplay extends StatefulWidget {
  double humidity;

  HumidityDisplay({this.humidity});

  @override
  _HumidityDisplayState createState() => _HumidityDisplayState();
}

class _HumidityDisplayState extends State<HumidityDisplay> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          TweenAnimationBuilder(
              duration: Duration(milliseconds: 2200),
              tween: Tween<double>(begin: 2 * pi, end: 0),
              builder: (BuildContext context, double showValue, Widget child) {
                return CustomPaint(
                  size: Size.infinite,
                  foregroundPainter: HumidityHider(sweepAngle: showValue),
                  child: Stack(children: [
                    Image.asset(
                      "assets/images/humidity.png",
                      scale: 3,
                    ),
                    Positioned(
                      top: 80,
                      left: 45,
                      child: Text(
                        "${widget.humidity.toInt()}%",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                );
              }),
        ],
      ),
    );
  }
}

class HumidityHider extends CustomPainter {
  double sweepAngle = 0;

  HumidityHider({this.sweepAngle});

  Paint _paint = Paint()
    ..strokeWidth = 4.0;
    // ..color = Colors.teal;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = 55;

    print(size.width.toString() +
        " " +
        size.height.toString() +
        " " +
        radius.toString());

    // canvas.drawRect(Offset(0,0) & Size(size.width, size.height) , _paint);
    var circleRect = Offset(-1, 0) & Size(size.width+2, size.height);

    _paint
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawArc(circleRect, 0, sweepAngle, true, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
