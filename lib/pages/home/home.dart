import 'package:flutter/material.dart';

import 'adminpage.dart';
import 'firstpage.dart';
import 'login/loginpage.dart';
import 'secondpage.dart';
import 'thirdpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 4;
  List<Widget> listPage = [];

  @override
  void initState() {
    listPage.add(const FirstPage());
    listPage.add(const SecondPage());
    listPage.add(const ThirdPage());
    listPage.add(const AdminPage());
    listPage.add(const LoginPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPage = 1;
                      });
                    },
                    child: const Text("Item 2"),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: false,
                    child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPage = 3;
                      });
                    },
                    child: const Text("Administração"),
                  ),
                  ),
                  const SizedBox(width: 40.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPage = 4;
                      });
                    },
                    child: const Text("Login"),
                  ),
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
