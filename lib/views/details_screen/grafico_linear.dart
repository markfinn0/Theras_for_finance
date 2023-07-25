
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






































/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

late String jsonData;
late String jsonData1;
late String jsonData2;
List <dynamic> predicaoValor = [];


class GraficoLinear extends StatefulWidget {
  final String cardIndex;

  GraficoLinear(this.cardIndex, {Key? key}) : super(key: key);
  
  @override
  _GraficoLinearState createState() => _GraficoLinearState();
}

class _GraficoLinearState extends State<GraficoLinear> {
  
  //List<dynamic> view = [];
  //List<dynamic> view2 = [];
  
  var inicio;
  late Map<String, dynamic> view;
  late Map<String, dynamic> view2;
  late Map<String, dynamic> view3;
  double ?quant;
  double ?menorValor;
  double ?maiorValor;
  List<FlSpot> chartData1 = [];
  List<FlSpot> chartData_media_movel = [];
  List<FlSpot> chartData_sup_boll= [];
  List<FlSpot> chartData_inf_boll= [];
  List<FlSpot> chartData = [];
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 9,
    );
    Widget text;
    String texto = view['Data'][value.toString()];
    text = Text(texto, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -90,

      space: 10,
      child: text,
      
    );
  }
  Future<List<FlSpot>> testandoFunc() async {
    
    jsonData = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes.json');
    jsonData1 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel.json');
    //String jsonData2 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel.json');
    jsonData2 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_bandas_boll.json');
    //print(widget.cardIndex);
    view = jsonDecode(jsonData);
    view2 = jsonDecode(jsonData1);
    view3 = json.decode(jsonData2);
    //Map<String, dynamic> view4 = json.decode(jsonData3);


    //print(view);
    quant = view['Close'].length;//determinando limites no eixo x do grafico
    
    //setando o array com os valores de cotação no grafico
    for(int a = 0; a < view['Close'].length; a++){
      predicaoValor.insert(a,view['Close'][a.toString()]);
      chartData.insert(a, FlSpot(a.toDouble(), view['Close'][a.toString()]));
      
    }
    
    // localizando onde começam as predicoes
  /*  view['Data'].forEach((chave, valor) {
    if (valor == view2['data'][("0").toString()]) {
      inicio = double.parse(chave);
    }
  });*/

    // setando os valores de predição no grafico
    /*for(int a = 0; a < view2['resultado'].length; a++){
      chartData1.insert(a, FlSpot((inicio+=1).toDouble(), view2['resultado'][a.toString()]));
    }*/
    //setando os valores de media movel no grafico plotados 14 semanas a frente 
    double contador = 13;
    for(int a = 0; a < view2['media movel'].length; a++){
      
      chartData_media_movel.insert(a, FlSpot(contador, view2['media movel'][a.toString()]));
      contador+=1;
      
    }
    // setando os valores de banda sup bollinger no grafico plotados a 14 semanas a frente 
    contador = 13;
    for(int a = 0; a < view3['banda sup boll'].length; a++){
      
      chartData_sup_boll.insert(a, FlSpot(contador, view3['banda sup boll'][a.toString()]));
      contador+=1;
      
    }
    //setando os dados inf boll
    contador = 13;
    for(int a = 0; a < view3['banda inf boll'].length; a++){
      
      chartData_inf_boll.insert(a, FlSpot(contador, view3['banda inf boll'][a.toString()]));
      contador+=1;
      
    }
    
    //determinando limites no tamanho do grafico
    menorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual < elemento ? valorAtual : elemento);
    maiorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual > elemento ? valorAtual : elemento);
    maiorValor = double.parse(maiorValor!.toStringAsFixed(0)) + 5;
    menorValor = double.parse(menorValor!.toStringAsFixed(0)) - 5;
    
    

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlSpot>>(
      future: testandoFunc(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Aqui você pode mostrar algum indicador de carregamento enquanto os dados estão sendo processados.
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          // Caso ocorra um erro durante o processamento dos dados, você pode tratar aqui.
          return Text('Erro ao carregar os dados');
        } else {
          // Quando os dados estiverem prontos, você pode construir o gráfico.
          chartData = snapshot.data ?? [];
          return LineChart(LineChartData(
            // detalhes de iteração do grafico
            /*lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.white,
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot;
                        /*if (flSpot.x == 0 || flSpot.x == 6) {
                          return null;
                        }*/

                        
                        

                        return LineTooltipItem(
                          '${view['Data'][flSpot.x.toString()]}\n',
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [const TextSpan(
                              text: 'Close: ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                
                              ),
                            ),
                            TextSpan(
                              text: flSpot.y.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            /*const TextSpan(
                              text: ' k ',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900,
                              ),
                            ),*/
                            
                          ],
                          textAlign: TextAlign.center,
                        );
                      }).toList();
                    },
                  ),),
