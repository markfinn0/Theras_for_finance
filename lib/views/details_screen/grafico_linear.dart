
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
  late String indicadorFinanca;
  bool mediaVisible = true;
  bool price = true;
  bool dividendos = true;
  bool patrimonio = false;
  bool bandasVisible = false;
  bool rsiVisible = false;
  bool macdVisible = false;
  
  
  GraficoLinear(this.cardIndex, this.tipoGrafico, this.indicador, this.tipoEmpresa, this.indicadorFinanca, {Key? key}) : super(key: key);
  
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

  List<FlSpot> chartDataPatrimonio= [];
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
    ////////////print(widget.tipoEmpresa);
    loadData();
    
  }
  @override
  void didUpdateWidget( GraficoLinear oldWidget) {
  
    if(widget.tipoEmpresa != oldWidget.tipoEmpresa || widget.tipoEmpresa == oldWidget.tipoEmpresa){
    ////////////print(oldWidget.tipoGrafico + ' valor antigo ');
    ////////////print(widget.tipoGrafico + ' valor novo \n\n');
    
    if (widget.tipoGrafico == 'Finanças' && oldWidget.tipoGrafico == 'Price' || widget.tipoGrafico == 'Finanças' && oldWidget.tipoGrafico == 'Finanças' || widget.indicadorFinanca != oldWidget.indicadorFinanca) {
    
    jsonDataDividendos = '';
    jsonDataPatrimonio = '';
    viewDividendos = [];
    viewPatrimonio = [];
    chartDataDividendos = [];
    chartDataDividendosPred = [];
    chartDataPatrimonio = [];
    chartDataDividendosPred = [];
    
    switch(widget.indicadorFinanca){
    case "Dividendos" :
      widget.dividendos = true;
      widget.patrimonio = false;
      break;
    /*case "Patrimônio Líquido":
      widget.patrimonio = true;
      widget.dividendos = false;
      print('estou aqui '+ widget.patrimonio.toString());
      break;*/

    }
    
      
      /*
      widget.price = false;
       
      widget.mediaVisible = false;
      widget.bandasVisible = false;
      jsonData = '';
      jsonData1 = '';
      view = [];
      
      chartData_media_movel = [];
      chartData = [];
      chartData_sup_boll = [];
      chartData_inf_boll = [];*/
      
      
      //loadData();
    }
    else if( widget.tipoGrafico == 'Price' && oldWidget.tipoGrafico == 'Finanças' || widget.tipoGrafico == 'Price' && oldWidget.tipoGrafico == 'Price' || widget.tipoEmpresa != oldWidget.tipoEmpresa || widget.indicador != oldWidget.indicador ){
      
        
        /*widget.price = true;
        widget.mediaVisible = true;
        widget.bandasVisible = false;*/
        ////////////print( 'esse é o indicador' + widget.indicador);

        view = [];
        viewPred = [];

        view2 = [];
        view2Prev = [];
        
        view3 = [];
        view3Prev = [];

        view4 = [];
        view4Prev = [];
        
        view5 = [];
        view5Prev = [];
        
        jsonData = '';
        jsonDataPred = '';

        jsonData1 = '';
        jsonData1Prev = '';
        
        jsonData2 = '';
        jsonData2Prev = '';

        jsonData4 = '';
        jsonData4Prev = '';

        jsonData5 = '';
        jsonData5Prev = '';

        
        

        chartData = [];
        chartDataPred = [];
        
        chartData_media_movel = [];
        chartDataPrev_media_movel = [];
        
        
        chartData_rsi = [];
        chartDataPrev_rsi = [];
        
        chartData_macd = [];
        chartDataPrev_macd = [];
      
        chartData_sup_boll = [];
        chartDataPrev_sup_boll = [];
        

        chartData_inf_boll = [];
        chartDataPrev_inf_boll = [];

        switch(widget.indicador){
          case 'Média Móvel 14':
            widget.mediaVisible = true;
            break;
          case 'Bollinger Bands':
         
            widget.bandasVisible = true;
            widget.mediaVisible = false;
            break;
          case 'RSI':
            widget.rsiVisible = true;
            widget.bandasVisible = false;
            widget.mediaVisible = false;
            widget.price = false;
            break;
          case 'MACD':
            widget.rsiVisible = false;
            widget.bandasVisible = false;
            widget.mediaVisible = false;
            widget.price = false;
            widget.macdVisible = true;
            break;
             

          default:
            widget.mediaVisible = false;
            widget.price = false;
       
            
            widget.bandasVisible = false;
        }
      }
      
      

      //loadData();
    }
    
    else{
      widget.price = true;
      widget.mediaVisible = true;
      widget.bandasVisible = false;
      view = [];
      jsonData = '';
      jsonData1 = '';
      
      chartData_media_movel = [];
      chartData = [];
      chartData_sup_boll = [];
      chartData_inf_boll = [];
      
    }
    
    loadData();
    
    super.didUpdateWidget(oldWidget);
  }

  Future<void> loadData() async {
    
    ////////////print(jsonDecode(jsonData)[0]['tick']);
    //////////print('olha aqui: ' + widget.price.toString());
   //print(widget.tipoGrafico);
    if(widget.tipoGrafico == 'Price'){
        
          jsonData = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes.json');
          view = jsonDecode(jsonData); 
          RegExp alphanumeric = RegExp(r'\d{1,5}');
          for(var a = 0; a < view.length; a++){
            ////////////print('estou aqui' + a.toString());
            ////////////print(widget.tipoEmpresa);
            late String number;
            Iterable<RegExpMatch> matches = alphanumeric.allMatches(widget.tipoEmpresa);
            for (RegExpMatch match in matches) {
              number = match.group(0).toString();
            }
            if(view[a]['codigo tick'] == number){
              //////////print('olhaaa: ' + a.toString());
              index_empresa = a;
              break;
            }

          }
          

        if(widget.price == true){
          //quant = view[index_empresa]['Close'].length;

          jsonDataPred = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes_predicao.json');
          viewPred = jsonDecode(jsonDataPred);
          ////////print(view[index_empresa]['Close'].length);
          int contagem = 0;
          
          for (int a = view[index_empresa]['Close'].length; a < (view[index_empresa]['Close'].length)+13; a++) {
            ////////print(a);
            chartDataPred.insert(contagem, FlSpot(a.toDouble(), viewPred[index_empresa]['resultado'][a.toString()]));
            
            contagem++;
          }
          ////////print(chartDataPred);
          
          for (int a = 0; a < view[index_empresa]['Close'].length; a++) {
            //predicaoValor.insert(a, view[index_empresa]['Close'][a.toString()]);
            chartData.insert(a, FlSpot(a.toDouble(), view[index_empresa]['Close'][a.toString()]));
          }
          /*menorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual < elemento ? valorAtual : elemento);
          maiorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual > elemento ? valorAtual : elemento);
          maiorValor = double.parse(maiorValor!.toStringAsFixed(0)) + 5;
          menorValor = double.parse(menorValor!.toStringAsFixed(0)) - 5;*/
        }  
          
      switch  (widget.indicador){
        case "Média Móvel 14":
          jsonData1 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel.json');
          view2 = jsonDecode(jsonData1);
          double contador = 13;
          
          for (int a = 0; a < view2[index_empresa]['media movel'].length; a++) {
            chartData_media_movel.insert(a, FlSpot(contador, view2[index_empresa]['media movel'][a.toString()]));
            contador += 1;
          }
          
          /*jsonDataPred = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes_predicao.json');
          viewPred = jsonDecode(jsonDataPred);
          ////////print(view[index_empresa]['Close'].length);
          int contagem = 0;
          
          for (int a = view[index_empresa]['Close'].length; a < (view[index_empresa]['Close'].length)+13; a++) {
            ////////print(a);
            chartDataPred.insert(contagem, FlSpot(a.toDouble(), viewPred[index_empresa]['resultado'][a.toString()]));
            
            contagem++;
          }*/
          jsonData1Prev = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_media_movel_predicao.json');
        
          view2Prev = jsonDecode(jsonData1Prev);
          

          int contador_prev_media = 0;
          
          int tamanho = view2[index_empresa]['media movel'].length + (view2Prev[index_empresa]['media movel'].length) + 13; /*remover essa soma quando arrumar os dados de media movel */
          




          //int contador_tamanho = tamanho;
          ////////print(view2[index_empresa]['media movel'].length+ (view2Prev[index_empresa]['media movel'].length-1));
          //////print(tamanho);
          for (int a = view2[index_empresa]['media movel'].length + 13; a < (tamanho); a++) {
            ////print(view2Prev[index_empresa]['media movel'][a.toString()]);
            chartDataPrev_media_movel.insert(contador_prev_media, FlSpot(a.toDouble(), view2Prev[index_empresa]['media movel'][a.toString()]));
            contador_prev_media +=1;
            
          }
          
          break;

        case "Bollinger Bands":
        ////////////print(widget.mediaVisible);
        
        //dados:
          jsonData2 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_bandas_boll.json');
          view3 = jsonDecode(jsonData2);
          double contador = 13;
          for (int a = 0; a < view3[index_empresa]['banda sup boll'].length; a++) {
            chartData_sup_boll.insert(a, FlSpot(contador, view3[index_empresa]['banda sup boll'][a.toString()]));
            contador += 1;
          }
          contador = 13;
          for (int a = 0; a < view3[index_empresa]['banda inf boll'].length; a++) {
            chartData_inf_boll.insert(a, FlSpot(contador, view3[index_empresa]['banda inf boll'][a.toString()]));
            contador += 1;            
        }
        //Dados prev_inf:
        jsonData2Prev = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_bandas_boll_predicao.json');
        view3Prev = jsonDecode(jsonData2Prev);
        int contador_prev_sup_boll = 0;
        
        int tamanho = view3[index_empresa]['banda sup boll'].length + (view3Prev[index_empresa]['banda sup boll'].length);
        int contador_tamanho = tamanho;
        for (int a = view3[index_empresa]['banda sup boll'].length; a < (tamanho); a++) {
          chartDataPrev_sup_boll.insert(contador_prev_sup_boll, FlSpot(double.parse(contador_tamanho.toString()), view3Prev[index_empresa]['banda sup boll'][a.toString()]));
          contador_prev_sup_boll +=1;
          contador_tamanho+=1;
        }

        
        //Dados prev_inf:
        jsonData2Prev = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_bandas_boll_predicao.json');
        view3Prev = jsonDecode(jsonData2Prev);
        int contador_prev_inf_boll = 0;
        
        tamanho = view3[index_empresa]['banda inf boll'].length + (view3Prev[index_empresa]['banda inf boll'].length);
        contador_tamanho = tamanho;
        for (int a = view3[index_empresa]['banda inf boll'].length; a < (tamanho); a++) {
          chartDataPrev_inf_boll.insert(contador_prev_inf_boll, FlSpot(double.parse(contador_tamanho.toString()), view3Prev[index_empresa]['banda inf boll'][a.toString()]));
          contador_prev_inf_boll +=1;
          contador_tamanho+=1;
        }
        
        case "RSI":
          /*jsonData = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_cotacoes.json');
          view = jsonDecode(jsonData);
          quant = view[index_empresa]['Close'].length;*/
          
          /*for (int a = 0; a < view[index_empresa]['Close'].length; a++) {
            predicaoValor.insert(a, view[index_empresa]['Close'][a.toString()]);
            chartData.insert(a, FlSpot(a.toDouble(), view[index_empresa]['Close'][a.toString()]));
          }*/
          /*menorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual < elemento ? valorAtual : elemento);
          maiorValor = predicaoValor.reduce((valorAtual, elemento) => valorAtual > elemento ? valorAtual : elemento);
          maiorValor = double.parse(maiorValor!.toStringAsFixed(0)) + 5;
          menorValor = double.parse(menorValor!.toStringAsFixed(0)) - 5;*/

          jsonData4 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_rsi.json');
          view4 = jsonDecode(jsonData4);
          //////print(view4[index_empresa]['Ind-forc-relat']["1"]);
          double contador = 13;
          for (int a = 0; a < view4[index_empresa]['Ind-forc-relat'].length; a++) {
            chartData_rsi.insert(a, FlSpot(contador, view4[index_empresa]['Ind-forc-relat'][a.toString()]));
            contador += 1;
          }

          jsonData4Prev = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_rsi_predicao.json');
          view4Prev = jsonDecode(jsonData4Prev);
          int contador_prev_rsi = 0;
          
          int tamanho = view4[index_empresa]['Ind-forc-relat'].length + (view4Prev[index_empresa]['Ind-forc-relat'].length);
          int contador_tamanho = tamanho;
          ////////print(view2[index_empresa]['media movel'].length+ (view2Prev[index_empresa]['media movel'].length-1));
          //////print(tamanho);
          for (int a = view4[index_empresa]['Ind-forc-relat'].length; a < (tamanho); a++) {
            
            chartDataPrev_rsi.insert(contador_prev_rsi, FlSpot(double.parse(contador_tamanho.toString()), view4Prev[index_empresa]['Ind-forc-relat'][a.toString()]));
            contador_prev_rsi +=1;
            contador_tamanho+=1;
          }

          ////////print('rsi visible: '+ widget.rsiVisible.toString());
          ////////print('finance visible: ' + widget.price.toString());
        break;
        case 'MACD':
        //Dados:
          jsonData5 = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_macd.json');
          view5 = jsonDecode(jsonData5);
          
          double contador = 13;
          for (int a = 0; a < view5[index_empresa]['macd'].length; a++) {
            chartData_macd.insert(a, FlSpot(contador, view5[index_empresa]['macd'][a.toString()]));
            contador += 1;
          }


          jsonData5Prev = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_macd_predicao.json');
          view5Prev = jsonDecode(jsonData5Prev);
          int contador_prev_macd = 0;
          
          int tamanho = view5[index_empresa]['macd'].length + (view5Prev[index_empresa]['macd'].length);
          int contador_tamanho = tamanho;
          ////////print(view2[index_empresa]['media movel'].length+ (view2Prev[index_empresa]['media movel'].length-1));
          //////print(tamanho);
          for (int a = view5[index_empresa]['macd'].length; a < (tamanho); a++) {
            
            chartDataPrev_macd.insert(contador_prev_macd, FlSpot(double.parse(contador_tamanho.toString()), view5Prev[index_empresa]['macd'][a.toString()]));
            contador_prev_macd +=1;
            contador_tamanho+=1;
          }
          ////////print('macd visible: '+ widget.macdVisible.toString());
          ////////print('finance visible: ' + widget.price.toString());
          break;

        default:
        
          
      }
      
    }
    else{ // carregar dados de finanças
          
          
      switch  (widget.indicadorFinanca){
        case "Dividendos":
        jsonDataDividendos = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_dividends.json');
        viewDividendos = jsonDecode(jsonDataDividendos);
          int contador = 0;
          for (int a = 0; a < viewDividendos.length; a++){
            if(viewDividendos[a]['info'] == 'real'){
              chartDataDividendos.insert(a, FlSpot(a.toDouble(), viewDividendos[a]['valor']));
            }
            else{
              if(contador == 0){
                chartDataDividendosPred.insert(contador, FlSpot(a.toDouble()-1, viewDividendos[a-1]['valor']));
              }
              contador++;
              chartDataDividendosPred.insert(contador, FlSpot(a.toDouble(), viewDividendos[a]['valor'])); 
            }
            
          }
          break;
        /*case "Patrimônio Líquido":
        print(widget.dividendos);
          jsonDataPatrimonio = await rootBundle.loadString('asset/Empresas_data/${widget.cardIndex}_Patrimônio_Líquido.json');
          viewPatrimonio = jsonDecode(jsonDataPatrimonio);
          //print(viewPatrimonio[0]['valor']);
          int contador = 0;
          for (int a = 0; a < viewPatrimonio.length; a++){
            //print(viewPatrimonio[a]['valor']);

            //if(viewPatrimonio[a]['info'] == 'real'){
              chartDataPatrimonio.insert(a, FlSpot(a.toDouble(), viewPatrimonio[a]['valor']));
            //}
            /*else{
              if(contador == 0){
                //chartDataPatrimonioPred.insert(contador, FlSpot(a.toDouble()-1, viewPatrimonio[a-1]['valor']));
              }
              contador++;
              //chartDataPatrimonioPred.insert(contador, FlSpot(a.toDouble(), viewPatrimonio[a]['valor'])); 
            }*/
            //print(chartDataPatrimonio);
            
          }
          //print(chartDataPatrimonio);
        

        break;*/


        //default:
        
          
      }

      
    }
    
    
    
    
      
    

    
   
   
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tipoGrafico == 'Price') {

      return Scaffold(
      
       body: SafeArea(child: Center(
            child: Container(
               child:/*SfChartTheme(
                data: SfChartThemeData(
                        brightness: Brightness.dark, 
                        backgroundColor: Colors.black87
                ),
          
          child:*/ SfCartesianChart(
            
              legend: Legend(isVisible: true,  position: LegendPosition.right),
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
              builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                late final dataX;
                late final closeValue; 

                late final dataXPred;
                late final closeValuePred;
                late final dataValuePred;

                late final dataMediaPred, mediaMovelValue, mediaMovelPredValue;
                
                final indexLine = seriesIndex;
                if (seriesIndex == 0) { // cotação
                  //////print('olha: ' + series.toString());
                ////print('olha 1: '+ data.toString()); //retorna o indice e o valor da posicao do mouse
                //////print('olha 2: ' + point.toString());
                ////print('olha 3: ' + pointIndex.toString()); // retorna o indice da posicao do mouse
                ////print('olha 4: ' +seriesIndex.toString()); // retorna a linha da posicao do mouse
                dataX = chartData[pointIndex].x.toInt();
                closeValue = view[index_empresa]['Close'][dataX.toString()].toStringAsFixed(2);
                }
                else if(seriesIndex == 1){ //cotação predicao
                dataXPred = chartDataPred[pointIndex].x.toInt();
                ////print('indice '+ dataXPred.toString());
                closeValuePred = viewPred[index_empresa]['resultado'][dataXPred.toString()].toStringAsFixed(2);
                
                dataValuePred = viewPred[index_empresa]['data'][dataXPred.toString()];
                ////print(viewPred[index_empresa]['resultado'][dataXPred.toString()]);

                }
                else if(seriesIndex == 2){ //media movel
                  dataX = chartData[pointIndex].x.toInt();
                  //dataMediaPred = chartDataPrev_media_movel[pointIndex].x.toInt();
                  mediaMovelValue = view2[index_empresa]['media movel'][dataX.toString()].toStringAsFixed(2);
                }
                else if(seriesIndex == 3){//media movel pred
                  dataMediaPred = chartDataPrev_media_movel[pointIndex].x.toInt();
                  //print(dataMediaPred);
                  dataValuePred = viewPred[index_empresa]['data'][dataMediaPred.toString()];
                  mediaMovelPredValue = view2Prev[index_empresa]['media movel'][dataMediaPred.toString()].toStringAsFixed(2);
                }
                else if(seriesIndex == 4){ // 
                /*4 - Banda Sup. Bollinger
                5- Pred. Banda Sup. Bollinger
                6- Banda Inf. Bollinger
                7- Pred. Banda Inf. Bollinger
                8- Indice Força Rel.
                9- Pred. Indice Força Rel.
                10- MACD
                11- Pred. MACD */
                }
                else if(seriesIndex == 5){

                }
                else if(seriesIndex == 6){

                }
                else if(seriesIndex == 7){

                }
                else if(seriesIndex == 8){

                }
                else if(seriesIndex == 9){

                }
                else if(seriesIndex == 10){

                }
                
                
                
                
                
                
              
          
                //////print("estou aqui "+ dataX.toString());
                /*////print(dataX);
                

                
                
                final dataRSI = chartData_rsi[pointIndex].x.toInt();

                final dataPrevRSI = chartDataPrev_rsi[pointIndex].x.toInt();
                final dataPrevInfBoll = chartDataPrev_inf_boll[pointIndex].x.toInt();
                

                final dataMACD = chartData_macd[pointIndex].x.toInt();

                
                
                
                
                
                
                final supBollValue = view3[index_empresa]['banda sup boll'][dataX.toString()].toStringAsFixed(2);
                final infBollValue = view3[index_empresa]['banda inf boll'][dataX.toString()].toStringAsFixed(2);
                final infBollPrevValue = view3Prev[index_empresa]['banda inf boll'][dataPrevInfBoll.toString()].toStringAsFixed(2);
                final supBollPrevValue = view3Prev[index_empresa]['banda sup boll'][dataPrevInfBoll.toString()].toStringAsFixed(2);
                final indForRelValue = view4[index_empresa]['Ind-forc-relat'][dataRSI.toString()].toStringAsFixed(2);
                final indForRelPrevValue = view4Prev[index_empresa]['Ind-forc-relat'][dataPrevRSI.toString()].toStringAsFixed(2);
                final macdValue = view5[index_empresa]['macd'][dataMACD.toString()].toStringAsFixed(2);*/
                
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
                      if(widget.price && indexLine == 0)Text('Data: ${view[index_empresa]['Data'][dataX.toString()]}'),
                      if(widget.price && indexLine == 0) Text('Close: $closeValue'),

                      if(widget.price && indexLine == 1) Text('Data: $dataValuePred'),
                      if(widget.price && indexLine == 1) Text('Pred. Close: $closeValuePred'),

                      if(widget.price && indexLine == 2)Text('Data: ${view[index_empresa]['Data'][dataX.toString()]}'),
                      if(widget.mediaVisible && indexLine == 2) Text('Média Móvel: $mediaMovelValue'),
                      
                      if(widget.price && indexLine == 3) Text('Data: $dataValuePred'),
                      if(widget.mediaVisible && indexLine == 3) Text('Pred. Média Móvel: $mediaMovelPredValue'),

                      /*if(widget.bandasVisible) Text('Banda Sup. Bollinger: $supBollValue'),
                      if(widget.bandasVisible) Text('Pred. Banda Sup. Bollinger: $supBollPrevValue'),
                      if(widget.bandasVisible) Text('Banda Inf. Bollinger: $infBollValue'),
                      if(widget.bandasVisible) Text('Pred. Banda Inf. Bollinger: $infBollPrevValue'),
                      if(widget.rsiVisible) Text('Indice Força Rel.: $indForRelValue'),
                      if(widget.rsiVisible) Text('Indice Força Rel.: $indForRelPrevValue'),
                      if(widget.macdVisible) Text('MACD.: $macdValue'),*/
                    ],
                  ),
                );
              },
            ),
             series: <ChartSeries>[  // 0
               LineSeries<FlSpot, double>(
                isVisible: widget.price,
                dataSource: chartData,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.blue,
                name: 'Cotações',
              ), 
              LineSeries<FlSpot, double>( // 1
                isVisible: widget.price,
                dataSource: chartDataPred,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: const Color.fromARGB(255, 109, 7, 0),
                name: 'Pred. Cotações',
              ), 
              
              LineSeries<FlSpot, double>( //2
                isVisible: widget.mediaVisible,
                dataSource: chartData_media_movel,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.orange,
                name: 'Média Móvel',
              ),
              LineSeries<FlSpot, double>( // 3
                isVisible: widget.mediaVisible,
                dataSource: chartDataPrev_media_movel,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: const Color.fromARGB(255, 180, 74, 66),
                name: 'Pred. Média Móvel',
              ),
              LineSeries<FlSpot, double>( // 4
                isVisible: widget.bandasVisible,
                dataSource: chartData_sup_boll,
                //animationDelay: 50,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.purple,
                name: 'Banda Sup. Bollinger',
              ),
              LineSeries<FlSpot, double>( // 5
                isVisible: widget.bandasVisible,
                dataSource: chartDataPrev_sup_boll,
                //animationDelay: 50,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Color.fromARGB(255, 155, 0, 0),
                name: 'Pred. Banda Sup. Bollinger',
              ),
              LineSeries<FlSpot, double>( // 6
                isVisible: widget.bandasVisible,
                dataSource: chartData_inf_boll,
                //animationDelay: 300,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.purple[600],
                name: 'Banda Inf. Bollinger',
              ),
              LineSeries<FlSpot, double>( // 7 
                isVisible: widget.bandasVisible,
                dataSource: chartDataPrev_inf_boll,
                //animationDelay: 300,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: const Color.fromARGB(255, 138, 16, 7),
                name: 'Pred. Banda Inf. Bollinger',
              ),
              LineSeries<FlSpot, double>( // 8
                isVisible: widget.rsiVisible,
                dataSource: chartData_rsi,
                //animationDelay: 300,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.green,
                name: 'Indice Força Rel.',
              ),
              LineSeries<FlSpot, double>( // 9 
                isVisible: widget.rsiVisible,
                dataSource: chartDataPrev_rsi,
                //animationDelay: 300,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Color.fromARGB(255, 99, 15, 0),
                name: 'Pred. Indice Força Rel.',
              ),
              LineSeries<FlSpot, double>( // 10
                isVisible: widget.macdVisible,
                dataSource: chartData_macd,
                //animationDelay: 300,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: const Color.fromARGB(255, 1, 21, 54),
                name: 'MACD',
              ),
              LineSeries<FlSpot, double>( // 11
                isVisible: widget.macdVisible,
                dataSource: chartDataPrev_macd,
                //animationDelay: 300,
                //animationDuration: 10000,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Color.fromARGB(255, 153, 13, 13),
                name: 'Pred. MACD',
              ),
            ],
            zoomPanBehavior: _zoomPanBehavior,
          ),
            ),
            ),
       ),
    );
  }else {
    print(widget.patrimonio);
    return Scaffold(
      
       body: SafeArea(child: Center(
            child: Container(
               child: SfCartesianChart(
            
              legend: Legend(isVisible: true,  position: LegendPosition.right),
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
              builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                
                late final positionDividendosValue;
                late final positionDividendosPredValue;

                late final DividendosValue;
                late final DividendosPredValue;
                var indexLine = seriesIndex;

                if (seriesIndex == 0) { 
                positionDividendosValue = chartDataDividendos[pointIndex].x.toInt();
                DividendosValue = viewDividendos[positionDividendosValue]['valor'].toStringAsFixed(2);
                
                }
                if(seriesIndex == 1){
                  positionDividendosPredValue = chartDataDividendosPred[pointIndex].x.toInt();
                  DividendosPredValue = viewDividendos[positionDividendosPredValue]['valor'].toStringAsFixed(2);
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
                      if(indexLine == 0)Text('Data: ${viewDividendos[positionDividendosValue]['data']}'),
                      if(indexLine == 0)Text('Dividendo: $DividendosValue'),
                     
                      if(indexLine == 1)Text('Data: ${viewDividendos[positionDividendosPredValue]['data']}'),
                      if(indexLine == 1)Text('Dividendo: $DividendosPredValue'),
                      
                    ],
                  ),
                );
              },
            ),
             series: <ChartSeries>[  // 0
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
              /*LineSeries<FlSpot, double>(
                isVisible: widget.patrimonio,
                dataSource: chartDataPatrimonioPred,
                xValueMapper: (FlSpot spot, _) => spot.x,
                yValueMapper: (FlSpot spot, _) => spot.y,
                color: Colors.red,
                name: 'Pred. Patrimonio',
              ), */
              
            ],
            zoomPanBehavior: _zoomPanBehavior,
          ),
            ),
            ),
       ),
    );
  }
  }
  
}