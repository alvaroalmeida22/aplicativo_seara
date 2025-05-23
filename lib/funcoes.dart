import 'package:shared_preferences/shared_preferences.dart';
import 'tela_principal.dart';
import 'package:flutter/material.dart';

TextEditingController racaorecebidaController = TextEditingController();
TextEditingController mortalidadeController = TextEditingController();
TextEditingController avesAlojadasController = TextEditingController();
TextEditingController gadController = TextEditingController();

void reset() {
  racaorecebidaController.text = "";
  mortalidadeController.text = "";
  avesAlojadasController.text = "";
  gadController.text = "";
}

String consumoDiario() {
  double gad = double.parse(gadController.text);
  double avesAloj = double.parse(avesAlojadasController.text);
  double mortalidade = double.parse(mortalidadeController.text);
  double totAves = avesAloj - mortalidade;
  double resultadoConsumoDiario = (gad * totAves) / 1000;
  return resultadoConsumoDiario.toStringAsFixed(2);
}

/* Future<void> salvarEstoque(double estoque) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('estoque_racao', estoque);
} */

double estoqueAtual = 0.0;
void carregarEstoque() async {
  final prefs = await SharedPreferences.getInstance();
  estoqueAtual = prefs.getDouble('estoque') ?? 0.0;
}

Future<String> calcularNovoEstoque() async {
  final prefs = await SharedPreferences.getInstance();

  double racaoRecebida = double.tryParse(racaorecebidaController.text) ?? 0.0;
  double gad = double.tryParse(gadController.text) ?? 0.0;
  double mortalidade = double.tryParse(mortalidadeController.text) ?? 0.0;

  // Cálculo de aves vivas baseado em mortalidade acumulada
  int avesIniciais = prefs.getInt('aves_iniciais') ?? 0;
  int mortalidadeAnterior = prefs.getInt('mortalidade_total') ?? 0;
  int novaMortalidadeTotal = mortalidadeAnterior + mortalidade.toInt();

  int totalAves = avesIniciais - novaMortalidadeTotal;

  await prefs.setInt('mortalidade_total', novaMortalidadeTotal);
  await prefs.setInt('aves_vivas', totalAves);

  double consumoDiario = (gad * totalAves) / 1000;

  estoqueAtual = (prefs.getDouble('estoque') ?? 0.0) + racaoRecebida - consumoDiario;

  await prefs.setDouble('estoque', estoqueAtual);

  return estoqueAtual.toStringAsFixed(2);
}




Future<void> salvarEstoque(double valorEstoque) async {
  final prefs = await SharedPreferences.getInstance();

  // Salva o estoque atual
  await prefs.setDouble('estoque', valorEstoque);

  // Obter aves vivas do SharedPreferences
  final avesVivas = prefs.getInt('aves_vivas') ?? 0;

  // Obtém a data e hora atual
  final now = DateTime.now();

  final dataFormatada = '${now.day.toString().padLeft(2, '0')}/'
      '${now.month.toString().padLeft(2, '0')}/'
      '${now.year} '
      '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}';

  // Monta a linha do histórico
  // Atualizar entrada do histórico
  final entradaHistorico =
      '$dataFormatada - Estoque: ${valorEstoque.toStringAsFixed(2)} kg - Aves vivas: $avesVivas';

  // Recupera histórico existente
  List<String> historico = prefs.getStringList('historico_estoque') ?? [];

  // Adiciona nova entrada no início
  historico.insert(0, entradaHistorico);

  // Salva o histórico de volta
  await prefs.setStringList('historico_estoque', historico);
}


Future<void> iniciarNovoLote(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setDouble('estoque', 0.0);
  await prefs.setInt('mortalidade_total', 0);

  // Limpar histórico, se quiser
  await prefs.setStringList('historico_estoque', []);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Novo lote iniciado! Todos os dados foram resetados.'),
    ),
  );
}


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
