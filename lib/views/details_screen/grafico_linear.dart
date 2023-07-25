import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

class ChartData {
  final int x; // Índice do ponto no gráfico
  final String data;
  final double? prev;
  final double? real;

  ChartData(this.x, this.data, this.prev, this.real);
}

class JsonLoader {
  static Future<List<dynamic>> loadJsonData(String fileName) async {
    try {
      String jsonData = await rootBundle.loadString(fileName);
      return jsonDecode(jsonData);
    } catch (e) {
      throw Exception('Erro ao carregar o arquivo JSON: $e');
    }
  }
}

class GraficoLinear extends StatefulWidget {
  final String cardIndex;
  final String indicator;
  GraficoLinear(this.cardIndex, this.indicator, {Key? key}) : super(key: key);

  @override
  _GraficoLinearState createState() => _GraficoLinearState();
}

class _GraficoLinearState extends State<GraficoLinear> {
  late List<FlSpot> prevData;
  late List<FlSpot> realData;
  double? menorValor;
  double? maiorValor;
  bool dataLoaded = false;
  bool hasError = false;

  Future<void> _carregarDados() async {
    try {
      List<dynamic> dataList;
      switch (widget.indicator) {
        case 'Patrimônio Líquido':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Patrimônio_Líquido.json',
          );
          break;

        case 'Lucro Líquido':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Lucro_Prejuízo_do_Período.json',
          );
          break;
        case 'Dividendos':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_dividends.json',
          );
          break;
        case 'Receita Líquida':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Receita.json',
          );
          break;
        case 'Despesas Trabalhistas':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Obrigações_Sociais_e_Trabalhistas.json',
          );
          break;
        case 'Passivo Total':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Passivo_Total.json',
          );
          break;
        case 'Contas a Receber':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Contas_a_Receber.json',
          );
          break;
        case 'Reservas de Lucro':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Reservas_de_Lucro.json',
          );
          break;

        // Adicione mais cases conforme necessário para outros indicadores
        default:
          dataList = [];
      }

      List<ChartData> chartData = dataList.asMap().entries.map((entry) {
        var data = entry.value["data"];
        var info = entry.value["info"];
        double? prev;
        double? real;

        // Verificar se a info é "prev" ou "real" e atribuir o valor a variável correspondente
        if (info == "prev") {
          prev = entry.value["valor"]?.toDouble();
        } else if (info == "real") {
          real = entry.value["valor"]?.toDouble();
        }

        return ChartData(
          entry.key,
          data,
          prev,
          real,
        );
      }).toList();

      setState(() {
        prevData = chartData
            .where((data) => data.prev != null)
            .map((data) => FlSpot(data.x.toDouble(), data.prev!))
            .toList();

        realData = chartData
            .where((data) => data.real != null)
            .map((data) => FlSpot(data.x.toDouble(), data.real!))
            .toList();

        // Encontre o menor e o maior valor entre os dois conjuntos de dados
        menorValor = (prevData + realData)
            .reduce((valorAtual, elemento) =>
                valorAtual.y < elemento.y ? valorAtual : elemento)
            .y;
        maiorValor = (prevData + realData)
            .reduce((valorAtual, elemento) =>
                valorAtual.y > elemento.y ? valorAtual : elemento)
            .y;

        // Ajuste a escala do eixo Y para incluir ambos os conjuntos de dados
        maiorValor = double.parse(maiorValor!.toStringAsFixed(0)) + 5;
        menorValor = double.parse(menorValor!.toStringAsFixed(0)) - 5;

        dataLoaded =
            true; // Atualize a variável de controle após carregar os dados.
        hasError =
            false; // Resete a variável de erro caso os dados tenham sido carregados corretamente
      });
    } catch (e) {
      // Tratar possíveis erros de carregamento dos dados
      setState(() {
        hasError = true;
      });
      print('Erro ao carregar os dados: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  void didUpdateWidget(GraficoLinear oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.indicator != widget.indicator) {
      _carregarDados(); // Chama o método para carregar os dados toda vez que o indicador é atualizado
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Center(
        child: Text(
          'Não há dados disponíveis.',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    if (!dataLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: prevData,
            isCurved: false,
            dotData: FlDotData(show: false),
            color: Colors.red, // Use a cor vermelha para os valores de "prev"
            barWidth: 1.5,
          ),
          LineChartBarData(
            spots: realData,
            isCurved: false,
            dotData: FlDotData(show: false),
            color: Colors.blue, // Use a cor azul para os valores de "real"
            barWidth: 1.5,
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
        ),
        borderData: FlBorderData(
          border: Border.all(
              color: Colors.black, width: 5.0, style: BorderStyle.solid),
        ),
        minX: 0,
        maxX: null,
        minY: menorValor,
        maxY: maiorValor,
        backgroundColor: Colors.black87,
      ),
    );
  }
}
