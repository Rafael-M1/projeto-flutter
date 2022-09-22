import 'package:aplicacao/model/user/user_service.dart';
import 'package:aplicacao/pages/CrudProdutos/produtos_screen.dart';
import 'package:aplicacao/pages/home/home.dart';
import 'package:aplicacao/pages/usuarioLogado/cruds_page.dart';
import 'package:flutter/material.dart';

class HomeAfterLoginScreen extends StatefulWidget {
  const HomeAfterLoginScreen({Key? key}) : super(key: key);
  @override
  State<HomeAfterLoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeAfterLoginScreen> {
  int _selectedPage = 0;
  List<Widget> listPage = [];

  @override
  void initState() {
    listPage.add(const SecondPage());
    listPage.add(const ProdutosScreen());
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 40.0),
                  GestureDetector(
                    onTap: () {
                      UsuarioServices usuarioServices = UsuarioServices();
                      usuarioServices.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text("Logout"),
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
