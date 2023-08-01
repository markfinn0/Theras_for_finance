import 'package:flutter/material.dart';

class ListaGavetinha {
  List<String> get tipoDeGraficoLista => <String>['Finanças', 'Price'];

  List<String> get indicadoresPriceLista =>
      <String>['Média Móvel 14', 'RSI', 'Bollinger Bands', 'MACD'];
  List<String> get acoesPriceLista => <String>['PETR3', 'PETR4'];
  List<String> get indicadoresFundamentalistasLista => <String>[
        'Patrimônio Líquido',
        'Contas a Receber',
        'Passivo Total',
        'Despesas Trabalhistas',
        'Receita Líquida',
        'Reservas de Lucro',
        'Lucro Líquido',
        'Dividendos'
      ];
}

typedef void StringCallback(String val);

class Gavetinha extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final String legenda;
  final List<String> lista;
  final StringCallback? callback;
  final StringCallback? callback2;

  Gavetinha(
    this.legenda,
    this.lista, {
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.callback,
    this.callback2,
    Key? key,
  }) : super(key: key);

  @override
  State<Gavetinha> createState() => GavetinhaState();
}

class GavetinhaState extends State<Gavetinha> {
  late String dropdownValue;
  late String dropdownValue2;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.lista.first;
    dropdownValue2 = widget.lista.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.legenda),
        Container(
          decoration: BoxDecoration(color: widget.backgroundColor),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          margin: const EdgeInsets.only(top: 5),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: null,
            dropdownColor: widget.backgroundColor,
            focusColor: widget.backgroundColor,
            underline: null,
            elevation: 16,
            style: TextStyle(color: widget.textColor),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });

              if (widget.callback != null) {
                widget.callback!(value!);
              }

              if (widget.callback2 != null) {
                dropdownValue2 = value!;
                widget.callback2!(dropdownValue2);
              }
            },
            items: widget.lista.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
