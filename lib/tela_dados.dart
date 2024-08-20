import 'package:flutter/material.dart';

class TelaDados extends StatefulWidget {
  const TelaDados({super.key});

  @override
  State<TelaDados> createState() => _TelaDadosState();
}

class _TelaDadosState extends State<TelaDados> {
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
        body: Container(
          color: Colors.black54,
        ));
  }
}
