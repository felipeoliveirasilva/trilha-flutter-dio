import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/repositories/tarefa_repository.dart';

import '../model/tarefa.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  TextEditingController descricaoController = TextEditingController();
  var _tarefas = const <Tarefa>[];
  var apenasNaoConcluidos = false;

  void obterTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefaRepository.listarTarefasNaoConcluidas();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }

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
                            await tarefaRepository.adicionarTarefa(
                                Tarefa(descricaoController.text, false));
                            Navigator.pop(context);
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
                        key: Key(tarefa.id),
                        onDismissed: (DismissDirection dismissDirection) async {
                          await tarefaRepository.removerTarefa(tarefa.id);
                          obterTarefas();
                        },
                        child: ListTile(
                          title: Text(tarefa.descricao),
                          trailing: Switch(
                              onChanged: (bool value) async {
                                await tarefaRepository.alterarTarefa(
                                    tarefa.id, value);
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
