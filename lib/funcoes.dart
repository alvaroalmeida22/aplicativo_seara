import 'package:shared_preferences/shared_preferences.dart';
import 'tela_principal.dart';
import 'package:flutter/material.dart';

TextEditingController racaorecebidaController = TextEditingController();
TextEditingController mortalidadeController = TextEditingController();
TextEditingController avesAlojadasController = TextEditingController();
TextEditingController gadController = TextEditingController();

double gad = double.parse(gadController.text);
double racaoRecebida = double.tryParse(racaorecebidaController.text) ?? 0.0;
int avesAloj = int.parse(avesAlojadasController.text);
int mortalidade = int.parse(mortalidadeController.text);
int totAves = avesAloj - mortalidade;

void reset() {
  racaorecebidaController.text = "";
  mortalidadeController.text = "";
  avesAlojadasController.text = "";
  gadController.text = "";
}

//função para calcular e salvar o número de aves no lote
Future<int> totalAves(int totAves) async {
  final prefs = await SharedPreferences.getInstance();
  int avesVivas = prefs.getInt('Aves vivas') ?? 0;
  avesVivas += totAves;
  await prefs.setInt('Aves vivas', avesVivas);
  return avesVivas;
}

Future<double> consumoDiario(double gad) async {
  final prefs = await SharedPreferences.getInstance();
  int avesVivas = prefs.getInt('Aves vivas') ?? 0;

  double resultadoConsumoDiario = (gad * avesVivas) / 1000;
  return resultadoConsumoDiario;
}

Future<double> calculoEstoque(double gad, double racaoRecebida) async {
  final prefs = await SharedPreferences.getInstance();
  double estoque = prefs.getDouble('estoque atualizado') ?? 0;
  double consumo = await consumoDiario(gad);
  estoque += racaoRecebida - consumo;
  await prefs.setDouble('estoque atualizado', estoque);
  return estoque;
}

/* Future<void> salvarEstoque(double estoque) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('estoque_racao', estoque);
}  */

/* double estoqueAtual = 0.0;
void carregarEstoque() async {
  final prefs = await SharedPreferences.getInstance();
  estoqueAtual = prefs.getDouble('estoque') ?? 0.0;
}

Future<String> calcularNovoEstoque() async {
  final prefs = await SharedPreferences.getInstance();

  //Salvando o valor de aves alojadas na memória para calcular o
  await prefs.setInt('aves_alojadas', avesAloj);

  // Cálculo de aves vivas baseado em mortalidade acumulada
  //int avesIniciais = prefs.getInt('aves_iniciais') ?? 0;
  int mortalidadeAnterior = prefs.getInt('mortalidade_total') ?? 0;
  int novaMortalidadeTotal = mortalidadeAnterior + mortalidade.toInt();

  int totalAves = (prefs.getInt('aves_alojadas') ?? 0) - novaMortalidadeTotal;

  await prefs.setInt('mortalidade_total', novaMortalidadeTotal);
  await prefs.setInt('aves_vivas', totalAves);

  double consumoDiario = (gad * (prefs.getInt('avesAloj') ?? 0.0)) / 1000;

  estoqueAtual =
      (prefs.getDouble('estoque') ?? 0.0) + racaoRecebida - consumoDiario;

  await prefs.setDouble('estoque', estoqueAtual);

  return estoqueAtual.toStringAsFixed(2);
} */

Future<void> salvarEstoque(double valorEstoque) async {
  final prefs = await SharedPreferences.getInstance();

  // Salva o estoque atual
  await prefs.setDouble('estoque atualizado', valorEstoque);

  // Obter aves vivas do SharedPreferences
  final avesVivas = prefs.getInt('Aves vivas') ?? 0;

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
