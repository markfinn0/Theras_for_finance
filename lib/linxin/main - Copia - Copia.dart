import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cards from JSON'),
        ),
        body: FutureBuilder(
          future: rootBundle.loadString('asset/data.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> cardsData = jsonDecode(snapshot.data!);

              return ListView.builder(
                itemCount: cardsData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(cardsData[index]['title']),
                      subtitle: Text(cardsData[index]['description']),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
