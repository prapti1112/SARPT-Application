import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class WaterLevelDisplay extends StatefulWidget {
  double moisturePercentage;

  WaterLevelDisplay({this.moisturePercentage});

  @override
  _WaterLevelDisplayState createState() => _WaterLevelDisplayState();
}

class _WaterLevelDisplayState extends State<WaterLevelDisplay> {

  double waterLevel = 35, daysLeft;
  bool showParameters = false;

  @override
  void initState() {
    super.initState();
    /*
    * moisture = 100% => 20 days
    * moisture = x% => x * 0.2;
    */
    daysLeft = widget.moisturePercentage * 0.2;
    Timer(Duration(milliseconds: 700), () {
      setState(() => showParameters = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//           color: Colors.amber,
      margin: const EdgeInsets.only(top: 12.0),
      child: Center(
        child: Stack(
            children: [
                  CustomPaint(
                  size: Size(110.0, 150.0),
                  painter: DropPainter(),
                ),
              Positioned(
                top: 70,
                left: 15,
                child: AnimatedOpacity(
                  opacity: (showParameters) ? 1 : 0,
                  duration: Duration(milliseconds: 1500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30,
                          child: Text(widget.moisturePercentage.toString() + "%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )
                      ),
                      SizedBox(
                          height: 20,
                          child: Text(daysLeft.toString() + " days left", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
        ]),
      ),
    );
  }
}

class DropPainter extends CustomPainter {
  final waterLevel = 0.2;
  Paint _paint = Paint()..strokeWidth = 4.0;

  double min(double x, double y) {
    if (x < y)
      return x;
    else
      return y;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final dropRadius = min(size.width, size.height) / 2;

    print(size.width.toString() +
        " " +
        size.height.toString() +
        " " +
        dropRadius.toString());

    var circleRect = Offset(0, (size.height - 2 * dropRadius)) &
        Size(2 * dropRadius, 2 * dropRadius);

    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawArc(circleRect, pi, -pi, true, _paint);

    _paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Path dropBorderPath = Path()
      ..moveTo(size.width / 2, 0)
      ..arcTo(circleRect, -pi / 6, 4 * pi / 3, true)
      ..lineTo(size.width / 2, 0)
      ..close();

    canvas.drawPath(dropBorderPath, _paint);
  }

  @override
  bool shouldRepaint(DropPainter oldDelegate) {
    return false;
  }
}
