import 'package:flutter/material.dart';
import 'package:pomodoro/page/clock_page.dart';
import 'package:pomodoro/page/home_page.dart';

Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => HomePage(),
  'clock-page': (BuildContext context) => ClockPage(),
};
