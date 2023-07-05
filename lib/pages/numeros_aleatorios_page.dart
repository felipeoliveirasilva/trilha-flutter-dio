import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int? numeroGerado;
  int? quantidadeCliques;
  final CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  final CHAVE_QUANTIDADE_CLIQUES = "quantidade_cliques";
  late SharedPreferences storage;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
      quantidadeCliques = storage.getInt(CHAVE_QUANTIDADE_CLIQUES);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Gerador de números aleatorios")),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              var random = Random();
              setState(() {
                numeroGerado = random.nextInt(1000);
                quantidadeCliques = (quantidadeCliques ?? 0) + 1;
              });
              storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
              storage.setInt(CHAVE_QUANTIDADE_CLIQUES, quantidadeCliques!);
            }),
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              numeroGerado == null ? "" : numeroGerado.toString(),
              style: TextStyle(fontSize: 22),
            ),
            Text(
              quantidadeCliques == null ? "" : quantidadeCliques.toString(),
              style: TextStyle(fontSize: 22),
            )
          ]),
        ),
      ),
    );
  }
}
