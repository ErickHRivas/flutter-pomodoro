import 'package:flutter/material.dart';

import 'package:pomodoro/controller/clock_controller.dart';
import 'package:pomodoro/utils/colors_utils.dart';

class ClockPage extends StatefulWidget {
  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  ClockController clockController = new ClockController();
  int btnSelect = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color__principal__1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * 0.6,
                      width: size.width,
                      child: Align(
                        alignment: Alignment(0.0, 0.5),
                        child: StreamBuilder(
                          initialData: clockController.getInitalClock(),
                          stream: clockController.streamControllerClockStream,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                fontSize: 80.0,
                                fontFamily: 'Fredericka the Great',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(Icons.replay_outlined),
                onPressed: () {
                  clockController.stopClock();
                  clockController.stopIconData();
                }),
            IconButton(icon: Icon(Icons.add_alert), onPressed: () => {})
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: StreamBuilder(
          stream: clockController.streamControllerIconDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) return Icon(snapshot.data);

            return Icon(clockController.getInitialIconData());
          },
        ),
        onPressed: () {
          clockController.getClock();
          clockController.getIconData();
        },
      ),
    );
  }
}
