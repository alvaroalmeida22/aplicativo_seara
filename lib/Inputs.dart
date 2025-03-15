import 'package:flutter/material.dart';

class InputsCard extends StatelessWidget {
  InputsCard({
    required this.desc,
    required this.edit,
    required this.validato,
  });

  final String desc;
  final TextEditingController edit;
  final String? Function(String?)? validato;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validato,
        controller: edit,
        decoration: InputDecoration(
          hintText: desc,
          filled: true,
          labelText: desc,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}









/*TextField(
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
    )
    */