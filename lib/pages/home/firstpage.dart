import 'package:aplicacao/model/OfertaEstagio/oferta_estagio_service.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    OfertaEstagioService ofertaEstagioService = OfertaEstagioService();
    return Center(
      child: Container(
        height: 800,
        width: 1200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Bem-vindo a Estágio.com",
              // "P",
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              // "",
              "Encontre seu estágio",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
