import 'package:flutter/material.dart';
import 'package:gym_dot/telas/login/tela_de_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gym App',
      debugShowCheckedModeBanner: false,
      home: TeladeLogin(),
    );
  }
}
