import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var lado = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;
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
            child: Stack(children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 400, vertical: 15),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Pesquisar Empresa',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 212, 212, 212),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                  future: rootBundle.loadString('asset/data.json'),
                  builder: (context, snapshot) {
                    List<dynamic> view = jsonDecode(snapshot.data!);

                    return GridView.builder(
                        itemCount: view.length,
                        shrinkWrap: true, // Defina shrinkWrap como true
                        // Desative o scroll do GridView
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // Número de colunas por linha
                          childAspectRatio:
                              2, // Proporção desejada entre largura e altura dos itens
                        ),
                        itemBuilder: (context, index) {
                          var tick = view[index]['tick'];
                          var sector = view[index]['sector'];
                          var PM = view[index]['PM'];
                          var PL = view[index]['PL'];
                          //var Symbol = view[index]['Symbol'];
                          var Gain = view[index]['Gain'];
                          //var color = view[index]['color'];
                          var CMP = view[index]['CMP'];
                          return InkWell(
                              onTap: () {
                                // Redirecionamento para outra tela com informações do card
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsScreen(tick)),
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
                                      child: AspectRatio(
                                        aspectRatio: 2,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              right: lado * 0.12,
                                              child: Container(
                                                width: lado * 0.06,
                                                height: altura * 0.09,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    tick,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .black, // Cor do texto
                                                      fontSize: lado * 0.025,
                                                    ),
                                                    // Cor do fundo
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
                                                      color: Colors
                                                          .black, // Cor do texto
                                                      fontSize: 15,
                                                    ),
                                                    // Cor do fundo
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
                                                      color: Colors
                                                          .black, // Cor do texto
                                                      fontSize: 10,
                                                    ),
                                                    // Cor do fundo
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
                                                      color: Colors
                                                          .black, // Cor do texto
                                                      fontSize: 24,
                                                    ),
                                                    // Cor do fundo
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
                                                      color: Colors
                                                          .black, // Cor do texto
                                                      fontSize: 10,
                                                    ),
                                                    // Cor do fundo
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
                                                      color: Colors
                                                          .black, // Cor do texto
                                                      fontSize: 24,
                                                    ),
                                                    // Cor do fundo
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                  color: Colors
                                                      .green, // Cor do fundo
                                                ),
                                                child: SizedBox(
                                                  height:
                                                      15, // Altura do bottom pintado
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))));
                        });
                  },
                )),
                Positioned(
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
              ]))
            ])));
  }
}

class DetailsScreen extends StatelessWidget {
  final String cardIndex;

  DetailsScreen(this.cardIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Card $cardIndex'),
      ),
      body: Center(
        child: Text('Conteúdo do Card $cardIndex'),
      ),
    );
  }
}
