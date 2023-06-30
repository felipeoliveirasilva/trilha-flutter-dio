import '../model/tarefa.dart';

class TarefaRepository {
  List<Tarefa> _tarefas = [];

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.add(tarefa);
  }

  void alterarTarefa(String id, bool concluido) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas
        .where((tarefa) => tarefa.getId() == id)
        .first
        .setConcluido(concluido);
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas;
  }
}
