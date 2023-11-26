import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:theras_app/views/login_screen/cadastro.dart';
import 'package:theras_app/views/menu_empresas/main.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
  void initState() {
    super.initState();
    // Set Firebase Authentication persistence mode to LOCAL
    _auth.setPersistence(Persistence.LOCAL);
    checkCurrentUser();
  }

  void checkCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // User is already authenticated, navigate to the main screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MenuEmpresas(title: "THERAS"),
        ),
      );
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
                                Container(
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final email = _emailController.text;
                                        final password =
                                            _passwordController.text;

                                        try {
                                          final userCredential = await _auth
                                              .signInWithEmailAndPassword(
                                            email: email,
                                            password: password,
                                          );
                                          if (userCredential.user != null) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MenuEmpresas(
                                                        title: "THERAS"),
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              _errorMessage =
                                                  'Credenciais inválidas';
                                            });
                                          }
                                        } catch (e) {
                                          setState(() {
                                            _errorMessage =
                                                'Erro durante o login';
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
                                  const Text(
                                    "Usuário ou Senha estão Incorretos",
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Ainda não tem uma conta?",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            InkWell(
                                child: const Text(' Criar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF7063FF),
                                      fontSize: 22,
                                    )),
                                onTap: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            const Cadastro()))),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                            child: const Text('Esqueci minha senha',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF7063FF),
                                  fontSize: 22,
                                )),
                            onTap: () => Navigator),
                        const SizedBox(height: 20),
                        const Row(children: [
                          Expanded(child: Divider()),
                          Text("Ou",
                              style: TextStyle(
                                fontSize: 22,
                              )),
                          Expanded(child: Divider()),
                        ]),
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
                                    print(
                                        'Erro ao fazer login com o Facebook');
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
