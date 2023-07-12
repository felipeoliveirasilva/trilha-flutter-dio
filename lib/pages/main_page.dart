import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/pages/card_page.dart';
import 'package:trilhaflutterdio/pages/image_assets.dart';
import 'package:trilhaflutterdio/pages/list_view.dart';
import 'package:trilhaflutterdio/pages/list_view_horizontal_page.dart';
import 'package:trilhaflutterdio/pages/tarefa_page/tarefa_page_hive.dart';
import 'package:trilhaflutterdio/shared/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Main Page")),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
                child: PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        posicaoPagina = value;
                      });
                    },
                    children: const [
                  CardPage(),
                  ImageAssets(),
                  ListViewPage(),
                  ListViewHorizontal(),
                  TarefaPage()
                ])),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  setState(() {
                    controller.jumpToPage(value);
                  });
                  ;
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                      label: "Cards", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: "Imagens", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(
                      label: "ListView", icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      label: "ListViewHorizontal", icon: Icon(Icons.image)),
                  BottomNavigationBarItem(
                      label: "Tarefas", icon: Icon(Icons.list))
                ])
          ],
        ),
      ),
    );
  }
}
