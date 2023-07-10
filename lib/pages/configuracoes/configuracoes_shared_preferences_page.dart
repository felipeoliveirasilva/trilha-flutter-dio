import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  AppStorageService storage = AppStorageService();

  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscuro = false;
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text = (await storage.getConfiguracoesAltura()).toString();
    temaEscuro = await storage.getConfiguracoesModoEscuro();
    receberPushNotification =
        await storage.getConfiguracoesReceberNotificacoes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
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
                    receberPushNotification = !receberPushNotification;
                  });
                },
                value: receberPushNotification),
            SwitchListTile(
                title: const Text("Tema Escuro"),
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = !temaEscuro;
                  });
                },
                value: temaEscuro),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await storage
                      .setConfiguracoesNomeUsuario(nomeUsuarioController.text);
                  try {
                    await storage.setConfiguracoesAltura(
                        double.parse(alturaController.text));
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
                  await storage.setConfiguracoesReceberNotificacoes(
                      receberPushNotification);
                  await storage.setConfiguracoesModoEscuro(temaEscuro);
                  Navigator.pop(context);
                },
                child: const Text("Salvar"))
          ],
        ),
      ),
    ));
  }
}
