import 'package:flutter/material.dart';
import 'package:seara_app/funcoes.dart';
import 'package:seara_app/tela_dados.dart';
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
  TextEditingController idadeController = TextEditingController();
  TextEditingController qtdtotracaoController = TextEditingController();
  TextEditingController mortalidadeController = TextEditingController();
  TextEditingController pesoMedioController = TextEditingController();
  TextEditingController chegouPintController = TextEditingController();
  TextEditingController racaoPorAveController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void reset() {
    idadeController.text = "";
    qtdtotracaoController.text = "";
    mortalidadeController.text = "";
    pesoMedioController.text = "";
    chegouPintController.text = "";
    racaoPorAveController.text = "";
  }

  String consumoDiario() {
    double cheg = double.parse(chegouPintController.text);
    double morre = double.parse(mortalidadeController.text);
    double racao = double.parse(racaoPorAveController.text);
    double result = (cheg - morre) * racao;

    return result.toStringAsFixed(0);
  }

  String CA() {
    double consuDiario = double.parse(consumoDiario());
    double totalconsumido = consuDiario++;
    double pesoMedio = double.parse(pesoMedioController.text);
    double avesAloj = double.parse(chegouPintController.text);
    double mortalidade = double.parse(mortalidadeController.text);
    double totAves = avesAloj - mortalidade;
    double pesoTot = pesoMedio * totAves;
    double resultadoCA = totalconsumido / pesoTot;

    return resultadoCA.toStringAsFixed(4);
  }

  String CAC() {
    double pesoMedio = double.parse(pesoMedioController.text);
    double variavelCA = double.parse(CA());
    double avesAloj = double.parse(chegouPintController.text);
    double mortalidade = double.parse(mortalidadeController.text);
    double totAves = avesAloj - mortalidade;
    double pesoTot = pesoMedio * totAves;
    double k9 = pesoTot / totAves;
    double resultadoCAC = (((2.8 - k9) / 50) * 9.271 + variavelCA);

    return resultadoCAC.toStringAsFixed(4);
  }

  String Estoque() {
    double racaAloja = double.parse(qtdtotracaoController.text);
    double consumo = double.parse(consumoDiario());

    double result = (racaAloja - consumo);
    return result.toStringAsPrecision(4);
  }

  int? selectedDay; // Variável para armazenar o dia selecionado
  String? selectedGender2; // Seleção para o segundo CardPadrao

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
            actions: [IconButton(onPressed: reset, icon: Icon(Icons.refresh))],
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
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'DIA',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                DropdownButton<int>(
                                  iconSize: 0.0,
                                  hint: Center(
                                    child: const Text(
                                      'Selecione:',
                                      style: TextStyle(color: Colors.white, fontSize: 15.0, ),
                                    ),
                                  ),
                                  value: selectedDay,
                                  items: List.generate(40, (index) => index + 1)
                                      .map((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      selectedDay = newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  dropdownColor:
                                      const Color.fromARGB(255, 56, 56, 56),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'RAÇÃO/AVE(g)',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InputsCard(
                                    validato: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo vazio';
                                      }
                                      return null;
                                    },
                                    desc: 'Qtd.',
                                    edit: racaoPorAveController)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'GÊNERO',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                DropdownButton<String>(
                                  iconSize: 0.0,
                                  hint: const Text(
                                    'Selecione:',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15.0,),
                                  ),
                                  value: selectedGender2,
                                  items: <String>['Masculino', 'Feminino']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender2 = newValue;
                                    });
                                  },
                                ),
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
                                    desc: 'Quantidade',
                                    edit: chegouPintController)
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
                                    desc: 'Morreu',
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
                                  'RAÇÃO ALOJADA',
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
                                    desc: 'Quantidade',
                                    edit: qtdtotracaoController)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'PESO MÉDIO',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputsCard(
                                    validato: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Este campo não pode estar vazio';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Por favor, insira um número válido';
                                      }
                                      return null;
                                    },
                                    desc: 'Peso',
                                    edit: pesoMedioController),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDados(
                          resultadoAve: consumoDiario(),
                          estoquee: Estoque(),
                          resultadoCA: CA(),
                          resultadoCAC: CAC(),
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
