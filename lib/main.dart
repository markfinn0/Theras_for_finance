import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:theras_app/views/home_screen/main.dart';
import 'package:theras_app/views/login_screen/main.dart';
import 'views/menu_empresas/main.dart';
import 'views/details_screen/main.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void inicializarFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// void main() {
//   // ignore: undefined_prefixed_name
// ui.platformViewRegistry.registerViewFactory(
//   'adViewType',
//   (int viewId) => IFrameElement()
//     ..width = '320'
//     ..height = '100'
//     ..src = 'ad.html'
//     ..style.border = 'none',
// );
//   // ignore: undefined_prefixed_name
//   inicializarFirebase();
//   runApp(const MyApp());
// }
void main() async {
  await dotenv.load(fileName: ".env");
  String facebookAppId = dotenv.env[
          '41692962765-28jgbngm3rpmfv32nsl3j1ku1bckg7q6.apps.googleusercontent.com'] ??
      '';
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'adViewType',
    (int viewId) => IFrameElement()
      ..width = '320'
      ..height = '100'
      ..src = 'ad.html'
      ..style.border = 'none',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Widget adsenseAdsView() {
  return Container(
    margin: const EdgeInsets.only(bottom: 40),
    height: 100.0,
    width: 800.0,
    child: const HtmlElementView(
      viewType: 'adViewType',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theras for Finance',
      home: FutureBuilder(
        builder: (context, snapshot) {
          return HomeScreen();
          // return const MenuEmpresas(title: 'T H Ξ R A S');
        },
        future: null,
      ),
    );
  }
}
