import 'package:flutter/material.dart';

class ListaGavetinha {
  List<String> get tipoDeGraficoLista => <String>['Price', 'Finanças'];
  List<String> get indicadoresPriceLista =>
      <String>['Média Móvel 14', 'Média Móvel 21', 'RSI', 'Bollinger Bands'];
  List<String> get acoesPriceLista => <String>['PETR3', 'PETR4'];
  List<String> get indicadoresFundamentalistasLista => <String>[
        'Dividendos',
        'Patrimônio Líquido',
        'Lucro Líquido',
        'Receita Líquida'
      ];
}

class Gavetinha extends StatefulWidget {
  late Color backgroundColorParam;
  late Color textColorParam;
  late String legendaParam;
  late List<String> listaParam;
  // final Color textColor = Colors.black;
  Gavetinha(String legenda, List<String> lista,
      {Color backgroundColor = Colors.white,
      Color textColor = Colors.black,
      super.key}) {
    backgroundColorParam = backgroundColor;
    textColorParam = textColor;
    legendaParam = legenda;
    listaParam = lista;
  }

  @override
  State<Gavetinha> createState() => GavetinhaState2();
}

class GavetinhaState extends State<Gavetinha> {
  late List<String> lista;
  late String dropdownValue;
  late Color backgroundColor;
  late Color textColor;
  late String legenda;
  @override
  void initState() {
    super.initState();
    backgroundColor = widget.backgroundColorParam;
    textColor = widget.textColorParam;
    legenda = widget.legendaParam;
    lista = widget.listaParam;
    dropdownValue = lista.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(color: backgroundColor),
        decoration: BoxDecoration(color: backgroundColor),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(children: [
          Text(
            legenda,
            style: TextStyle(color: textColor),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: null,
            dropdownColor: backgroundColor,
            focusColor: backgroundColor,
            underline: null,
            elevation: 16,
            style: TextStyle(color: textColor),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: lista.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ]));
  }
}

class GavetinhaState2 extends State<Gavetinha> {
  late List<String> lista;
  late String dropdownValue;
  late Color backgroundColor;
  late Color textColor;
  late String legenda;
  @override
  void initState() {
    super.initState();
    backgroundColor = widget.backgroundColorParam;
    textColor = widget.textColorParam;
    legenda = widget.legendaParam;
    lista = widget.listaParam;
    dropdownValue = lista.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(legenda),
      Container(
          // decoration: BoxDecoration(color: backgroundColor),
          decoration: BoxDecoration(color: backgroundColor),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          margin: const EdgeInsets.only(top: 5),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: null,
            dropdownColor: backgroundColor,
            focusColor: backgroundColor,
            underline: null,
            elevation: 16,
            style: TextStyle(color: textColor),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: lista.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ))
    ]);
  }
}
