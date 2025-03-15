import 'package:flutter/material.dart';
import 'package:seara_app/funcoes.dart';
import 'package:seara_app/tela_dados.dart';
// ignore: unused_import
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
  TextEditingController racaorecebidaController = TextEditingController();
  TextEditingController racaoEstoqueController = TextEditingController();
  TextEditingController mortalidadeController = TextEditingController();
  TextEditingController pesoMedioController = TextEditingController();
  TextEditingController avesAlojadasController = TextEditingController();
  TextEditingController aindaVaiConsumirController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  int? selectedDay;
  int? gramasIngeridas;

// Lista com a quantidade de gramas ingeridas por dia
  final List<int> gramaIngeridoPorDia = [20, 22, 24, 26, 29];  
  

  void reset() {
    idadeController.text = "";
    racaorecebidaController.text = "";
    mortalidadeController.text = "";
    pesoMedioController.text = "";
    avesAlojadasController.text = "";
    racaoEstoqueController.text = "";
  }

  /*String consumoDiario() {   // Função para calcular o consumo diário
    int result = 0;
    double cheg = double.parse(avesAlojadasController.text);
    double morre = double.parse(mortalidadeController.text);
    double consumo = ((cheg - morre) * gramasIngeridas!)/1000; // Consumo Diário em Kg

    return result.toStringAsFixed(0);
  }*/

  String CA() {
    //double consuDiario = double.parse(consumoDiario());
    //double totalconsumido = consuDiario++; Caso houver historico
    double pesoMedio = double.parse(pesoMedioController.text);
    double avesAloj = double.parse(avesAlojadasController.text);
    double mortalidade = double.parse(mortalidadeController.text);
    double racaoRecebida = double.parse(racaorecebidaController.text);
    double racaoEstoque = double.parse(racaoEstoqueController.text);
    double totAves = avesAloj - mortalidade;
    double pesoTot = pesoMedio * totAves;
    double racaoTotalConsumida = (racaoRecebida - racaoEstoque);
    double resultadoCA = racaoTotalConsumida / pesoTot;

    return resultadoCA.toStringAsFixed(4);
  }

  String CAC() {
    double pesoMedio = double.parse(pesoMedioController.text);
    double variavelCA = double.parse(CA());
    double avesAloj = double.parse(avesAlojadasController.text);
    double mortalidade = double.parse(mortalidadeController.text);
    double totAves = avesAloj - mortalidade;
    double pesoTot = pesoMedio * totAves;
    double k9 = pesoTot / totAves;
    double resultadoCAC = (((2.8 - k9) / 50) * 12.66 + variavelCA);

    return resultadoCAC.toStringAsFixed(4);
  }

  /*String Estoque() {  // Função para calcular o estoque
    double racaAloja = double.parse(racaorecebidaController.text);
    double consumo = double.parse(consumoDiario());

    double result = (racaAloja - consumo);
    return result.toStringAsPrecision(4);
  }*/

  //int? selectedDay; // Variável para armazenar o dia selecionado
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
                            child: Card(
                              color: Colors.grey[800],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'DIA',
                                      style: TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    DropdownButton<int>(
                                      iconSize: 0.0,
                                      hint: const Center(
                                        child: Text(
                                          'Selecione:',
                                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                                        ),
                                      ),
                                      value: selectedDay,
                                      items: List.generate(gramaIngeridoPorDia.length, (index) => index + 1)
                                          .map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          selectedDay = newValue;
                                          gramasIngeridas = newValue != null
                                              ? gramaIngeridoPorDia[newValue - 1] // Pega o valor correspondente na lista
                                              : null;
                                        });
                                      },
                                      isExpanded: true,
                                      dropdownColor: const Color.fromARGB(255, 56, 56, 56),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 10),
                                    if (gramasIngeridas != null)
                                      Text(
                                        "Gramas ingeridas: $gramasIngeridas g",
                                        style: const TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                  ],
                                ),
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
                                  items: <String>['Macho', 'Fêmea', 'Misto']
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
                                  'RAÇÃO EM ESTOQUE',
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
                                    edit: racaoEstoqueController)
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

                    Row(
                      children: [
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'AINDA VAI CONSUMIR',
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
                                    edit: aindaVaiConsumirController)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CardPadrao(
                            filhoCard: Column(
                              children: [
                                const Text(
                                  'RAÇÃO RECEBIDA',
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
                                    edit: racaorecebidaController)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
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
                          //resultadoAve: consumoDiario(),
                          //estoquee: Estoque(),
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