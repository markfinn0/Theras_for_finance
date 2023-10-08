import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:theras_app/views/menu_empresas/main.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MenuEmpresas(title: "THERAS"),
                              ),
                            );
      }
    } catch (e) {
      print('Erro ao criar usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nome de Usuário'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um nome de usuário';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um email válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma senha';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirmar Senha'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, confirme a senha';
                } else if (value != _passwordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _registerUser();
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}