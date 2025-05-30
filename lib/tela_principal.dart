import 'package:flutter/material.dart';
import 'package:seara_app/funcoes.dart';
import 'package:seara_app/tela_dados.dart';
import 'constantes.dart';
import 'card_padrao.dart';
import 'botaoInferiorPadrao.dart';
import 'Inputs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  /* void initState() {
    super.initState();
    carregarEstoque();
  } */

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
            actions: [
              IconButton(onPressed: reset, icon: const Icon(Icons.refresh))
            ],
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.grey[800],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'GAD',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  const SizedBox(height: 20),
                                  InputsCard(
                                      validato: (value) {
                                        if (value!.isEmpty) {
                                          return 'Campo vazio';
                                        }
                                        return null;
                                      },
                                      desc: 'Valor (g):',
                                      edit: gadController),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'AVES ALOJADAS',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputsCard(
                                    validato: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo vazio';
                                      }
                                      return null;
                                    },
                                    desc: 'Quantidade:',
                                    edit: avesAlojadasController)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'MORTALIDADE',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputsCard(
                                    validato: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo vazio';
                                      }
                                      return null;
                                    },
                                    desc: 'Morreram:',
                                    edit: mortalidadeController)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'RAÇÃO RECEBIDA (Kg)',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputsCard(
                                    validato: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo vazio';
                                      }
                                      return null;
                                    },
                                    desc: 'Quantidade (Kg):',
                                    edit: racaorecebidaController)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              iniciarNovoLote(context);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Iniciar Novo Lote'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    // 1. Calcula e salva estoque + aves vivas
                    //double novoEstoqueStr = await calculoEstoque();
                    //double novoEstoque = double.parse(novoEstoqueStr); // converte de volta para double

                    // 2. Salva o histórico com a função que você já criou
                    //await salvarEstoque(novoEstoque);

                    // 4. Navega para a próxima tela
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDados(
                          gad: gad,
                          racaoRecebida: racaoRecebida,
                        ),
                      ),
                    );
                  }
                },
                child: BotaoInferiorPadrao(
                  textoInferior: 'SALVAR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
