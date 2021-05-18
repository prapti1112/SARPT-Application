import 'dart:async';

import 'package:flutter/material.dart';

class PhMeter extends StatefulWidget {
  double ph;

  PhMeter({this.ph});

  @override
  _PhMeterState createState() => _PhMeterState();
}

class _PhMeterState extends State<PhMeter> {

  bool moveSlider = false;
  double width;

  @override
  void initState() {
    super.initState();
    // width = MediaQuery.of(context).size.width;
    Timer(Duration(milliseconds: 700), () {
      setState(() => moveSlider = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 8.0, bottom: 2.0),
      // color: Colors.teal,
      child: Stack(
        alignment: Alignment(0, 0),
        children: [
          Positioned(
              top: 8.0,
              bottom: 28.0,
              right: 6.0,
              left: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFAE113E), Color(0xFFCD0B23), Color(0xFFDA0E19), Color(0xFFED291D), Color(0xFFF24D1D),
                      Color(0xFFF18F2E), Color(0xFFE9CB35), Color(0xFF7ACC2A), Color(0xFF24C829), Color(0xFF388473),
                      Color(0xFF4C50BB), Color(0xFF252B9C), Color(0xFF071091), Color(0xFF031174), Color(0xFF071560),
                    ]
                  )
                ),
              ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
              top: 4.0,
              bottom: 24.0,
              left: (moveSlider) ? ((MediaQuery.of(context).size.width - 32) / 14) * widget.ph : (MediaQuery.of(context).size.width - 32) / 2,
              child: Container(
                width: 5.0,
                // margin: const EdgeInsets.only(bottom: 20.0),
                color: Colors.black,
              ),
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 1500),
              bottom: 4.0,
              left: (moveSlider) ? (((MediaQuery.of(context).size.width - 32) / 14) * widget.ph) - 10.0 : ((MediaQuery.of(context).size.width - 32) / 2) -10.0 ,
              child: Text((moveSlider) ? widget.ph.toString() : "7.0", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
          )
        ],
      ),
    );
  }
}
