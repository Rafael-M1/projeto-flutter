import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Página 2",
          style: TextStyle(
            fontSize: 150.0,
          ),
        ),
        Text("2"),
      ],
    );
  }
}
