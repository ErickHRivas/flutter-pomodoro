import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pomodoro/utils/icons_data_utils.dart';

class ClockController {
  int minutes = 25;
  int seconds = 0;
  Timer timer;
  bool isPlay = false;

  StreamController<String> _streamControllerClock =
      StreamController<String>.broadcast();
  Function(String) get streamControllerClockSink =>
      _streamControllerClock.sink.add;
  Stream<String> get streamControllerClockStream =>
      _streamControllerClock.stream;

  StreamController<IconData> _stremControllerIconData =
      StreamController<IconData>.broadcast();
  Function(IconData) get streamControllerIconDataSink =>
      _stremControllerIconData.sink.add;
  Stream<IconData> get streamControllerIconDataStream =>
      _stremControllerIconData.stream;

  String stringTime() {
    String secondsString = seconds.toString();
    String minutesString = minutes.toString();
    String secondsPrint =
        secondsString.length == 1 ? "0$secondsString" : secondsString;
    String minutesPrint =
        minutesString.length == 1 ? "0$minutesString" : minutesString;
    return "$minutesPrint:$secondsPrint";
  }

  void operationTime() {
    seconds--;
    if (seconds <= 0) {
      seconds = 59;
      minutes--;
      if (minutes < 0) {
        stopClock();
      }
    }
  }

  void getTime() {
    timer = Timer.periodic(
      new Duration(seconds: 1),
      (timer) {
        operationTime();
        streamControllerClockSink(stringTime());
      },
    );
  }

  void getIconData() {
    IconData iconSelect =
        !isPlay ? iconData['play_arrow_sharp'] : iconData['pause_rounded'];

    streamControllerIconDataSink(iconSelect);
  }

  void getClock() {
    isPlay = !isPlay;
    if (isPlay) {
      getTime();
    } else {
      timer.cancel();
    }
  }

  void stopClock() {
    minutes = 25;
    seconds = 0;
    streamControllerClockSink(stringTime());
    if (timer != null) {
      timer.cancel();
    }
  }

  void stopIconData() {
    isPlay = false;
    getIconData();
  }

  IconData getInitialIconData() => iconData['play_arrow_sharp'];
  String getInitalClock() => stringTime();
}
