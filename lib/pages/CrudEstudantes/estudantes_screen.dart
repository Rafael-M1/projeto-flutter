// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/model/Estudante/estudante_service.dart';
import 'package:aplicacao/pages/CrudEstudantes/lista_estudantes_screen.dart';
import 'package:flutter/material.dart';

class CadastroEstudanteScreen extends StatefulWidget {
  const CadastroEstudanteScreen({super.key});

  @override
  State<CadastroEstudanteScreen> createState() =>
      _CadastroEstudanteScreenState();
}

class _CadastroEstudanteScreenState extends State<CadastroEstudanteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CursoService cursoService = CursoService();
  late List<Curso> listaCursos;

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    listaCursos = await cursoService.getCursoList();
  }

  @override
  Widget build(BuildContext context) {
    EstudanteService estudanteService = EstudanteService();

    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 15.0, top: 50.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        List<DropdownMenuItem<String>> cursoItems = [];
                        for (int i = 0; i < listaCursos.length; i++) {
                          cursoItems.add(
                            DropdownMenuItem(
                              value: listaCursos.elementAt(i).idCurso,
                              child: Text(
                                listaCursos.elementAt(i).nome.toString(),
                              ),
                            ),
                          );
                        }
                        Estudante estudante = Estudante();
                        Curso cursoEstudante = Curso();
                        estudante.curso = cursoEstudante;
                        return AlertDialog(
                          title: const Text('Cadastro de Estudante'),
                          content: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5, width: 500),
                                  TextFormField(
                                    //Input Nome Estudante
                                    onSaved: (value) => estudante.nome = value,
                                    initialValue: estudante.nome,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(fontSize: 18.0),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 4) {
                                        return 'Por favor, entre com um nome.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nome",
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.blueGrey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    //Input Email do Estudante
                                    onSaved: (value) => estudante.email = value,
                                    initialValue: estudante.email,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(fontSize: 18.0),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, entre com um e-mail.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "E-mail",
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.blueGrey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    items: cursoItems,
                                    onSaved: (idCurso) {
                                      estudante.curso!.idCurso = idCurso;
                                    },
                                    onChanged: (idCurso) {
                                      estudante.curso!.idCurso = idCurso;
                                    },
                                    validator: (value) => value == null
                                        ? 'Selecione um Curso'
                                        : null,
                                    hint: const Text("Escolha um Curso"),
                                    value: estudante.curso!.idCurso,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    //Input PrevisaoTerminoCurso do Estudante
                                    onSaved: (value) =>
                                        estudante.previsaoTerminoCurso = value,
                                    initialValue:
                                        estudante.previsaoTerminoCurso,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(fontSize: 18.0),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, entre com a previsão de término do Curso atual.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Previsão Término de Curso",
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.blueGrey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    //Input experienciaProfissional do Estudante
                                    onSaved: (value) => estudante
                                        .experienciaProfissional = value,
                                    initialValue:
                                        estudante.experienciaProfissional,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(fontSize: 18.0),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, entre com a experiência profissional.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Experiência Profissional",
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 2,
                                          color: Colors.blueGrey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Voltar'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                //Chama serviço de salvar Estudante
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  bool isAdded = await estudanteService
                                      .adicionarEstudante(estudante);
                                  if (isAdded) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: const Text(
                                            "Estudante Criado com sucesso!"),
                                        action: SnackBarAction(
                                          label: "Fechar",
                                          onPressed: () =>
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar(),
                                        ),
                                      ),
                                    );
                                    _formKey.currentState!.reset();
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text(
                                            "Problemas ao gravar dados."),
                                        action: SnackBarAction(
                                          label: "Fechar",
                                          onPressed: () =>
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar(),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text('Salvar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Cadastrar Estudante"),
                ),
                const SizedBox(height: 50),
                ListaEstudanteScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
