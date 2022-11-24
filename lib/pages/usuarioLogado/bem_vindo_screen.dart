// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/user/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BemVindoScreen extends StatefulWidget {
  BemVindoScreen(
      {Key? key, required this.emailParam, required this.usuarioLogadoParam})
      : super(key: key);
  String emailParam;
  UserApp usuarioLogadoParam;

  @override
  State<BemVindoScreen> createState() => _BemVindoScreenState();
}

class _BemVindoScreenState extends State<BemVindoScreen> {
  @override
  Widget build(BuildContext context) {
    UserApp usuarioLogado = widget.usuarioLogadoParam;
    double meusDadosFontSize = 13.0;
    return Center(
      child: Container(
        height: 800,
        width: 1200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem-Vindo - " + usuarioLogado.nome.toString(),
                style: TextStyle(fontSize: meusDadosFontSize * 1.8),
              ),
              const SizedBox(height: 20),
              Text(
                "Meus dados: ",
                style: TextStyle(fontSize: meusDadosFontSize),
              ),
              Text(
                "E-mail: " + usuarioLogado.email.toString(),
                style: TextStyle(fontSize: meusDadosFontSize),
              ),
              Text(
                "E-mail: " +
                    usuarioLogado.estudante!.previsaoTerminoCurso.toString(),
                style: TextStyle(fontSize: meusDadosFontSize),
              ),
              Text(
                "Curso: " + usuarioLogado.estudante!.curso!.nome.toString(),
                style: TextStyle(fontSize: meusDadosFontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
