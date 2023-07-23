import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
  List<FlSpot> chartData = [
    const FlSpot(0, 2),
    const FlSpot(1, 5),
    const FlSpot(2, 4),
    const FlSpot(3, 7),
    const FlSpot(4, 6),
    const FlSpot(5, 10),
    const FlSpot(6, 9),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 32, 50, 50),
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
      body: SizedBox(
        height: 1200,
        child: Stack(
          children: <Widget>[
            const Positioned(
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
            const Positioned(
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
                  "AZUL4",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
            const Positioned(
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
                          dotData: const FlDotData(
                            show: false,
                          ),
                          color: Colors.blue,
                          barWidth: 3,
                        ),
                      ],
                      borderData: FlBorderData(
                          border: const Border(
                              bottom: BorderSide(), left: BorderSide())),
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(
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
            const Positioned(
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
            const Positioned(
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
                color: const Color.fromRGBO(8, 32, 50, 50),
                child: const Row(
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

  DetailsScreen(this.cardIndex, {super.key});
  List<FlSpot> chartData = [
    const FlSpot(0, 2),
    const FlSpot(1, 5),
    const FlSpot(2, 4),
    const FlSpot(3, 7),
    const FlSpot(4, 6),
    const FlSpot(5, 10),
    const FlSpot(6, 9),
  ];
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
          title: const Row(
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
        body: const Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green, // Cor do fundo
                ),
                child: SizedBox(
                  height: 15, // Altura do bottom pintado
                ),
              ),
            ),
          ],
        ));
  }
}
