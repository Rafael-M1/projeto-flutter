import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Página Administração",
          style: TextStyle(
            fontSize: 150.0,
          ),
        ),
        Text("2"),
      ],
    );
  }
}
