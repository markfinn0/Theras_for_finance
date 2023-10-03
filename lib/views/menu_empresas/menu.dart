import 'package:flutter/material.dart';
import 'dart:convert';
import '../details_screen/main.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_database/firebase_database.dart';

class MenuContainer extends StatefulWidget {
  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  List<dynamic> view = [];
  List<dynamic> filteredView = [];
  TextEditingController searchController = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;

  void setarTabela() async {
    DatabaseReference ref = database.ref('tabela_testes');
    await ref.set({
      "name": "Marcola",
      "age": 20,
      "address": {"line1": "Casa do Caralho"}
    });
  }

  @override
  void initState() {
    super.initState();
    loadCardsData();
    setarTabela();
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
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.25,
              vertical: 15,
            ),
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
                  fontSize: screenHeight * 0.02,
                ),
              ),
              onChanged: filterCompanies,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: rootBundle.loadString('asset/cards_main.json'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<dynamic> view = jsonDecode(snapshot.data!);

                  return GridView.builder(
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
                              builder: (context) => DetailsScreen(tick,
                                  color_company, PM, nome_company, sector),
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
                                  top: 5,
                                  left: 5,
                                  child: Container(
                                    height: 70,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        tick,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 5,
                                  child: Container(
                                    height: 60,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        sector,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 5,
                                  child: Container(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerRight,
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
                                  top: 20,
                                  right: 5,
                                  child: Container(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        PM,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  right: 5,
                                  child: Container(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerRight,
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
                                  top: 60,
                                  right: 5,
                                  child: Container(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        PL,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 120,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Previsão",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20,
                                  right: 120,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    height: 30,
                                    child: Align(
                                      child: (() {
                                        if (symbol_status == 'up') {
                                          return Text(
                                            Gain,
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else if (symbol_status == 'down') {
                                          return Text(
                                            Gain,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else if (symbol_status == 'side') {
                                          return Text(
                                            Gain,
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 15,
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
                                  top: 25,
                                  right: 120,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    height: 60,
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
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
