import 'package:flutter/material.dart';
import 'dart:convert';
import '../details_screen/main.dart';
import 'package:flutter/services.dart' show rootBundle;
//import '../../chart tela.dart';

class MenuContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: rootBundle.loadString('asset/data.json'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<dynamic> view = jsonDecode(snapshot.data!);

                  return GridView.builder(
                    itemCount: view.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
