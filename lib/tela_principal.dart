import 'package:flutter/material.dart';
import 'constantes.dart';
import 'card_padrao.dart';
import 'botaoInferiorPadrao.dart';
import 'Inputs.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  TextEditingController idade = TextEditingController();
  TextEditingController qtdtotracao = TextEditingController();
  TextEditingController mortalidade = TextEditingController();
  TextEditingController pesoMedio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(36, 16, 3, 0.992),
                offset: Offset(0, 3.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(255, 102, 0, 2.0),
            elevation: 3.0,
            title: const Text(
              "App Seara",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'Entrada de Dados',
                  style: kTextStyleDados,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0), // Reduzi o padding geral
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Alinha os itens no topo
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: InputsCard(
                        desc: 'IDADE', edit: idade,
                      )),
                      SizedBox(width: 8.0), // Reduzi o espaçamento horizontal
                      Expanded(child: InputsCard(desc: 'QUANTIDADE TOTAL RAÇÃO', edit: qtdtotracao,)),
                    ],
                  ),
                  SizedBox(
                      height:
                          20.0), // Reduzi o espaçamento vertical entre as linhas
                  Row(
                    children: [
                      Expanded(child: InputsCard(desc: 'MORTALIDADE', edit: mortalidade,)),
                      SizedBox(width: 8.0), // Reduzi o espaçamento horizontal
                      Expanded(child: InputsCard(desc: 'PESO MÉDIO', edit: pesoMedio,)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BotaoInferiorPadrao(textoInferior: 'Enviar'),
        ],
      ),
    );
  }
}
