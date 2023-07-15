import 'package:flutter/material.dart';
import 'dart:convert';
import '../details_screen/main.dart';
import 'package:flutter/services.dart' show rootBundle;
//import '../../chart tela.dart';

class MenuContainer extends StatefulWidget {
  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  List<dynamic> view = [];
  List<dynamic> filteredView = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCardsData();
  }

  Future<void> loadCardsData() async {
    String jsonData = await rootBundle.loadString('asset/cards_main.json');
    setState(() {
      view = jsonDecode(jsonData);
      filteredView = view;
    });
  }

  void filterCompanies(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredView = view;
      } else {
        filteredView = view.where((company) {
          String tick = company['tick'].toString().toLowerCase();
          String sector = company['sector'].toString().toLowerCase();
          String nome_company = company['nome'].toString().toLowerCase();
          return tick.contains(query.toLowerCase()) ||
              sector.contains(query.toLowerCase()) ||
              nome_company.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.25, vertical: 15),
            child: TextField(
              controller: searchController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: 'Pesquisar Empresa',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 212, 212, 212),
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.02),
              ),
              onChanged: filterCompanies,
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredView.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                var tick = filteredView[index]['tick'];
                var nome_company = filteredView[index]['nome'];
                var sector = filteredView[index]['sector'];
                var PM = filteredView[index]['PM'];
                var PL = filteredView[index]['PL'];
                var Gain = filteredView[index]['gain'];
                var CMP = filteredView[index]['CMP'];
                var color_company = filteredView[index]['color'];
                var symbol_status = filteredView[index]['symbol'];

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
                          color: Color.fromRGBO(245, 245, 245, 50),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
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
                            top: 50,
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
                              child: (() {
                                if (symbol_status == 'up') {
                                  return Icon(
                                    Icons.trending_up,
                                  );
                                } else if (symbol_status == 'down') {
                                  return Icon(
                                    Icons.trending_down,
                                  );
                                } else if (symbol_status == 'side') {
                                  return Icon(
                                    Icons.trending_flat,
                                  );
                                } else {
                                  return SizedBox();
                                }
                              })(),
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
                                child: (() {
                                  if (symbol_status == 'up') {
                                    return Text(
                                      Gain,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else if (symbol_status == 'down') {
                                    return Text(
                                      Gain,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else if (symbol_status == 'side') {
                                    return Text(
                                      Gain,
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                })(),
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
                            child: (() {
                              if (color_company == 'green') {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child: SizedBox(
                                    height: 15,
                                  ),
                                );
                              } else if (color_company == 'orange') {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                  ),
                                  child: SizedBox(
                                    height: 15,
                                  ),
                                );
                              } else if (color_company == 'red') {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: SizedBox(
                                    height: 15,
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            })(),
                          ),
                          Positioned(
                            left: 5,
                            right: 0,
                            bottom: 15,
                            child: Container(
                              height: 20,
                              width: 10,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  nome_company,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
