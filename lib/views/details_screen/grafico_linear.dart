import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

class _GraficoLinearState extends State<GraficoLinear> {
  List<String> Real_X = [];
  List<FlSpot> Real_Y = [];
  List<Tuple3<int, String, double>> chartData = [];
  List<Tuple3<int, String, double>> chartData_pred = [];
  List<Tuple3<int, String, double>>? lastTuplePred = [];
  double? menorValor;
  double? maiorValor;
  String? name1;
  String? name2;
  bool dataLoaded = false;
  bool hasError = false;
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  @override
  Future<void> _carregarDados() async {
    try {
      List<dynamic> dataList;
      switch (widget.indicator) {
        case 'Patrimônio Líquido':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Patrimônio_Líquido.json',
          );

          name1 = "PL";
          name2 = "PL Predição";

          break;

        case 'Lucro Líquido':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Lucro_Prejuízo_do_Período.json',
          );
          name1 = 'Lucro Líquido';
          name2 = "Lucro Líquido Predição";
          break;
        case 'Dividendos':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_dividends.json',
          );
          name1 = 'Dividendos';
          name2 = "Dividendos Predição";
          break;
        case 'Receita Líquida':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Receita.json',
          );
          name1 = 'Receita Líquida';
          name2 = "Receita Líquida Predição";
          break;
        case 'Despesas Trabalhistas':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Obrigações_Sociais_e_Trabalhistas.json',
          );
          name1 = 'Despesas Trabalhistas';
          name2 = 'Despesas Trabalhistas Predição';
          break;
        case 'Passivo Total':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Passivo_Total.json',
          );
          name1 = 'Passivo Total';
          name2 = 'Passivo Total Predição';
          break;
        case 'Contas a Receber':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Contas_a_Receber.json',
          );
          name1 = 'Contas a Receber';
          name2 = 'Contas a Receber Predição';
          break;
        case 'Reservas de Lucro':
          dataList = await JsonLoader.loadJsonData(
            'asset/Empresas_data/${widget.cardIndex}_Reservas_de_Lucro.json',
          );
          name1 = 'Reservas de Lucro';
          name2 = 'Reservas de Lucro Predição';
          break;
        default:
          dataList = [];
      }
      chartData = dataList.where((data) => data['info'] == 'real').map((data) {
        int index = data['index'];
        String label = data['data'];
        double valor = data['valor'];
        DateTime parsedDate = DateTime.parse(label);
        String formattedDate = DateFormat('MMM-yy').format(parsedDate);
        return Tuple3(index, formattedDate, valor);
      }).toList();

      chartData_pred =
          dataList.where((data) => data['info'] == 'prev').map((data) {
        int index = data['index'];
        String label = data['data'];
        double valor = data['valor'];
        DateTime parsedDate = DateTime.parse(label);

        String formattedDate = DateFormat('MMM-yy').format(parsedDate);
        return Tuple3(index, formattedDate, valor);
      }).toList();

      //Aqui ele arruma aquele buraquinho no gráfico
      chartData.add(chartData_pred.first);

      ;
    } catch (e) {
      setState(() {
        hasError = true;
      });
      print('Erro ao carregar os dados: $e');
    }
    setState(() {});
  }

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: true,
      enablePinching: true,
      zoomMode: ZoomMode.xy,
      enablePanning: true,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    _carregarDados();
  }

  @override
  void didUpdateWidget(GraficoLinear oldWidget) {
    chartData = [];
    chartData_pred = [];
    name1 = "";
    name2 = "";
    super.didUpdateWidget(oldWidget);
    if (oldWidget.indicator != widget.indicator) {
      _carregarDados();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Container(
                    child: SfCartesianChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
      ),
      primaryXAxis: CategoryAxis(
        labelRotation: 45,
        labelIntersectAction: AxisLabelIntersectAction.multipleRows,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<Tuple3<int, String, double>, String>(
          dataSource: chartData,
          xValueMapper: (Tuple3<int, String, double> spot, _) =>
              spot.item2.toString(),
          yValueMapper: (Tuple3<int, String, double> spot, _) =>
              spot.item3.toDouble(),
          color: Colors.blue,
          name: "$name1",
        ),
        LineSeries<Tuple3<int, String, double>, String>(
          dataSource: chartData_pred,
          xValueMapper: (Tuple3<int, String, double> spot, _) =>
              spot.item2.toString(),
          yValueMapper: (Tuple3<int, String, double> spot, _) =>
              spot.item3.toDouble(),
          color: Colors.red,
          name: "$name2",
        ),
      ],
      zoomPanBehavior: _zoomPanBehavior,
    )))));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
