// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/pages/CrudEmpresas/empresas_screen.dart';
import 'package:aplicacao/pages/CrudOfertaEstagios/oferta_estagios_screen.dart';
import 'package:aplicacao/pages/CrudUsuarios/usuarios_screen.dart';
import 'package:flutter/material.dart';
import 'package:aplicacao/pages/CrudCursos/cursos_screen.dart';

class CrudsPage extends StatefulWidget {
  const CrudsPage({Key? key}) : super(key: key);

  @override
  State<CrudsPage> createState() => _CrudsPageState();
}

class _CrudsPageState extends State<CrudsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 800,
        width: 1200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cadastro de Estudante"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Voltar'),
                        ),
                      ],
                      content: const CadastroUsuarioScreen(),
                    ),
                  );
                },
                child: const Text("Lista de Estudantes"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cadastro de Cursos"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Voltar'),
                        ),
                      ],
                      content: const CadastroCursoScreen(),
                    ),
                  );
                },
                child: const Text("Cadastro de Cursos"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cadastro de Empresas"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Voltar'),
                        ),
                      ],
                      content: const CadastroEmpresaScreen(),
                    ),
                  );
                },
                child: const Text("Cadastro de Empresas"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cadastro de Ofertas de Estágio"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Voltar'),
                        ),
                      ],
                      content: const CadastroOfertaEstagioScreen(),
                    ),
                  );
                },
                child: const Text("Cadastro de Ofertas de Estágio"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
