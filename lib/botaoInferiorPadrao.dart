import 'package:flutter/material.dart';
import 'package:seara_app/tela_dados.dart';
import 'constantes.dart';

class BotaoInferiorPadrao extends StatelessWidget {
  const BotaoInferiorPadrao(
      {super.key, required this.textoInferior, });
  final String textoInferior;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: Container(
        // ignore: sort_child_properties_last
        child: Center(
          child: Text(
            textoInferior,
            style: kBotaoInferiorTelaPrincipal,
          ),
        ),
        color: const Color.fromRGBO(255, 102, 0, 2.0),
        margin: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 60.0,
      ),
    );
  }
}
