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

  void obterTarefas() async {
    _tarefas = await tarefaRepository.listarTarefas();
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
                    title: Text("Adicionar tarefa"),
                    content: TextField(
                      controller: descricaoController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            await tarefaRepository.adicionarTarefa(
                                Tarefa(descricaoController.text, false));
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Text("Salvar"))
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: _tarefas.length,
            itemBuilder: (BuildContext bc, int index) {
              var tarefa = _tarefas[index];
              return Text(tarefa.getDescricao());
            }));
  }
}
