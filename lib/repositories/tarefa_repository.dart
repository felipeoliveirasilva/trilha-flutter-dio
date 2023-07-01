import '../model/tarefa.dart';

class TarefaRepository {
  List<Tarefa> _tarefas = [];

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    await Future.delayed(const Duration(milliseconds: 10));
    _tarefas.add(tarefa);
  }

  Future<void> alterarTarefa(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 10));
    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return _tarefas;
  }

  Future<List<Tarefa>> listarTarefasNaoConcluidas() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }

  Future<void> removerTarefa(String id) async {
    await Future.delayed(const Duration(milliseconds: 10));
    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }
}
