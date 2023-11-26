import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;
import 'dart:js' as js;
import 'package:theras_app/views/login_screen/main.dart';

class HeaderTheras extends StatelessWidget implements PreferredSizeWidget {
  const HeaderTheras();
  
  @override
  Widget build(BuildContext context) {
    void signinOut() async {
    try {
      print("deu certo");
      await FirebaseAuth.instance.signOut();
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Replace LoginScreen() with the actual login screen widget
      );
    } catch (e) {
      print("Erro ao deslogar usuário $e");
    }
  }
    return AppBar(
      backgroundColor: const Color(0xFF7063FF),
      centerTitle: true,
      title: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Flexible(
            flex: 1,
            child: Text(''),
          ),
          const Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'T H Ξ R A S',
                      style:
                          TextStyle(color: Color(0xFFFFFFFF), fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ])),
          Flexible(
              flex: 1,
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        signinOut();
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 40,
                      ),
                    ),
                    // IconButton(
                    //   icon: Image.asset('assets/company_imagens/YT.png'),
                    //   iconSize: 50,
                    //   onPressed: () async {
                    //     // final Uri url = Uri.parse('https://flutter.dev');
                    //     // if (!await launchUrl(url)) {
                    //     //   throw Exception('Could not launch $_url');
                    //     // }
                    //     // html.window.open(url, name);
                    //     js.context.callMethod('open', [
                    //       'https://www.youtube.com/channel/UCaJECNjm4dEJHHBAdHCFjzg'
                    //     ]);
                    //   },
                    // )
                  ])),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
