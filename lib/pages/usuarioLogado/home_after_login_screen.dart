import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/user/user.dart';
import 'package:aplicacao/model/user/user_service.dart';
import 'package:aplicacao/pages/home/home.dart';
import 'package:aplicacao/pages/usuarioLogado/bem_vindo_screen.dart';
import 'package:aplicacao/pages/usuarioLogado/cruds_page.dart';
import 'package:aplicacao/pages/usuarioLogado/oferta_estagio_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAfterLoginScreen extends StatefulWidget {
  const HomeAfterLoginScreen({Key? key}) : super(key: key);
  @override
  State<HomeAfterLoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeAfterLoginScreen> {
  int _selectedPage = 0;
  List<Widget> listPage = [];
  late UserApp usuarioLogado = UserApp();
  UsuarioServices usuarioServices = UsuarioServices();
  bool admin = false;
  String emailParam = "";
  Curso cursoParam = Curso();

  @override
  void initState() {
    asyncMethod().then((usuarioLogado) {
      listPage.add(
        BemVindoScreen(
          emailParam: usuarioLogado.email.toString(),
          usuarioLogadoParam: usuarioLogado,
        ),
      );
      setState(() {
        _selectedPage = 0;
      });
      listPage.add(
        OfertaEstagioScreen(
            cursoParam: Curso(
              idCurso: usuarioLogado.estudante?.curso?.idCurso,
              nome: usuarioLogado.estudante?.curso?.nome,
              tipo: usuarioLogado.estudante?.curso?.tipo,
            ),
            usuarioLogadoParam: usuarioLogado),
      );
      if (usuarioLogado.role == "Administrador") {
        listPage.add(const CrudsPage());
      }
    });
    super.initState();
  }

  Future<UserApp> asyncMethod() async {
    User? user = FirebaseAuth.instance.currentUser;
    // Check if the user is signed in
    if (user != null) {
      usuarioLogado = await usuarioServices.getUsuarioLogado(user.uid);
      if (usuarioLogado.role == "Administrador") {
        setState(() {
          admin = true;
        });
      }
    }
    return usuarioLogado;
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
            children: admin
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPage = 0;
                              });
                            },
                            child: const Text("Home"),
                          ),
                        ),
                        const SizedBox(width: 40.0),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPage = 1;
                              });
                            },
                            child: const Text("Lista de Ofertas"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPage = 2;
                              });
                            },
                            child: const Text("Administração"),
                          ),
                        ),
                        const SizedBox(width: 40.0),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              UsuarioServices usuarioServices =
                                  UsuarioServices();
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
                        ),
                      ],
                    )
                  ]
                : [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPage = 0;
                              });
                            },
                            child: const Text("Home"),
                          ),
                        ),
                        const SizedBox(width: 40.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPage = 1;
                            });
                          },
                          child: const Text("Lista de Ofertas"),
                        ),
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
                    )
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
