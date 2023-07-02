import 'package:flutter/material.dart';
import 'footer.dart';
import 'menu.dart';

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
        backgroundColor: const Color.fromRGBO(8, 32, 50, 50),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.report),
            onPressed: () {},
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        height: 1200,
        child: Stack(
          children: <Widget>[MenuContainer(), Footer()],
        ),
      ),
    );
  }
}
