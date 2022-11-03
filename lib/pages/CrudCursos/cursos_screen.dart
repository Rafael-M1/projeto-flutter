// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastroCursoScreen extends StatefulWidget {
  const CadastroCursoScreen({super.key});

  @override
  State<CadastroCursoScreen> createState() => _CadastroCursoScreenState();
}

class _CadastroCursoScreenState extends State<CadastroCursoScreen> {
  @override
  Widget build(BuildContext context) {
    CursoService cursoService = CursoService();
    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 15.0, top: 50.0),
            child: Column(
              children: [
                funcaoCriarCurso(context),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: StreamBuilder(
                    stream: cursoService.firestoreRef.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      //Verifica existência de dados
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docSnapshot =
                                snapshot.data!.docs[index];
                            return Card(
                              color: Colors.black26,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Nome: " +
                                            docSnapshot.get('nome') +
                                            " - Tipo: " +
                                            docSnapshot.get('tipo')),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          iconSize: 25,
                                          onPressed: (() {}),
                                          icon: const Icon(Icons.edit),
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        IconButton(
                                          iconSize: 25,
                                          onPressed: () async {
                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Deseja realmente excluir o item selecionado?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelLarge,
                                                      ),
                                                      child: const Text(
                                                          'Cancelar'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelLarge,
                                                      ),
                                                      child:
                                                          const Text('Excluir'),
                                                      onPressed: () async {
                                                        bool isDeleted =
                                                            await cursoService
                                                                .deleteCurso(
                                                                    docSnapshot
                                                                        .id);
                                                        if (isDeleted) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: const Text(
                                                                  "Curso deletado com sucesso!"),
                                                              action:
                                                                  SnackBarAction(
                                                                label: "Fechar",
                                                                onPressed: () =>
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .hideCurrentSnackBar(),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text("Sem dados"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

ElevatedButton funcaoCriarCurso(context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Curso curso = Curso();
  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cadastro de Curso'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 5, width: 500),
                  TextFormField(
                    //Input Nome Curso
                    onSaved: (value) => curso.nome = value,
                    initialValue: curso.nome,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
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
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    //Input Tipo do Curso
                    onSaved: (value) {
                      curso.tipo = value;
                    },
                    initialValue: curso.tipo,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, entre com um tipo de Curso.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Tipo",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
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
                //Chama serviço de salvar Curso
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  CursoService cursoService = CursoService();
                  bool isAdded = await cursoService.adicionarCurso(curso);
                  if (isAdded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text("Curso Criado com sucesso!"),
                        action: SnackBarAction(
                          label: "Fechar",
                          onPressed: () => ScaffoldMessenger.of(context)
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
                        content: const Text("Problemas ao gravar dados."),
                        action: SnackBarAction(
                          label: "Fechar",
                          onPressed: () => ScaffoldMessenger.of(context)
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
        ),
      );
    },
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size(200, 40)),
    ),
    child: const Text("Cadastrar Curso"),
  );
}
