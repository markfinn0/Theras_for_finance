import 'package:flutter/material.dart';
import 'grafico_linear.dart';
import './gavetinha.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class DetailsScreen extends StatelessWidget {
  final String cardIndex;
  final String color_company;
  final String PM;
  final String nome_company;
  final String sector;

  final double breakpoint = 800;
  final int paneProportion = 50;

  const DetailsScreen(this.cardIndex, this.color_company, this.PM,
      this.nome_company, this.sector,
      {super.key});

  Widget _getStatusContainer(String colorCompany) {
    Color backgroundColor;
    String status;
    if (colorCompany == 'green') {
      backgroundColor = Colors.green;
      status = 'Desempenho Bom';
    } else if (colorCompany == 'orange') {
      backgroundColor = Colors.orange;
      status = 'Desempenho Médio';
    } else if (colorCompany == 'red') {
      backgroundColor = Colors.red;
      status = 'Desempenho Ruim';
    } else {
      return const SizedBox();
    }

    return borderedContainer(
      status,
      color: backgroundColor,
      corTexto: Colors.white,
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
    );
  }

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
                'T H Ξ R A S',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: FutureBuilder<String>(
              future: rootBundle.loadString(
                  'asset/Empresas_data/${cardIndex}_fundamentalist.json'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  var view = jsonDecode(snapshot.data!);
                  String DY = view[0]['DY'];
                  String UBL = view[0]['UBL'];
                  String MAX = view[0]['MAX'];
                  String MIN = view[0]['MIN'];
                  String PL = view[0]['PL'];
                  String ROE = view[0]['ROE'];
                  String CR5 = view[0]['CR5'];
                  String LPA = view[0]['LPA'];
                  String LucroLiqu = view[0]['LucroLiqu'];
                  String Valormercado = view[0]['Valormercado'];

                  double screenWidth = MediaQuery.of(context).size.width;
                  double screenHeight = MediaQuery.of(context).size.width;

                  return LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                          child: Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minHeight: 600, maxWidth: 1080),
                          child: Column(children: [
                            Container(
                              // padding: const EdgeInsets.only(bottom: 30),
                              padding: EdgeInsets.fromLTRB(
                                  screenWidth > 1000 ? 100 : 0,
                                  0,
                                  screenWidth > 1000 ? 100 : 0,
                                  30),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Flex(
                                          direction: Axis.vertical,
                                          children: [
                                            Text(
                                              "Último Resultado: $UBL",
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                            borderedContainer(cardIndex,
                                                color: const Color.fromRGBO(
                                                    8, 32, 50, 50),
                                                fontSize: 30,
                                                corTexto: Colors.white,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 20, 30, 20))
                                          ],
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            width:
                                                90, // Defina o tamanho desejado da largura da imagem
                                            height:
                                                80, // Defina o tamanho desejado da altura da imagem
                                            child: Image.asset(
                                              'image/company_imagens/$cardIndex.png',
                                              fit: BoxFit
                                                  .contain, // Ajuste a forma como a imagem é ajustada dentro do Container
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Flex(
                                          direction: Axis.vertical,
                                          children: [
                                            Row(
                                              children: [
                                                PriceCard(
                                                  "Min",
                                                  MIN,
                                                  backgroundColor: Colors.red,
                                                ),
                                                PriceCard(
                                                  "Médio",
                                                  PM,
                                                  backgroundColor:
                                                      Colors.orange,
                                                ),
                                                PriceCard(
                                                  "Max",
                                                  MAX,
                                                  backgroundColor: Colors.green,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flex(direction: Axis.horizontal, children: [
                                    Flexible(
                                        flex: 1,
                                        child: Flex(
                                            direction: Axis.vertical,
                                            children: [
                                              borderedContainer("Nome:",
                                                  color: const Color.fromRGBO(
                                                      8, 32, 50, 50),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  corTexto: Colors.white,
                                                  alignment:
                                                      Alignment.centerLeft),
                                              borderedContainer("Setor:",
                                                  color: const Color.fromRGBO(
                                                      8, 32, 50, 50),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  corTexto: Colors.white,
                                                  alignment:
                                                      Alignment.centerLeft),
                                            ])),
                                    Flexible(
                                        flex: 4,
                                        child: Flex(
                                            direction: Axis.vertical,
                                            children: [
                                              borderedContainer(nome_company,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft),
                                              borderedContainer(sector,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  alignment:
                                                      Alignment.centerLeft),
                                            ]))
                                  ]),
                                  borderedContainer(
                                    "Indicadores Relativos",
                                    color: const Color.fromRGBO(8, 32, 50, 50),
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 15),
                                    corTexto: Colors.white,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Flex(
                                          direction: Axis.vertical,
                                          children: [
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "Valor de Mercado:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "Lucro Líquido:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "Cres.Rec 5 anos:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "P/L:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "Dividend Yield:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "ROE:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                            Container(
                                              color: const Color.fromRGBO(
                                                  8, 32, 50, 50),
                                              child: borderedContainer(
                                                "Lucro por Ação:",
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                corTexto: Colors.white,
                                              ),
                                            ), // Sem borda
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                          flex: 4,
                                          child: Flex(
                                            direction: Axis.vertical,
                                            children: [
                                              borderedContainer(Valormercado,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                              borderedContainer(LucroLiqu,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                              borderedContainer(CR5,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                              borderedContainer(PL,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                              borderedContainer(DY,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                              borderedContainer(ROE,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                              borderedContainer(LPA,
                                                  color: const Color.fromRGBO(
                                                      245, 255, 250, 1.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 5, 10, 5)),
                                            ],
                                          ))
                                    ],
                                  ),
                                  Container(
                                    child: _getStatusContainer(color_company),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 20),
                                    child: Row(
                                      children: [
                                        Gavetinha(
                                          "TIPO DE GRÁFICO",
                                          ListaGavetinha().tipoDeGraficoLista,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.black,
                                        ),
                                        Gavetinha(
                                            "INDICADORES",
                                            ListaGavetinha()
                                                .indicadoresPriceLista),
                                        Gavetinha("AÇÃO",
                                            ListaGavetinha().acoesPriceLista),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(flex: 1),
                                      Expanded(
                                        flex: 60,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black87),
                                          ),
                                          child: SizedBox(
                                            height: 350,
                                            // width: 100,
                                            child: GraficoLinear(cardIndex),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ));
                    },
                  );
                } else {
                  return const Center(child: Text('Nenhum dado encontrado.'));
                }
              },
            ),
          ),
        ])));
  }
}

class PriceCard extends StatelessWidget {
  final String label;
  final String price;
  final Color backgroundColor;
  const PriceCard(this.label, this.price,
      {Key? key, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80, // Aumente a largura do Card conforme necessário
      height: 60, // Aumente a altura do Card conforme necessário
      child: Card(
        key: key,
        color: backgroundColor, // Definir a cor de fundo do Card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      price,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

borderedContainer(String text,
    {EdgeInsets padding = const EdgeInsets.all(0),
    EdgeInsets margin = const EdgeInsets.all(0),
    double fontSize = 15,
    Alignment alignment = Alignment.center,
    Color color = Colors.transparent,
    Color corTexto = Colors.black,
    bool flexible = false}) {
  return Container(
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: color,
    ),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        Align(
          alignment: alignment,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: corTexto),
          ),
        ),
      ],
    ),
  );
}
