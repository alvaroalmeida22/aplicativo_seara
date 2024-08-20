import 'package:flutter/material.dart';
import 'package:seara_app/tela_dados.dart';
import 'constantes.dart';

class BotaoInferiorPadrao extends StatelessWidget {
  BotaoInferiorPadrao({required this.textoInferior});
  final String textoInferior;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => TelaDados()));
      },
      child: Container(
        // ignore: sort_child_properties_last
        child: Center(
          child: Text(
            textoInferior,
            style: kBotaoInferiorTelaPrincipal,
          ),
        ),
        color: Color.fromRGBO(255, 102, 0, 2.0),
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 60.0,
      ),
    );
  }
}
