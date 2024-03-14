import 'dart:async';

import 'package:flutter/material.dart';

import 'package:humancattranslate/core/res/colors.dart';

late Stopwatch stopwatch;

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  StopwatchWidgetState createState() => StopwatchWidgetState();
}

class StopwatchWidgetState extends State<StopwatchWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch()..start();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${stopwatch.elapsed.inMinutes}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
      style: appstyle(18, Colors.black, FontWeight.normal),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }
}
