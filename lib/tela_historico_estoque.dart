import 'package:flutter/material.dart';
import 'package:seara_app/funcoes.dart';
import 'package:seara_app/tela_dados.dart';
// ignore: unused_import
import 'constantes.dart';
import 'card_padrao.dart';
import 'botaoInferiorPadrao.dart';
import 'Inputs.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TelaHistoricoEstoque extends StatefulWidget {
  const TelaHistoricoEstoque({super.key});

  @override
  _TelaHistoricoEstoqueState createState() => _TelaHistoricoEstoqueState();
}

class _TelaHistoricoEstoqueState extends State<TelaHistoricoEstoque> {
  late Future<List<String>> _historicoFuture;

  @override
  void initState() {
    super.initState();
    _historicoFuture = _carregarHistorico();
  }

  Future<List<String>> _carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('historico_estoque') ?? [];
  }

  Future<void> _limparHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('historico_estoque');
    setState(() {
      _historicoFuture = _carregarHistorico(); // recarrega a lista vazia
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Estoques'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Limpar Histórico',
            onPressed: _limparHistorico,
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _historicoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final historico = snapshot.data ?? [];

          if (historico.isEmpty) {
            return const Center(child: Text('Nenhum registro de estoque.'));
          }

          return ListView.builder(
            itemCount: historico.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(historico[index]),
              );
            },
          );
        },
      ),
    );
  }
}

