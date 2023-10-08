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

  @override
  Widget build(BuildContext context) {
    bool isWeb() {
      return MediaQuery.of(context).size.width > 900;
    }

    const double tamBorda = 39;
    const double tamBotao = 20;

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Flex(
            direction: isWeb() ? Axis.horizontal : Axis.vertical,
            children: [
              Flexible(
                  flex: 1,
                  child: Image.asset('../../../assets/UX/therasLogin.png')),
              Flexible(
                  flex: isWeb() ? 1 : 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: const TextStyle(fontSize: 25, height: 2),
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Color(0xFF7063FF)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7063FF), width: 1),
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(tamBorda),
                                  right: Radius.circular(tamBorda)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7063FF), width: 2),
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(tamBorda),
                                  right: Radius.circular(tamBorda)),
                            ),
                            label: Text("Email"),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10, left: 20),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF7063FF),
                                size: 40,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(tamBorda),
                                  right: Radius.circular(tamBorda)),
                            ),
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
                          style: const TextStyle(fontSize: 25, height: 2),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Color(0xFF7063FF)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7063FF), width: 1),
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(tamBorda),
                                  right: Radius.circular(tamBorda)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF7063FF), width: 2),
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(tamBorda),
                                  right: Radius.circular(tamBorda)),
                            ),
                            labelText: 'Senha',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10, left: 20),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xFF7063FF),
                                size: 40,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(tamBorda),
                                  right: Radius.circular(tamBorda)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira uma senha válida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 500, // Largura desejada
                          height: 80, // Altura desejada
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF7063FF),
                              ),
                            ),
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
                                            const MenuEmpresas(title: "THERAS"),
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
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_errorMessage != null)
                          Text(
                            "Usuário ou Senha estão Incorretos",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Form(
        //     key: _formKey,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const SizedBox(height: 20),
        //         TextFormField(
        //           controller: _emailController,
        //           decoration: const InputDecoration(
        //             labelText: 'E-mail',
        //             border: OutlineInputBorder(),
        //           ),
        //           validator: (value) {
        //             if (value == null || value.isEmpty) {
        //               return 'Por favor, insira um e-mail válido';
        //             }
        //             return null;
        //           },
        //         ),
        //         const SizedBox(height: 20),
        //         TextFormField(
        //           controller: _passwordController,
        //           obscureText: true,
        //           decoration: const InputDecoration(
        //             labelText: 'Senha',
        //             border: OutlineInputBorder(),
        //           ),
        //           validator: (value) {
        //             if (value == null || value.isEmpty) {
        //               return 'Por favor, insira uma senha válida';
        //             }
        //             return null;
        //           },
        //         ),
        //         const SizedBox(height: 20),
        // ElevatedButton(
        //     onPressed: () async {
        //       if (_formKey.currentState!.validate()) {
        //         final email = _emailController.text;
        //         final password = _passwordController.text;

        //         try {
        //           final userCredential =
        //               await _auth.signInWithEmailAndPassword(
        //             email: email,
        //             password: password,
        //           );
        //           if (userCredential.user != null) {
        //             Navigator.of(context).pushReplacement(
        //               MaterialPageRoute(
        //                 builder: (context) =>
        //                     MenuEmpresas(title: "THERAS"),
        //               ),
        //             );
        //           } else {
        //             setState(() {
        //               _errorMessage = 'Credenciais inválidas';
        //             });
        //           }
        //         } catch (e) {
        //           setState(() {
        //             _errorMessage = 'Erro durante o login';
        //           });
        //         }
        //       }
        //     },
        //     child: Column(
        //       children: [
        //         Container(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: 100, vertical: 20),
        //           child: const Text(
        //             "Login",
        //             style: TextStyle(fontSize: 20),
        //           ),
        //         ),
        //       ],
        //     )),
        //         Container(
        //           padding: EdgeInsets.only(top: 20),
        //           child: ElevatedButton(
        //               onPressed: () async {
        //                 Navigator.of(context).pushReplacement(
        //                   MaterialPageRoute(
        //                     builder: (context) => const Cadastro(),
        //                   ),
        //                 );
        //               },
        //               child: Column(
        //                 children: [
        //                   Container(
        //                     padding: const EdgeInsets.symmetric(
        //                         horizontal: 100, vertical: 20),
        //                     child: const Text(
        //                       "Cadastro",
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),
        //                 ],
        //               )),
        //         ),
        //         const SizedBox(height: 20),
        //         if (_errorMessage != null)
        //           const Text(
        //             "Usuário ou Senha estão Incorretos",
        //             style: TextStyle(color: Colors.red),
        //           ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