*/
      lineBarsData: [
        //cotacoes:
        LineChartBarData( 
          spots: chartData,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.blue,
          barWidth: 1.5,
        ),
        /*//predicoes:
        LineChartBarData(
          spots: chartData1,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.red,
          barWidth: 3,
        ),
        *///media movel:
        LineChartBarData(
          spots: chartData_media_movel,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.orange,
          barWidth: 1.5,
        ),
        // banda sup boll
        LineChartBarData(
          spots: chartData_sup_boll,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: const Color.fromARGB(255, 194, 98, 211),
          barWidth: 1.5,
        ),
        // banda inf boll
        LineChartBarData(
          spots: chartData_inf_boll,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: const Color.fromARGB(255, 194, 98, 211),
          barWidth: 1.5,
        ),
        
      ],
      titlesData:FlTitlesData(show: true, 
      
      leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 40, showTitles: true, interval: 10)), 
      
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 40, )), 
      
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 40)), 
      
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: 35, getTitlesWidget: bottomTitleWidgets)), 
      
      
      
      ), 
      borderData: FlBorderData(border: Border.all(color: Colors.black, width: 5.0, style: BorderStyle.solid)),
      minX: 0,
      maxX: null,//quant,
      minY: menorValor,
      maxY: maiorValor,
      backgroundColor: Colors.black87
      //clipData: FlClipData.none(),
    
    )
            // Resto do seu código do gráfico
          );
        }
      },
    );
  }
}
*/














/*class GraficoLinear extends StatelessWidget {
  List<dynamic> view = [];
  
  List<dynamic> filteredView = [];
  String cardIndex;
  double ?menorValor;
  double ?maiorValor;
  List <dynamic> predicaoValor = [];
  final List<FlSpot> chartData = [
    const FlSpot(0, 2),
    const FlSpot(1, 5),
    const FlSpot(2, 4),
    const FlSpot(3, 7),
    const FlSpot(4, 6),
    const FlSpot(5, 10),
    const FlSpot(6, 9),
    const FlSpot(7, 2),
    const FlSpot(8, 5),
    const FlSpot(9, 4),
    const FlSpot(10, 7),
    const FlSpot(11, 6),
    const FlSpot(12, 10),
    const FlSpot(13, 9),
  ];
  GraficoLinear(this.cardIndex, {super.key});
  
  Future<void> testandoFunc() async {
    String jsonData = await rootBundle.loadString('asset/Empresas_data/' + cardIndex + '_fundamentalist.json');
    view = jsonDecode(jsonData);
    filteredView = view;
    print(filteredView['Close']);
    
    for(int a = 0; a < chartData.length; a++){
      predicaoValor.insert(a,filteredView['Close'][a.toString()]);
      chartData[a] = FlSpot(a.toDouble(), filteredView['Close'][a.toString()]);
    }
    menorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual < elemento ? valorAtual : elemento);
    maiorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual > elemento ? valorAtual : elemento);
    maiorValor = double.parse(maiorValor!.toStringAsFixed(2));
    menorValor = double.parse(menorValor!.toStringAsFixed(2));
    print(maiorValor);
    print(menorValor);
    print(chartData);
   
  }
  
  @override
  LineChart build(BuildContext context) {
    testandoFunc();
    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: chartData,
          isCurved: true,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.blue,
          barWidth: 3,
        ),
      ],
      borderData: FlBorderData(
          border: const Border(bottom: BorderSide(), left: BorderSide())),
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(
            axisNameSize: 5,
            sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      minX: 0,
      maxX: 14,
      minY: menorValor,
      maxY: maiorValor,
    ));
  }
}
*/


