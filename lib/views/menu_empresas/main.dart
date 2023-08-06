import 'package:flutter/material.dart';
import '../menu_empresas/footer.dart';
import '../menu_empresas/menu.dart';
import '../../components/header.dart';

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
      appBar: const HeaderTheras(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 50), // Adicione o espaçamento desejado aqui
            child: Column(
              children: <Widget>[
                Expanded(
                  child: MenuContainer(),
                ),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
