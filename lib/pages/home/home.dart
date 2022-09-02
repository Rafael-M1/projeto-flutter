import 'package:flutter/material.dart';

import 'firstpage.dart';
import 'secondpage.dart';

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
    listPage.add(const SecondPage());
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
                  const Text("Item 3"),
                ],
              ),
              const Text("Administração"),
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