/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';

late String jsonData;
late String jsonData1;
late String jsonData2;
List <dynamic> predicaoValor = [];


class GraficoLinear extends StatefulWidget {
  final String cardIndex;

  GraficoLinear(this.cardIndex, {Key? key}) : super(key: key);
  
  @override
  _GraficoLinearState createState() => _GraficoLinearState();
}

class _GraficoLinearState extends State<GraficoLinear> {
  
  //List<dynamic> view = [];
  //List<dynamic> view2 = [];
  
  var inicio;
  Map<String, dynamic> ?view;
  late Map<String, dynamic> view2;
  late Map<String, dynamic> view3;
  double ?quant;
  double ?menorValor;
  double ?maiorValor;
  
  List<FlSpot> chartData = [];
  List<FlSpot> chartData1 = [];
  List<FlSpot> chartData_media_movel = [];
  List<FlSpot> chartData_sup_boll= [];
  List<FlSpot> chartData_inf_boll= [];

  List<LineTooltipItem> tooltipItemsLinha1(List<LineBarSpot> touchedBarSpots) {
  return touchedBarSpots.map((barSpot) {
    final flSpot = barSpot;
    return LineTooltipItem(
      '${view['Data'][flSpot.x.toString()]}\n',
      TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      children: [
        const TextSpan(
          text: 'Linha 1: ',
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        TextSpan(
          text: flSpot.y.toString(),
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
      textAlign: TextAlign.center,
    );
  }).toList();
}
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 9,
    );
    Widget text;
    String texto = view['Data'][value.toString()];
    text = Text(texto, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -90,

      space: 10,
      child: text,
      
    );
  }
  Future<List<FlSpot>> testandoFunc() async {
    
    jsonData = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes.json');
    jsonData1 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel.json');
    //String jsonData2 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel.json');
    jsonData2 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_bandas_boll.json');
    //print(widget.cardIndex);
    view = jsonDecode(jsonData);
    view2 = jsonDecode(jsonData1);
    view3 = json.decode(jsonData2);
    //Map<String, dynamic> view4 = json.decode(jsonData3);


    //print(view);
    quant = view['Close'].length;//determinando limites no eixo x do grafico
    
    //setando o array com os valores de cotação no grafico
    for(int a = 0; a < view['Close'].length; a++){
      predicaoValor.insert(a,view['Close'][a.toString()]);
      chartData.insert(a, FlSpot(a.toDouble(), view['Close'][a.toString()]));
      
    }
    
    // localizando onde começam as predicoes
  /*  view['Data'].forEach((chave, valor) {
    if (valor == view2['data'][("0").toString()]) {
      inicio = double.parse(chave);
    }
  });*/

    // setando os valores de predição no grafico
    /*for(int a = 0; a < view2['resultado'].length; a++){
      chartData1.insert(a, FlSpot((inicio+=1).toDouble(), view2['resultado'][a.toString()]));
    }*/
    //setando os valores de media movel no grafico plotados 14 semanas a frente 
    double contador = 13;
    for(int a = 0; a < view2['media movel'].length; a++){
      
      chartData_media_movel.insert(a, FlSpot(contador, view2['media movel'][a.toString()]));
      contador+=1;
      
    }
    // setando os valores de banda sup bollinger no grafico plotados a 14 semanas a frente 
    contador = 13;
    for(int a = 0; a < view3['banda sup boll'].length; a++){
      
      chartData_sup_boll.insert(a, FlSpot(contador, view3['banda sup boll'][a.toString()]));
      contador+=1;
      
    }
    //setando os dados inf boll
    contador = 13;
    for(int a = 0; a < view3['banda inf boll'].length; a++){
      
      chartData_inf_boll.insert(a, FlSpot(contador, view3['banda inf boll'][a.toString()]));
      contador+=1;
      
    }
    
    //determinando limites no tamanho do grafico
    menorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual < elemento ? valorAtual : elemento);
    maiorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual > elemento ? valorAtual : elemento);
    maiorValor = double.parse(maiorValor!.toStringAsFixed(0)) + 5;
    menorValor = double.parse(menorValor!.toStringAsFixed(0)) - 5;
    
    

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlSpot>>(
      future: testandoFunc(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Aqui você pode mostrar algum indicador de carregamento enquanto os dados estão sendo processados.
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          // Caso ocorra um erro durante o processamento dos dados, você pode tratar aqui.
          return Text('Erro ao carregar os dados');
        } else {
          // Quando os dados estiverem prontos, você pode construir o gráfico.
          chartData = snapshot.data ?? [];
          return LineChart(LineChartData(
            // detalhes de iteração do grafico
            lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.white,
                    /*getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      print(touchedBarSpots[0]);
                      return tooltipItemsLinha1(touchedBarSpots);
                    },*/getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  // Criar uma lista para armazenar os tooltips para cada linha
                  List<LineTooltipItem> tooltips = [];

                  // Loop através dos pontos tocados e adicionar tooltips apropriados
                  for (var i = 0; i < touchedBarSpots.length; i++) {
                    print('estou aqui '+ touchedBarSpots.length.toString());
                    
                    final flSpot = touchedBarSpots[i];
                    
                    // Verifique a qual linha pertence o ponto tocado
                    if (i < chartData.length) {
                      // Linha de dados (cotações)
                      tooltips.add(
                        LineTooltipItem(
                          '${view['Data'][flSpot.x.toString()]}\n',
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Cotações: ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: flSpot.y.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                          textAlign: TextAlign.center,
                        ),
                      );
        
                    } else if (i < chartData.length + chartData_media_movel.length) {
                      
                      // Linha da média móvel
                      final index = i - chartData.length;
                      if (index < chartData_media_movel.length) {
                        final mediaMovelSpot = chartData_media_movel[index];
                        tooltips.add(
                          LineTooltipItem(
                            '${view['Data'][mediaMovelSpot.x.toString()]}\n',
                            TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Média Móvel: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: mediaMovelSpot.y.toString(),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    } else {
                      // Linhas adicionais (por exemplo, bandas bollinger)
                      // Adicione as condições para cada linha adicional, se necessário
                    }
                  }

                  return tooltips;
                },
                  ),),

      lineBarsData: [
        //cotacoes:
        LineChartBarData(
          spots: chartData,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.blue,
          barWidth: 1.5,
        ),
        /*//predicoes:
        LineChartBarData(
          spots: chartData1,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.red,
          barWidth: 3,
        ),
        *///media movel:
        LineChartBarData(
          spots: chartData_media_movel,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.orange,
          barWidth: 1.5,
        ),
        // banda sup boll
        LineChartBarData(
          spots: chartData_sup_boll,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: const Color.fromARGB(255, 194, 98, 211),
          barWidth: 1.5,
        ),
        // banda inf boll
        LineChartBarData(
          spots: chartData_inf_boll,
          isCurved: false,
          dotData: const FlDotData(
            show: false,
          ),
          color: const Color.fromARGB(255, 194, 98, 211),
          barWidth: 1.5,
        ),
        
      ],
      titlesData:FlTitlesData(show: true, 
      
      leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 40, showTitles: true, interval: 10)), 
      
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 40, )), 
      
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 40)), 
      
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: 70, getTitlesWidget: bottomTitleWidgets)), 
      
      
      
      ), 
      borderData: FlBorderData(border: Border.all(color: Colors.black, width: 5.0, style: BorderStyle.solid)),
      minX: 0,
      maxX: null,//quant,
      minY: menorValor,
      maxY: maiorValor,
      backgroundColor: Colors.black87
      //clipData: FlClipData.none(),
    
    )
            // Resto do seu código do gráfico
          );
        }
      },
    );
  }
} */