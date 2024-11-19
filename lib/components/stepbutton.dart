import 'package:flutter/material.dart';

class StepButton extends StatelessWidget {
  StepButton(
      {required this.icon,
      required this.onStepPress,
      required this.onPressEnd,
      required this.onStep});

  final VoidCallback onStepPress;
  final VoidCallback onPressEnd;
  final VoidCallback onStep;

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
              padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
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
                    borderRadius: BorderRadius.circular(17)),
                child: Icon(icon, size: buttonHeight - 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
