import 'package:flutter/material.dart';
import 'package:seara_app/tela_dados.dart';
import 'package:seara_app/tela_principal.dart';

void main() {
  runApp(SearaApp());
}

// ignore: camel_case_types
class SearaApp extends StatelessWidget {
  const SearaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seara weeddwApp',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: TelaPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}
