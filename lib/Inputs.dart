import 'package:flutter/material.dart';

class InputsCard extends StatelessWidget {
  InputsCard({required this.desc,required this.edit});

  final String desc;
  TextEditingController edit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
          controller: edit,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(6.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        hintText: desc,
        hintStyle: TextStyle(
          color: Colors.blue,
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
      //iconColor: Colors.amber,
      //fillColor: Colors.black,
      //labelText: 'IDADE',
      //hintText: 'QUALQUER',
      //border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
    ));
  }
}
