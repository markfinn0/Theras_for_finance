import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:theras_app/views/login_screen/cadastro.dart';

import 'package:theras_app/views/menu_empresas/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  get googleSignIn => null;

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {}
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        try {
                          final userCredential =
                              await _auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          if (userCredential.user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MenuEmpresas(title: "THERAS"),
                              ),
                            );
                          } else {
                            setState(() {
                              _errorMessage = 'Credenciais inválidas';
                            });
                          }
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Erro durante o login';
                          });
                        }
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Cadastro(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20),
                            child: const Text(
                              "Cadastro",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 20),
                if (_errorMessage != null)
                  const Text(
                    "Usuário ou Senha estão Incorretos",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
