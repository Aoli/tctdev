import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;
  final double buttonWidth = 24.0;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon, size: buttonWidth - 10.0),
      onPressed: onPressed,
      elevation: 4.0,
      constraints: BoxConstraints.tightFor(
        width: buttonWidth,
        height: buttonWidth,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
