import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class CurrentTime extends StatelessWidget {
  const CurrentTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFF051C4B),
            width: 1,
          )
      ),
      child: DigitalClock(
        is24HourTimeFormat: false,
        digitAnimationStyle: Curves.bounceIn,
        amPmDigitTextStyle: const TextStyle(
          color: Color(0xFFFF5630),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        areaDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        hourMinuteDigitTextStyle: const TextStyle(
          color: Color(0xFF051C4B),
          fontSize: 35,
          fontWeight: FontWeight.bold,

        ),
        showSecondsDigit : true,
        areaWidth : 180.0,
      ),
    );
  }
}
