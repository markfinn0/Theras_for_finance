import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theras for Finance',
      home: FutureBuilder(builder: (context, snapshot) {
        return const MyHomePage(title: 'THΞRAS');
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 32, 50, 50),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {},
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        height: 1200,
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 400, vertical: 15),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Pesquisar Empresa',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 212, 212, 212),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: rootBundle.loadString('asset/data.json'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          List<dynamic> view = jsonDecode(snapshot.data!);

                          return GridView.builder(
                            itemCount: view.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 2,
                            ),
                            itemBuilder: (context, index) {
                              var tick = view[index]['tick'];
                              var sector = view[index]['sector'];
                              var PM = view[index]['PM'];
                              var PL = view[index]['PL'];
                              var Gain = view[index]['Gain'];
                              var CMP = view[index]['CMP'];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(tick),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color:
                                            Color.fromRGBO(245, 245, 245, 50),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 150,
                                          child: Container(
                                            height: 75,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                tick,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 68,
                                          left: 0,
                                          right: 150,
                                          child: Container(
                                            height: 60,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                sector,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 200,
                                          right: 0,
                                          child: Container(
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Preço Médio',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 25,
                                          left: 200,
                                          right: 0,
                                          child: Container(
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                PM,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 200,
                                          right: 0,
                                          child: Container(
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'PL',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 82,
                                          left: 200,
                                          right: 0,
                                          child: Container(
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                PL,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 80,
                                          left: 142,
                                          right: 95,
                                          child: Container(
                                            height: 50,
                                            child: Icon(
                                              Icons.trending_up,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 50,
                                          left: 142,
                                          right: 95,
                                          child: Container(
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                Gain,
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 75,
                                          left: 142,
                                          right: 95,
                                          child: Container(
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                CMP,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.green, // Cor do fundo
                                            ),
                                            child: SizedBox(
                                              height:
                                                  15, // Altura do bottom pintado
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('No data available.'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Color.fromRGBO(8, 32, 50, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '© THΞRAS for Finance - APS 2023 - Todos os direitos reservados',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String cardIndex;

  DetailsScreen(this.cardIndex);
  List<FlSpot> chartData = [
    FlSpot(0, 2),
    FlSpot(1, 5),
    FlSpot(2, 4),
    FlSpot(3, 7),
    FlSpot(4, 6),
    FlSpot(5, 10),
    FlSpot(6, 9),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 32, 50, 50),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {},
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'THΞRAS',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        height: 1200,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              bottom: 70,
              left: 30,
              right: 900,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 237, 236, 236), // Cor do fundo
                ),
                child: SizedBox(
                  height: 100, // Altura do bottom pintado
                ),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 550,
              left: 30,
              right: 1300,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.purple, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "$cardIndex",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 360,
              bottom: 300,
              left: 340,
              right: 900,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey, // Cor do fundo
                  ),
                  child: Center(
                    child: Text(
                      "Previsões",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Positioned(
              top: 360,
              bottom: 300,
              left: 30,
              right: 1200,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey, // Cor do fundo
                  ),
                  child: Center(
                    child: Text(
                      "Ultimos Resultados",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Positioned(
              top: 305,
              bottom: 350,
              left: 30,
              right: 900,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Cor do fundo
                  ),
                  child: Center(
                    child: Text(
                      "Indicadores Relativos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Positioned(
              top: 230,
              bottom: 405,
              left: 30,
              right: 900,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red, // Cor do fundo
                ),
                child: Text(
                  "Setor: Aviação e Viagens Aéreas",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 160,
              bottom: 480,
              left: 30,
              right: 900,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.purple, // Cor do fundo
                ),
                child: Text(
                  "Empresa: Companhia Brasileira de Viagens",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 550,
              left: 540,
              right: 900,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "Bom",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 550,
              left: 440,
              right: 1000,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.purple, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "19,50",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 640,
              left: 440,
              right: 1000,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.brown, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "High",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 550,
              left: 340,
              right: 1100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.purple, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "19,50",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 640,
              left: 340,
              right: 1100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.pink, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "Médio",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 550,
              left: 240,
              right: 1200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.yellow, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "19,50",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 640,
              left: 240,
              right: 1200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.pink, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "Low",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: 15,
              bottom: 660,
              left: 30,
              right: 1250,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.pink, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "Ultimo Resultado: Mar-23",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            Positioned(
              top: 400,
              bottom: 70,
              left: 700,
              right: 30,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red, // Cor do fundo
                ),
                child: SizedBox(
                  height: 100, // Altura do bottom pintado
                ),
              ),
            ),
            Positioned(
                top: 90,
                bottom: 320,
                left: 870,
                right: 30,
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: chartData,
                          isCurved: true,
                          dotData: FlDotData(
                            show: false,
                          ),
                          color: Colors.blue,
                          barWidth: 3,
                        ),
                      ],
                      borderData: FlBorderData(
                          border: const Border(
                              bottom: BorderSide(), left: BorderSide())),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            axisNameSize: 5,
                            sideTitles:
                                SideTitles(showTitles: true, reservedSize: 30)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: 12,
                    ),
                  ),
                ))),
            Positioned(
              top: 120,
              bottom: 320,
              left: 700,
              right: 700,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.pink, // Cor do fundo
                ),
                child: SizedBox(
                  height: 100, // Altura do bottom pintado
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 640,
              left: 1350,
              right: 30,
              child: Image.asset('image/Azul.png', width: 300, height: 200),
            ),
            Positioned(
              top: 50,
              bottom: 600,
              left: 700,
              right: 700,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.purple, // Cor do fundo
                ),
                child: Center(
                    child: Text(
                  "Indicadores",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Color.fromRGBO(8, 32, 50, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '© THΞRAS for Finance - APS 2023 - Todos os direitos reservados',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
