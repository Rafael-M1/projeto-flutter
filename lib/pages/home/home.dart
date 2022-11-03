import 'package:flutter/material.dart';

import 'firstpage.dart';
import 'login/loginpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  List<Widget> listPage = [];

  @override
  void initState() {
    listPage.add(const FirstPage());
    listPage.add(const LoginPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 102, 158, 255),
      appBar: AppBar(
        leading: const Icon(Icons.movie_creation),
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPage = 0;
                      });
                    },
                    child: const Text("Home"),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 40.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPage = 1;
                      });
                    },
                    child: const Text("Entrar"),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: listPage,
      ),
    );
  }
}
