import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/repositories/sqlite/tarefa_sqlite_repository.dart';
import 'package:trilhaflutterdio/repositories/tarefa_hive_repository.dart';
import 'package:trilhaflutterdio/repositories/tarefa_repository.dart';

import '../../model/tarefa.dart';
import '../../model/tarefa_hive_model.dart';
import '../../model/tarefa_sqlite_model.dart';

class TarefaSQLitePage extends StatefulWidget {
  const TarefaSQLitePage({super.key});

  @override
  State<TarefaSQLitePage> createState() => _TarefaSQLitePageState();
}

class _TarefaSQLitePageState extends State<TarefaSQLitePage> {
  TarefaSQLiteRepository tarefaRepository = TarefaSQLiteRepository();
  TextEditingController descricaoController = TextEditingController();
  var _tarefas = const <TarefaSQLiteModel>[];
  var apenasNaoConcluidos = false;

  void obterTarefas() async {
    _tarefas = await tarefaRepository.obterDados(apenasNaoConcluidos);

    setState(() {});
  }

  @override
  void initState() {
    obterTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            descricaoController.text = '';
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar tarefa"),
                    content: TextField(
                      controller: descricaoController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            await tarefaRepository.salvar(TarefaSQLiteModel(
                                0, descricaoController.text, false));
                            Navigator.pop(context);
                            obterTarefas();
                            setState(() {});
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Apenas não concluídos",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: apenasNaoConcluidos,
                      onChanged: (bool value) {
                        apenasNaoConcluidos = value;
                        obterTarefas();
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = _tarefas[index];
                      return Dismissible(
                        key: Key(tarefa.descricao),
                        onDismissed: (DismissDirection dismissDirection) async {
                          tarefaRepository.remover(tarefa.id);
                          obterTarefas();
                        },
                        child: ListTile(
                          title: Text(tarefa.descricao),
                          trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                tarefaRepository.atualizar(tarefa);
                                obterTarefas();
                              },
                              value: tarefa.concluido),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
