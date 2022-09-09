import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Página 1",
          style: TextStyle(
            fontSize: 150.0,
          ),
        ),
        Text("2"),
      ],
    );
  }
}
