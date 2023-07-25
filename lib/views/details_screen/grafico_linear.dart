
import 'dart:convert';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

late String jsonData;
late String jsonData1;
late String jsonData2;
List<dynamic> predicaoValor = [];

class GraficoLinear extends StatefulWidget {
  final String cardIndex;

  GraficoLinear(this.cardIndex, {Key? key}) : super(key: key);

  @override
  _GraficoLinearState createState() => _GraficoLinearState();
}

class _GraficoLinearState extends State<GraficoLinear> {
  var inicio;
  late Map<String, dynamic> view;
  late Map<String, dynamic> view2;
  late Map<String, dynamic> view3;
  double? quant;
  double? menorValor;
  double? maiorValor;
  List<FlSpot> chartData1 = [];
  List<FlSpot> chartData_media_movel = [];
  List<FlSpot> chartData_sup_boll = [];
  List<FlSpot> chartData_inf_boll = [];
  List<FlSpot> chartData = [];
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
                  // zoom com scroll
                  enableMouseWheelZooming : true,
                  //zoom com dois toque
                  enableDoubleTapZooming: true,
                  // zoom para celular com dois dedos
                  enablePinching: true,
                  zoomMode: ZoomMode.xy,
                    enablePanning: true,
                  
                 
                );
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    jsonData = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes.json');
    jsonData1 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel.json');
    jsonData2 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_bandas_boll.json');

    view = jsonDecode(jsonData);
    view2 = jsonDecode(jsonData1);
    view3 = jsonDecode(jsonData2);

    quant = view['Close'].length;
    for (int a = 0; a < view['Close'].length; a++) {
      predicaoValor.insert(a, view['Close'][a.toString()]);
      chartData.insert(a, FlSpot(a.toDouble(), view['Close'][a.toString()]));
    }

    double contador = 13;
    for (int a = 0; a < view2['media movel'].length; a++) {
      chartData_media_movel.insert(a, FlSpot(contador, view2['media movel'][a.toString()]));
      contador += 1;
    }

    contador = 13;
    for (int a = 0; a < view3['banda sup boll'].length; a++) {
      chartData_sup_boll.insert(a, FlSpot(contador, view3['banda sup boll'][a.toString()]));
      contador += 1;
    }

    contador = 13;
    for (int a = 0; a < view3['banda inf boll'].length; a++) {
      chartData_inf_boll.insert(a, FlSpot(contador, view3['banda inf boll'][a.toString()]));
      contador += 1;
    }

    menorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual < elemento ? valorAtual : elemento);
    maiorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual > elemento ? valorAtual : elemento);
    maiorValor = double.parse(maiorValor!.toStringAsFixed(0)) + 5;
    menorValor = double.parse(menorValor!.toStringAsFixed(0)) - 5;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       body: SafeArea(child: Center(
            child: Container(
              child:/*SfChartTheme(
                data: SfChartThemeData(
                        brightness: Brightness.dark, 
                        backgroundColor: Colors.black87
                ),
          
          child:*/ SfCartesianChart(
            
            legend: Legend(isVisible: true,  position: LegendPosition.bottom),
            primaryXAxis: NumericAxis(
              interval: 35,
              
              title: AxisTitle(text: 'Data'),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(
              interval: 10,
              title: AxisTitle(text: 'Valor'),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '',
              format: 'point.y',
              builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                final dataX = chartData[pointIndex].x.toInt();
                final closeValue = view['Close'][dataX.toString()].toStringAsFixed(2);
                final mediaMovelValue = view2['media movel'][dataX.toString()].toStringAsFixed(2);
                final supBollValue = view3['banda sup boll'][dataX.toString()].toStringAsFixed(2);
                final infBollValue = view3['banda inf boll'][dataX.toString()].toStringAsFixed(2);

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
                      Text('Data: ${view['Data'][dataX.toString()]}'),
                      Text('Close: $closeValue'),
                      Text('Média Móvel: $mediaMovelValue'),
                      Text('Banda Sup. Bollinger: $supBollValue'),
                      Text('Banda Inf. Bollinger: $infBollValue'),
                    ],
                  ),
                );
              },
            ),
            series: <ChartSeries>[
              LineSeries<FlSpot, double>(
                dataSource: chartData,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.blue,
                name: 'Cotações',
              ),
              LineSeries<FlSpot, double>(
                dataSource: chartData_media_movel,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.orange,
                name: 'Média Móvel',
              ),
              LineSeries<FlSpot, double>(
                dataSource: chartData_sup_boll,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.purple,
                name: 'Banda Sup. Bollinger',
              ),
              LineSeries<FlSpot, double>(
                dataSource: chartData_inf_boll,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.purple[300],
                name: 'Banda Inf. Bollinger',
              ),
            ],
            zoomPanBehavior: _zoomPanBehavior,
          ),
            ),
            ),
       ),
    );
  }
}

