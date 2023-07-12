import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/pages/configuracoes/configuracoes_shared_preferences_page.dart';
import 'package:trilhaflutterdio/pages/dados_cadastrais/dados_cadastrais_hive.dart';
import 'package:trilhaflutterdio/pages/login_page.dart';
import 'package:trilhaflutterdio/pages/numeros_aleatorios/numeros_aleatorios_shared_preferences_page.dart';

import '../../pages/configuracoes/configuracoes_hive_page.dart';
import '../../pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Camera"),
                        leading: const Icon(Icons.camera),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Galeria"),
                        leading: const Icon(Icons.album),
                      ),
                    ],
                  );
                });
          },
          child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                    "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
              ),
              accountName: const Text("Felipe Silva"),
              accountEmail: const Text("felipeosilva@hotmail.com")),
        ),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Text("Dados cadastrais"),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DadosCadastraisHivePage()));
          },
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(width: 5),
                  Text("Termos de uso e privacidade"),
                ],
              )),
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (BuildContext) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: const Column(
                      children: [
                        Text(
                          "Termos de uso e privacidade",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "O empenho em analisar o aumento do diálogo entre os diferentes setores produtivos promove a alavancagem das posturas dos órgãos dirigentes com relação às suas atribuições.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 5),
                  Text("Configurações"),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (bc) => const ConfiguracoesHivePage()));
          },
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.numbers),
                  SizedBox(width: 5),
                  Text("Gerador de Números"),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (bc) => const NumerosAleatoriosHivePage()));
          },
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 5),
                  Text("Sair"),
                ],
              )),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    alignment: Alignment.centerLeft,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const Text("Meu App",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: const Wrap(
                      children: [
                        Text("Você sairá do aplicativo!"),
                        Text("Deseja realmente sair do aplicativo?"),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sim"))
                    ],
                  );
                });
          },
        ),
      ]),
    );
  }
}
