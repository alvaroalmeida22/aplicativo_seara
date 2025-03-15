import 'package:flutter/material.dart';

class CardPadrao extends StatelessWidget {
  CardPadrao({this.filhoCard});

  final Widget? filhoCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 150,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3.0), color: Color(0xFF8D8E98)),
      margin: const EdgeInsets.all(10.0),
      child: filhoCard,
    );
  }
}
