import 'package:flutter/material.dart';
import 'dart:async';

class CountDownTimer extends StatefulWidget {
  final int initialTime;
  final double circleSize;
  final double textSize;
  final bool showCircle;

  CountDownTimer({
    required this.initialTime,
    this.circleSize = 100.0,
    this.textSize = 48.0,
    this.showCircle = true,
  });

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  late int _remainingTime;
  late double _progress;
  late Color _textColor;
  late Color _progressColor;

  @override
  void initState() {
    _remainingTime = widget.initialTime;
    _progress = 1.0;
    _textColor = Colors.black;
    _progressColor = Colors.black;
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;

          if (_remainingTime <= 10 && _remainingTime > 5) {
            _textColor = const Color(0xFFD9BC05);
            _progressColor = const Color(0xFFD9BC05);
          } else if (_remainingTime <= 5) {
            _textColor = const Color(0xFFC0021B);
            _progressColor = const Color(0xFFC0021B);
          }
          _progress = (_remainingTime / widget.initialTime);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textColor = Theme.of(context).colorScheme.primary;
    _progressColor = _textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          widget.showCircle
              ? SizedBox(
            width: widget.circleSize,
            height: widget.circleSize,
            child: CircularProgressIndicator(
              value: _progress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
            ),
          )
              : SizedBox(),
          Text(
            "$_remainingTime",
            style: TextStyle(
              color: _textColor,
              fontSize: widget.textSize,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
