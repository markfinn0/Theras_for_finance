import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:theras_app/views/menu_empresas/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MenuEmpresas(title: "THERAS"),
          ),
        );
      }
    } catch (e) {
      print('Erro ao criar usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb() {
      return MediaQuery.of(context).size.width > 900 ||
          !(MediaQuery.of(context).size.height >
              MediaQuery.of(context).size.width);
    }

    const double tamBorda = 39;
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Flex(
            direction: isWeb() ? Axis.horizontal : Axis.vertical,
            children: [
              Flexible(
                  flex: 1,
                  child: Image.asset('../../../assets/UX/cadastro-theras.png')),
              Flexible(
                  flex: isWeb() ? 1 : 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: isWeb() ? 30 : 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  style:
                                      const TextStyle(fontSize: 25, height: 2),
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Color(0xFF7063FF)),
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
                                    label: Text("Nome do Usuário"),
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 20),
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
                                  style:
                                      const TextStyle(fontSize: 25, height: 2),
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Color(0xFF7063FF)),
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
                                      padding:
                                          EdgeInsets.only(right: 10, left: 20),
                                      child: Icon(
                                        Icons.mail,
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
                                  style:
                                      const TextStyle(fontSize: 25, height: 2),
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Color(0xFF7063FF)),
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
                                      padding:
                                          EdgeInsets.only(right: 10, left: 20),
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
                                TextFormField(
                                  style:
                                      const TextStyle(fontSize: 25, height: 2),
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Color(0xFF7063FF)),
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
                                    labelText: 'Confirmar Senha',
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 20),
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
                                      return 'Por favor, confirme a senha';
                                    } else if (value !=
                                        _passwordController.text) {
                                      return 'As senhas não coincidem';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 500, // Largura desejada
                                  height: 80, // Altura desejada
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        const Color(0xFF7063FF),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _registerUser();
                                      }
                                    },
                                    child: Text('Cadastrar'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              splashRadius: 70,
                              icon:
                                  Image.asset('../../../assets/UX/google.png'),
                              iconSize: 150,
                              onPressed: () async {
                                try {
                                  final GoogleSignInAccount?
                                      googleSignInAccount = await GoogleSignIn(
                                    clientId:
                                        '41692962765-28jgbngm3rpmfv32nsl3j1ku1bckg7q6.apps.googleusercontent.com',
                                  ).signIn();

                                  if (googleSignInAccount != null) {
                                    final GoogleSignInAuthentication
                                        googleSignInAuthentication =
                                        await googleSignInAccount
                                            .authentication;
                                    final AuthCredential credential =
                                        GoogleAuthProvider.credential(
                                      accessToken: googleSignInAuthentication
                                          .accessToken,
                                      idToken:
                                          googleSignInAuthentication.idToken,
                                    );
                                    final UserCredential authResult =
                                        await FirebaseAuth.instance
                                            .signInWithCredential(credential);
                                    final User user = authResult.user!;

                                    if (user != null) {
                                      // O usuário está autenticado com sucesso
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MenuEmpresas(
                                                  title: "THERAS"),
                                        ),
                                      );
                                    } else {
                                      // O login com o Google falhou
                                      print('Falha no login com o Google');
                                    }
                                  }
                                } catch (e) {
                                  print('Erro ao fazer login com o Google: $e');
                                }
                              },
                            ),
                            IconButton(
                              splashRadius: 70,
                              icon: Image.asset(
                                  '../../../assets/UX/facebook.png'),
                              iconSize: 150,
                              onPressed: () async {
                                final LoginResult result =
                                    await FacebookAuth.instance.login();

                                switch (result.status) {
                                  case LoginStatus.success:
                                    final AuthCredential credential =
                                        FacebookAuthProvider.credential(
                                            result.accessToken!.token);
                                    final UserCredential authResult =
                                        await FirebaseAuth.instance
                                            .signInWithCredential(credential);
                                    final User? user = authResult.user;

                                    if (user != null) {
                                      // O usuário está autenticado com sucesso
                                      print(
                                          'Usuário logado com sucesso: ${user.displayName}');
                                    } else {
                                      // O login com o Facebook falhou
                                      print('Falha no login com o Facebook');
                                    }
                                    break;
                                  case LoginStatus.cancelled:
                                    // O usuário cancelou o login com o Facebook
                                    print('Login com o Facebook cancelado');
                                    break;
                                  case LoginStatus.failed:
                                    // Lidar com erros de autenticação do Facebook
                                    print('Erro ao fazer login com o Facebook');
                                    break;
                                  case LoginStatus.operationInProgress:
                                    // Lida com o caso de operação em andamento (se necessário).
                                    break;
                                }
                              },
                            ),
                            IconButton(
                              splashRadius: 70,
                              icon:
                                  Image.asset('../../../assets/UX/twitter.png'),
                              iconSize: 150,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
