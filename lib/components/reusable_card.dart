import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {required this.colour, required this.cardChild, required this.onPress});

  final Color colour;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 7.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: colour,
//          gradient: LinearGradient(
//            colors: [Colors.blueGrey, colour],
//            begin: Alignment.topCenter,
//            end: Alignment.bottomCenter,
          // ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
