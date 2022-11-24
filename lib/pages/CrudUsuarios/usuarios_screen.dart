// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/user/user.dart';
import 'package:aplicacao/model/user/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
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
    UsuarioServices usuarioService = UsuarioServices();

    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 15.0, top: 50.0),
            child: Column(
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     Estudante estudante = Estudante();
                //     estudante.curso = Curso();
                //     showDialogUsuario(context, listaCursos, estudante);
                //   },
                //   child: const Text("Cadastrar Usuário"),
                // ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: StreamBuilder(
                              stream: usuarioService.firestoreRef.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                //Verifica existência de dados
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      Map<String, dynamic> usuarioMap =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      UserApp usuarioItem =
                                          UserApp.fromMap(usuarioMap);
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
                                                      usuarioItem.nome
                                                          .toString() +
                                                      " - E-mail: " +
                                                      usuarioItem.email
                                                          .toString()),
                                                  Text("Curso: " +
                                                      usuarioItem.estudante!
                                                          .curso!.nome
                                                          .toString() +
                                                      " - Tipo Curso: " +
                                                      usuarioItem.estudante!
                                                          .curso!.tipo
                                                          .toString()),
                                                  Text("Experiência Profissional: " +
                                                      usuarioItem.estudante!
                                                          .experienciaProfissional
                                                          .toString()),
                                                  Text("Previsão de Término do Curso: " +
                                                      usuarioItem.estudante!
                                                          .previsaoTerminoCurso
                                                          .toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    iconSize: 25,
                                                    tooltip: "Editar",
                                                    onPressed: (() {
                                                      showDialogUsuario(
                                                          context, usuarioItem);
                                                    }),
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    color: Colors.red,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  // IconButton(
                                                  //   iconSize: 25,
                                                  //   tooltip: "Excluir",
                                                  //   onPressed: () async {
                                                  //     showDialog<void>(
                                                  //       context: context,
                                                  //       builder: (BuildContext
                                                  //           context) {
                                                  //         return AlertDialog(
                                                  //           title: const Text(
                                                  //               'Deseja realmente excluir o item selecionado?'),
                                                  //           actions: <Widget>[
                                                  //             TextButton(
                                                  //               style: TextButton
                                                  //                   .styleFrom(
                                                  //                 textStyle: Theme.of(
                                                  //                         context)
                                                  //                     .textTheme
                                                  //                     .labelLarge,
                                                  //               ),
                                                  //               child: const Text(
                                                  //                   'Cancelar'),
                                                  //               onPressed: () {
                                                  //                 Navigator.of(
                                                  //                         context)
                                                  //                     .pop();
                                                  //               },
                                                  //             ),
                                                  //             TextButton(
                                                  //               style: TextButton
                                                  //                   .styleFrom(
                                                  //                 textStyle: Theme.of(
                                                  //                         context)
                                                  //                     .textTheme
                                                  //                     .labelLarge,
                                                  //               ),
                                                  //               child: const Text(
                                                  //                   'Excluir'),
                                                  //               onPressed:
                                                  //                   () async {
                                                  //                 // bool
                                                  //                 //     isDeleted =
                                                  //                 //     await estudanteService
                                                  //                 //         .deleteEstudante(
                                                  //                 //   estudanteItem
                                                  //                 //       .idEstudante
                                                  //                 //       .toString(),
                                                  //                 // );
                                                  //                 // if (isDeleted) {
                                                  //                 //   ScaffoldMessenger.of(
                                                  //                 //           context)
                                                  //                 //       .showSnackBar(
                                                  //                 //     SnackBar(
                                                  //                 //       content:
                                                  //                 //           const Text("Estudante excluído com sucesso!"),
                                                  //                 //       action:
                                                  //                 //           SnackBarAction(
                                                  //                 //         label:
                                                  //                 //             "Fechar",
                                                  //                 //         onPressed: () =>
                                                  //                 //             ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                                                  //                 //       ),
                                                  //                 //     ),
                                                  //                 //   );
                                                  //                 // }
                                                  //                 // Navigator.of(
                                                  //                 //         context)
                                                  //                 //     .pop();
                                                  //               },
                                                  //             ),
                                                  //           ],
                                                  //         );
                                                  //       },
                                                  //     );
                                                  //   },
                                                  //   icon: const Icon(
                                                  //     Icons.delete,
                                                  //     color: Colors.red,
                                                  //   ),
                                                  // )
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future showDialogUsuario(context, UserApp usuarioItem) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserApp usuarioCadastro = usuarioItem;
  return showDialog(
    context: context,
    builder: (context) {
      CursoService cursoServiceCadastro = CursoService();
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
                  onSaved: (value) => usuarioCadastro.nome = value,
                  initialValue: usuarioCadastro.nome,
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
                FutureBuilder(
                  future: cursoServiceCadastro.getCursoList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Curso> listaCursos = snapshot.data as List<Curso>;
                      List<DropdownMenuItem<Curso>> cursoItems = [];
                      for (int i = 0; i < listaCursos.length; i++) {
                        cursoItems.add(
                          DropdownMenuItem(
                            value: listaCursos.elementAt(i),
                            child: Text(
                              listaCursos.elementAt(i).nome.toString(),
                            ),
                          ),
                        );
                      }
                      return DropdownButtonFormField<Curso>(
                        items: cursoItems,
                        onSaved: (curso) {
                          usuarioCadastro.estudante?.curso = curso;
                        },
                        onChanged: (curso) {
                          usuarioCadastro.estudante?.curso = curso;
                        },
                        validator: (value) =>
                            value == null ? 'Selecione um Curso' : null,
                        hint: const Text("Escolha um Curso"),
                        value: cursoItems[0].value,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  //Input PrevisaoTerminoCurso do Estudante
                  onSaved: (value) =>
                      usuarioCadastro.estudante?.previsaoTerminoCurso = value,
                  initialValue: usuarioCadastro.estudante?.previsaoTerminoCurso,
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
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  //Input experienciaProfissional do Estudante
                  onSaved: (value) => usuarioCadastro
                      .estudante?.experienciaProfissional = value,
                  initialValue:
                      usuarioCadastro.estudante?.experienciaProfissional,
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
              //Chama serviço de salvar Usuario
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                UsuarioServices usuarioService = UsuarioServices();
                // if (usuarioCadastro.id == null) {
                //   bool isAdded = await usuarioService.addUsuario(usuarioCadastro, usuarioCadastro.id);
                //   if (isAdded) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         backgroundColor: Colors.green,
                //         content: const Text("Estudante Criado com sucesso!"),
                //         action: SnackBarAction(
                //           label: "Fechar",
                //           onPressed: () => ScaffoldMessenger.of(context)
                //               .hideCurrentSnackBar(),
                //         ),
                //       ),
                //     );
                //     _formKey.currentState!.reset();
                //     Navigator.pop(context);
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         backgroundColor: Colors.red,
                //         content: const Text("Problemas ao gravar dados."),
                //         action: SnackBarAction(
                //           label: "Fechar",
                //           onPressed: () => ScaffoldMessenger.of(context)
                //               .hideCurrentSnackBar(),
                //         ),
                //       ),
                //     );
                //   }
                // } else {
                bool isUpdated = await usuarioService.updateUsuario(
                  usuarioCadastro,
                  usuarioCadastro.id.toString(),
                );
                if (isUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: const Text("Estudante Alterado com sucesso!"),
                      action: SnackBarAction(
                        label: "Fechar",
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
                  _formKey.currentState!.reset();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text("Problemas ao atualizar dados."),
                      action: SnackBarAction(
                        label: "Fechar",
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
                }
                // }
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
