import 'package:flutter/material.dart';

class StepButtonClose extends StatelessWidget {
  StepButtonClose(
      {required this.icon,
      @required this.onStepPress,
      this.onPressEnd,
      this.onStep});

  final GestureLongPressCallback? onStepPress;
  final GestureLongPressUpCallback? onPressEnd;
  final GestureTapCallback? onStep;

  final IconData icon;
  final double buttonWidth = 30.0;
  final double buttonHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onStepPress,
      onTap: onStep,
      onLongPressUp: onPressEnd,
      child: Container(
        // color: Colors.blue,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 5.0, 10.0),
              child: Container(
                alignment: Alignment.center,
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                  //color: Colors.blueGrey.shade700,
                  gradient: LinearGradient(
                    colors: [Colors.white54, Colors.white12],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, size: buttonHeight - 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
