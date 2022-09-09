import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Página 3",
          style: TextStyle(
            fontSize: 150.0,
          ),
        ),
        Text("3"),
      ],
    );
  }
}
