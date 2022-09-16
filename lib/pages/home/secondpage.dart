import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.black12,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/produtos');
                },
                child: const Text("CRUD Produtos"),
              ),
              const SizedBox(width: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/fornecedores');
                },
                child: const Text("CRUD Fornecedores"),
              )
            ],
          ),
          Column(),
        ],
      ),
    );
  }
}
