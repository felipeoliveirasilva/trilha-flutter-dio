import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trilhaflutterdio/services/app_storage_service.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado;
  int? quantidadeCliques;
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox("box_numeros_aleatorios");
    }

    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    quantidadeCliques = boxNumerosAleatorios.get('quantidadeCliques') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(title: const Text("Gerador de números aleatorios - Hive")),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              var random = Random();
              setState(() {
                numeroGerado = random.nextInt(1000);
                quantidadeCliques = (quantidadeCliques ?? 0) + 1;
              });
              boxNumerosAleatorios.put('numeroGerado', numeroGerado);
              boxNumerosAleatorios.put('quantidadeCliques', quantidadeCliques);
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
