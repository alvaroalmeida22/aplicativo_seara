import 'package:flutter/material.dart';

class CardPadrao extends StatelessWidget {
  CardPadrao({this.filhoCard});

  final Widget ?filhoCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0), color:  Colors.blue[50]),
      margin: const EdgeInsets.all(2.0),
      child: filhoCard,
    );
  }
}
