import 'package:flutter/material.dart';
import 'constantes.dart';
import 'card_padrao.dart';
import 'botaoInferiorPadrao.dart';
import 'Inputs.dart';
import 'tela_principal.dart';

class Calculo {
  Calculo(this.chegouPint, this.mortalidade) {
    totAve = (chegouPint - mortalidade);
  }

  final int chegouPint;
  final int mortalidade;
  int totAve = 0;

  String ObterTotAve() {
    return totAve.toStringAsFixed(1);
  }
}
