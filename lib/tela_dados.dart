import 'package:flutter/material.dart';
import 'constantes.dart';
import 'card_padrao.dart';
import 'botaoInferiorPadrao.dart';
import 'Inputs.dart';
import 'tela_historico_estoque.dart';


class TelaDados extends StatelessWidget {
  const TelaDados(
      {super.key,
      required this.resultadoConsumoDiario,
      required this.resultadoEstoque});

  
  final String resultadoConsumoDiario;
  final String resultadoEstoque;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(36, 16, 3, 0.992),
                offset: Offset(0, 3.0),
                blurRadius: 4.0,
              )
            ]),
            child: AppBar(
              backgroundColor: const Color.fromRGBO(255, 102, 0, 2.0),
              elevation: 6.0,
              title: const Text(
                "App Seara",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Reduzi o padding geral
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Alinha os itens no topo
                children: [
                  const Row(
                    children: [
                    ],
                  ),
                  const SizedBox(
                      height:
                          20.0), // Reduzi o espaçamento vertical entre as linhas
                  Row(
                    children: [
                      Expanded(
                          child: CardPadrao(
                        filhoCard: Column(
                          children: [
                            const Text(
                              'Consumo Diário (Kg)',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                resultadoConsumoDiario,
                                style: kTextTelaDadosResult,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: CardPadrao(
                        filhoCard: Column(
                          children: [
                            const Text(
                              'Estoque (Kg)',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                resultadoEstoque,
                                style: kTextTelaDadosResult,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaHistoricoEstoque(),
                ),
              );
            },
            child: BotaoInferiorPadrao(
              textoInferior: 'Ver Histórico',
            ),
          ),
        ],
      ),
    );
  }
}
