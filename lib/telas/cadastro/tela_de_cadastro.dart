import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_dot/models/user_model.dart';
import 'package:gym_dot/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/cores.dart';

class TeladeCadastro extends StatefulWidget {
  const TeladeCadastro({super.key});

  @override
  State<TeladeCadastro> createState() => _TeladeCadastroState();
}

class _TeladeCadastroState extends State<TeladeCadastro> {
  bool verSenha = false;

  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _confirmPassInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
              const Text(
                'Cadastro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameInputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Digite seu nome',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
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
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordInputController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Digite sua senha',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.key,
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
                    const SizedBox(height: 20),
                    (verSenha == false)
                        ? TextFormField(
                            controller: _confirmPassInputController,
                            obscureText: (verSenha == true) ? false : true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Repita a senha',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(
                                Icons.key,
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
                          )
                        : Container(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: verSenha,
                          onChanged: (bool? newValue) {
                            setState(() {
                              verSenha = newValue ?? false;
                            });
                          },
                          checkColor: corDoTopo,
                          activeColor: Colors.white,
                          side:
                              const BorderSide(color: Colors.white, width: 1.5),
                        ),
                        const Text(
                          'Ver a senha digitada',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: corDaBase,
                        width: 1.8,
                      )),
                  onPressed: () {
                    _finalizarCadastro();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(color: corDaBase),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _finalizarCadastro() {
    User newUser = User(
      name: _nameInputController.text,
      mail: _mailInputController.text,
      password: _passwordInputController.text,
      keepOn: true,
    );
    print(newUser);
    _salvaCadastroNaMemoriaDoTelefone(newUser);
  }

  void _salvaCadastroNaMemoriaDoTelefone(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Chaves.chavesBancoLocal, json.encode(user.toJson()));
  }
}
