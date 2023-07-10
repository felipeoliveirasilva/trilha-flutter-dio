import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/services/app_storage_service.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() =>
      _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState
    extends State<NumerosAleatoriosSharedPreferencesPage> {
  int? numeroGerado;
  int? quantidadeCliques;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeCliques = await storage.getQuantidadeCliques();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Gerador de números aleatorios")),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              var random = Random();
              setState(() {
                numeroGerado = random.nextInt(1000);
                quantidadeCliques = (quantidadeCliques ?? 0) + 1;
              });
              storage.setNumeroAleatorio(numeroGerado!);
              storage.setQuantidadeCliques(quantidadeCliques!);
            }),
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              numeroGerado == null ? "" : numeroGerado.toString(),
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              quantidadeCliques == null ? "" : quantidadeCliques.toString(),
              style: const TextStyle(fontSize: 22),
            )
          ]),
        ),
      ),
    );
  }
}
