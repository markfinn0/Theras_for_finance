import 'package:flutter/material.dart';
import 'grafico_linear.dart';
import '../menu_empresas/footer.dart';

class DetailsScreen extends StatelessWidget {
  final String cardIndex;
  final double breakpoint = 800;
  final int paneProportion = 50;

  DetailsScreen(this.cardIndex);

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
        //   body: Container(
        //     height: 1200,
        //     child: Stack(
        //       children: <Widget>[
        //         Positioned(
        //             top: 90,
        //             bottom: 320,
        //             left: 870,
        //             right: 30,
        //             child: Center(
        //                 child: Container(
        //               decoration: BoxDecoration(border: Border.all()),
        //               child: GraficoLinear(),
        //             ))),
        //         Positioned(
        //           top: 0,
        //           bottom: 1140,
        //           left: 1350,
        //           right: 30,
        //           child: Image.asset('image/Azul.png', width: 300, height: 200),
        //         ),
        //         Positioned(
        //           bottom: 0,
        //           left: 0,
        //           right: 0,
        //           child: Container(
        //             height: 50,
        //             color: Color.fromRGBO(8, 32, 50, 50),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   '© THΞRAS for Finance - APS 2024 - Todos os direitos reservados',
        //                   style: TextStyle(
        //                     fontSize: 14,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        body: Container(
            margin: EdgeInsets.only(top: 30),
            child: Flex(direction: Axis.horizontal, children: [
              Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              Text("Último Resultado: Mar-2023"),
                              borderedContainer(cardIndex)
                            ],
                          )
                        ],
                      ),
                      Table()
                    ],
                  )),
              Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 200,
                                  // width: 100,
                                  child: GraficoLinear(),
                                ))
                          ])
                    ],
                  ))
            ])));
  }
}

//GraficoLinear()
borderedContainer(text, {double padding = 3}) {
  return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
      child: Text(text));
}
