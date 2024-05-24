import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_dot/shares/models/login_model.dart';
import 'package:gym_dot/telas/cadastro/tela_de_cadastro.dart';
import 'package:gym_dot/shares/constantes/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shares/constantes/cores.dart';

class TeladeLogin extends StatefulWidget {
  const TeladeLogin({super.key});

  @override
  State<TeladeLogin> createState() => _TeladeLoginState();
}

class _TeladeLoginState extends State<TeladeLogin> {
  bool continueConnected = false;
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              corDoTopo,
              corDaBase,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Image.asset(
                  'assets/logo_gym.png',
                  height: 200,
                ),
              ),
              const Text(
                'Entrar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailInputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Digite seu e-mail',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordInputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Digite sua senha',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.key_outlined,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Clicou em esqueceu');
                },
                child: const Text(
                  'Esqueceu a senha?',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: continueConnected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        continueConnected = newValue ?? false;
                      });
                    },
                    checkColor: corDoTopo,
                    activeColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                  ),
                  const Text(
                    'Quero continuar conectado!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      style: BorderStyle.solid,
                      color: corDaBase,
                      width: 1.8,
                    )),
                onPressed: () {
                  print('Clicou em entrar');
                  _doLogin();
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(color: corDaBase),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: corDaBase,
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.white,
                        width: 1.8,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeladeCadastro(),
                      ),
                    );
                  },
                  child: const Text(
                    'Quero me cadastrar',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin() async {
    // funcao que precisou ser criada para testar o cadastro local.
    String mailTeladeLogin = _mailInputController.text;
    String passTeladeLogin = _passwordInputController.text;
    User savedUser = await _getSavedUser();

    if (mailTeladeLogin == savedUser.mail &&
        passTeladeLogin == savedUser.password) {
      print('LOGIN EFETUADO COM SUCESSO');
    } else {
      print('FALHA NO LOGIN');
    }
  }

  Future<User> _getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(Chaves.chavesBancoLocal);

    Map<String, dynamic> mapUser = json.decode(jsonUser!);
    User user = User.fromJson(mapUser);
    return user;
  }
}
