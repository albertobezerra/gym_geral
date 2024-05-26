import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AcessandoFirebase extends StatefulWidget {
  const AcessandoFirebase({super.key});

  @override
  State<AcessandoFirebase> createState() => _AcessandoFirebaseState();
}

class _AcessandoFirebaseState extends State<AcessandoFirebase> {
  List<String> listString = <String>['Nenhum resgistro carregado'];
  Uri url = Uri.https('gymappprof-default-rtdb.firebaseio.com', '/words.json');
  final TextEditingController _controller = TextEditingController();
  late bool _carregando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: (_carregando)
              ? const CircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () => _infosSalvasNoDB(),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Insira uma palavra aqui:',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _addStringNoFirebase(),
                        child: const Text(
                          'Gravar no Firebase',
                        ),
                      ),
                      for (String s in listString) Text(s)
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _infosSalvasNoDB() {
    return http.get(url).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      listString = [];
      map.forEach((key, value) {
        setState(() {
          listString.add(map[key]['word']);
        });
      });
    });
  }

  _addStringNoFirebase() async {
    setState(() {
      _carregando = true;
    });
    await http
        .post(
      url,
      body: json.encode(
        {'word': _controller.text},
      ),
    )
        .then((value) {
      _infosSalvasNoDB().then((value) {
        setState(() {
          _carregando = false;
        });
        final snackBar = SnackBar(
          content: const Text('Gravado com sucesso!'),
          action: SnackBarAction(
              label: 'Dispensar',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      _controller.text = '';
    });
  }
}
