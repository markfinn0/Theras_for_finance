import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  // Register the web plugin.

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'adViewType',
    (int viewId) => IFrameElement()
      ..width = '320'
      ..height = '100'
      ..src = 'ad.html'
      ..style.border = 'none',
  );
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'adViewType1',
    (int viewId) => IFrameElement()
      ..width = '320'
      ..height = '100'
      ..src = 'ad copy.html'
      ..style.border = 'none',
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Web AdSense Ads'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(child: adsenseAdsView1()),Center(child: adsenseAdsView()) 
            ],
          ),
          
        ),
      ),
    );
  }
}

Widget adsenseAdsView() {
  return const SizedBox(
    height: 100.0,
    width: 320.0,
    child: HtmlElementView(
      viewType: 'adViewType',
    ),
  );
}
Widget adsenseAdsView1() {
  return const SizedBox(
    height: 100.0,
    width: 320.0,
    child: HtmlElementView(
      viewType: 'adViewType1',
    ),
  );
}