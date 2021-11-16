import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  double oneMinute = 60;
  Timer _timer;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (oneMinute == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            oneMinute--;
          });
        }
      },
    );
  }

  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        oneMinute > 0
            ? SizedBox(
                height: 40,
                width: 224,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'je n\'ai pas reçu le code ($oneMinute)',
                    style: TextStyle(
                      color: Color(0xff9C9C9C),
                      fontSize: 14,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(
                        0xffEEEEEE,
                      ),
                    ),
                  ),
                ))
            : SizedBox(
                height: 40,
                width: 210,
                child: TextButton(
                  onPressed: () {
                    oneMinute = 60;
                    setState(() {
                      startTimer();
                    });
                  },
                  child: Text(
                    'je n\'ai pas reçu le code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(
                        0xffFFC529,
                      ),
                    ),
                  ),
                )),
      ],
    );
  }
}
