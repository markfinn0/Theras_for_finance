import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'THΞRAS'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(8, 32, 50, 50),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,

        actions: [
          IconButton(
            icon: Icon(
              Icons.report,
            ),
            onPressed: () {
              // Ação ao clicar no botão de busca
            },
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
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                  const CardExample(),
                                ],
                              ),
                            ),
                            Container(
                              child: Container(
                                height: 60,
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
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          width: 290,
          height: 150,
          color: Color.fromRGBO(245, 245, 245, 10),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(245, 245, 245, 50),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                        'AZUL4',
                        style: TextStyle(
                          color: Colors.black, // Cor do texto
                          fontSize: 30,
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
                        'Aviação',
                        style: TextStyle(
                          color: Colors.black, // Cor do texto
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
                          color: Colors.black, // Cor do texto
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
                        '24,50',
                        style: TextStyle(
                          color: Colors.black, // Cor do texto
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
                          color: Colors.black, // Cor do texto
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
                        '2 BI',
                        style: TextStyle(
                          color: Colors.black, // Cor do texto
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
                  top: 60,
                  left: 142,
                  right: 95,
                  child: Container(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '+6%',
                        style: TextStyle(
                            color: Colors.green, // Cor do texto
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        // Cor do fundo
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
                      color: Colors.green, // Cor do fundo
                    ),
                    child: SizedBox(
                      height: 15, // Altura do bottom pintado
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
