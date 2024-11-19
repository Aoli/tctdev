import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  SquareIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;
  final double buttonWidth = 35.0;
  final double buttonHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon, size: buttonHeight - 7.0),
      onPressed: onPressed,
      elevation: 3.0,
      //padding: EdgeInsets.all(10.0),
      constraints: BoxConstraints.tightFor(
        width: buttonWidth,
        height: buttonHeight,

      ),
      shape: StadiumBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
