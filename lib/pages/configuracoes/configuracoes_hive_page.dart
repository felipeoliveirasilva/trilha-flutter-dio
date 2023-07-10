import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/repositories/configuracoes_repository.dart';
import 'package:trilhaflutterdio/services/app_storage_service.dart';

import '../../model/configuracoes_model.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações Hive"),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Nome usuário"),
                controller: nomeUsuarioController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Altura"),
                controller: alturaController,
              ),
            ),
            SwitchListTile(
                title: const Text("Receber Notificações"),
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.receberNotificacoes = value;
                  });
                },
                value: configuracoesModel.receberNotificacoes),
            SwitchListTile(
                title: const Text("Tema Escuro"),
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.temaEscuro = value;
                  });
                },
                value: configuracoesModel.temaEscuro),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  try {
                    configuracoesModel.altura =
                        double.parse(alturaController.text);
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Meu App"),
                            content:
                                const Text("Favor informar uma altura válida"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          );
                        });
                  }
                  configuracoesRepository.salvar(configuracoesModel);
                  Navigator.pop(context);
                },
                child: const Text("Salvar"))
          ],
        ),
      ),
    ));
  }
}
