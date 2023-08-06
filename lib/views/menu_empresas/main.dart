import 'package:flutter/material.dart';
import '../menu_empresas/footer.dart';
import '../menu_empresas/menu.dart';
import '../details_screen/main.dart';

class MenuEmpresas extends StatefulWidget {
  const MenuEmpresas({Key? key, required this.title});
  final String title;

  @override
  State<MenuEmpresas> createState() => _MenuEmpresasState();
}

class _MenuEmpresasState extends State<MenuEmpresas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 95, 156, 50),
        centerTitle: true,
        actions: [],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: 50), // Adicione o espaçamento desejado aqui
            child: Column(
              children: <Widget>[
                Expanded(
                  child: MenuContainer(),
                ),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
