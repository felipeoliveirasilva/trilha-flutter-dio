import 'package:flutter/material.dart';
import 'package:trilhaflutterdio/pages/card_page.dart';
import 'package:trilhaflutterdio/pages/image_assets.dart';
import 'package:trilhaflutterdio/pages/pagina3.dart';
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
                    children: const [CardPage(), ImageAssets(), Pagina3()])),
            BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    controller.jumpToPage(value);
                  });
                  ;
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                      label: "Pag1", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(label: "Pag2", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(
                      label: "Pag3", icon: Icon(Icons.person))
                ])
          ],
        ),
      ),
    );
  }
}
