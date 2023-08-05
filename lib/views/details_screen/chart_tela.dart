import 'dart:convert';
//import 'dart:ffi';
//import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

class GraficoLinear extends StatefulWidget {
  final String cardIndex;
  late String tipoGrafico;
  late String tipoEmpresa;
  late String indicador;

  bool mediaVisible = true;
  bool price = true;
  bool dividendos = true;
  bool patrimonio = false;
  bool bandasVisible = false;
  bool rsiVisible = false;
  bool macdVisible = false;

  GraficoLinear(this.cardIndex, this.indicador, {Key? key}) : super(key: key);

  @override
  _GraficoLinearState createState() => _GraficoLinearState();
}

class _GraficoLinearState extends State<GraficoLinear> {
  var inicio;
  /*late Map<String, dynamic> view;*/
  late List<dynamic> view2;
  late List<dynamic> view2Prev;

  late List<dynamic> view3;
  late List<dynamic> view3Prev;

  late List<dynamic> view;
  late List<dynamic> viewPred;

  late List<dynamic> view4;
  late List<dynamic> view4Prev;

  late List<dynamic> view5;
  late List<dynamic> view5Prev;

  late List<dynamic> viewDividendos;
  late List<dynamic> viewPatrimonio;

  late String jsonData;
  late String jsonDataPred;

  late String jsonData1;
  late String jsonData1Prev;

  late String jsonData2;
  late String jsonData2Prev;

  late String jsonData4;
  late String jsonData4Prev;

  late String jsonData5;
  late String jsonData5Prev;

  late String jsonDataDividendos;
  late String jsonDataPatrimonio;

  List<dynamic> predicaoValor = [];

  //double? quant;
  double? menorValor;
  double? maiorValor;

  List<FlSpot> chartDataDividendos = [];
  List<FlSpot> chartDataDividendosPred = [];

  List<FlSpot> chartDataPatrimonio = [];
  List<FlSpot> chartDataPatrimonioPred = [];

  List<FlSpot> chartDataPred = [];
  List<FlSpot> chartDataPredData = [];

  List<FlSpot> chartData_media_movel = [];
  List<FlSpot> chartDataPrev_media_movel = [];

  List<FlSpot> chartData_sup_boll = [];
  List<FlSpot> chartDataPrev_sup_boll = [];

  List<FlSpot> chartData_inf_boll = [];
  List<FlSpot> chartDataPrev_inf_boll = [];

  List<FlSpot> chartData_rsi = [];
  List<FlSpot> chartDataPrev_rsi = [];

  List<FlSpot> chartData_macd = [];
  List<FlSpot> chartDataPrev_macd = [];

  List<FlSpot> chartData = [];
  int index_empresa = 0;
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: true,
      enablePinching: true,
      zoomMode: ZoomMode.xy,
      enablePanning: true,
    );
    super.initState();
    loadData();
  }

  @override
  void didUpdateWidget(GraficoLinear oldWidget) {
    if (widget.tipoGrafico == 'Finanças') {
      jsonDataDividendos = '';
      jsonDataPatrimonio = '';
      viewDividendos = [];
      viewPatrimonio = [];
      chartDataDividendos = [];
      chartDataDividendosPred = [];
      chartDataPatrimonio = [];
      chartDataDividendosPred = [];

      switch (widget.indicador) {
        case "Patrimônio Líquido":
          
          widget.dividendos = false;
          widget.patrimonio = true;
          break;
      }
    }

    loadData();

    super.didUpdateWidget(oldWidget);
  }

  Future<void> loadData() async {
    if (widget.tipoGrafico == 'Finanças') {
      switch (widget.indicador) {
        case 'Patrimônio Líquido':
          jsonDataDividendos = await rootBundle.loadString(
              'asset/Empresas_data/${widget.cardIndex}_Patrimônio_Líquido.json');
          viewDividendos = jsonDecode(jsonDataDividendos);
          int contador = 0;
          for (int a = 0; a < viewDividendos.length; a++) {
            if (viewDividendos[a]['info'] == 'real') {
              chartDataDividendos.insert(
                  a, FlSpot(a.toDouble(), viewDividendos[a]['valor']));
            } else {
              if (contador == 0) {
                chartDataDividendosPred.insert(contador,
                    FlSpot(a.toDouble() - 1, viewDividendos[a - 1]['valor']));
              }
              contador++;
              chartDataDividendosPred.insert(
                  contador, FlSpot(a.toDouble(), viewDividendos[a]['valor']));
            }
          }
          break;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tipoGrafico == 'Finanças') {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              child: SfCartesianChart(
                legend: Legend(isVisible: true, position: LegendPosition.right),
                primaryXAxis: NumericAxis(
                  interval: 35,

                  title: AxisTitle(text: 'Data'),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,

                  //trabalhar aqui depois................................
                ),
                primaryYAxis: NumericAxis(
                  interval: 10,
                  title: AxisTitle(text: 'Valor'),
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: '',
                  format: 'point.y',
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    late final positionDividendosValue;
                    late final positionDividendosPredValue;

                    late final DividendosValue;
                    late final DividendosPredValue;
                    var indexLine = seriesIndex;

                    if (seriesIndex == 0) {
                      positionDividendosValue =
                          chartDataDividendos[pointIndex].x.toInt();
                      DividendosValue = viewDividendos[positionDividendosValue]
                              ['valor']
                          .toStringAsFixed(2);
                    }
                    if (seriesIndex == 1) {
                      positionDividendosPredValue =
                          chartDataDividendosPred[pointIndex].x.toInt();
                      DividendosPredValue =
                          viewDividendos[positionDividendosPredValue]['valor']
                              .toStringAsFixed(2);
                    }

                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (indexLine == 0)
                            Text(
                                'Data: ${viewDividendos[positionDividendosValue]['data']}'),
                          if (indexLine == 0)
                            Text('Dividendo: $DividendosValue'),
                          if (indexLine == 1)
                            Text(
                                'Data: ${viewDividendos[positionDividendosPredValue]['data']}'),
                          if (indexLine == 1)
                            Text('Dividendo: $DividendosPredValue'),
                        ],
                      ),
                    );
                  },
                ),
                series: <ChartSeries>[
                  // 0
                  LineSeries<FlSpot, double>(
                    isVisible: widget.dividendos,
                    dataSource: chartDataDividendos,
                    xValueMapper: (FlSpot spot, _) => spot.x,
                    yValueMapper: (FlSpot spot, _) => spot.y,
                    color: Colors.blue,
                    name: 'Dividendos',
                  ),
                  LineSeries<FlSpot, double>(
                    isVisible: widget.dividendos,
                    dataSource: chartDataDividendosPred,
                    xValueMapper: (FlSpot spot, _) => spot.x,
                    yValueMapper: (FlSpot spot, _) => spot.y,
                    color: Colors.red,
                    name: 'Pred. Dividendos',
                  ),
                  LineSeries<FlSpot, double>(
                    isVisible: widget.patrimonio,
                    dataSource: chartDataPatrimonio,
                    xValueMapper: (FlSpot spot, _) => spot.x,
                    yValueMapper: (FlSpot spot, _) => spot.y,
                    color: Colors.green,
                    name: 'Patrimonio',
                  ),
                ],
                zoomPanBehavior: _zoomPanBehavior,
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold();
    }
  }
}
