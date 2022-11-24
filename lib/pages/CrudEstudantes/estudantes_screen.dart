// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/model/Estudante/estudante_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                    // Estudante estudante = Estudante();
                    // estudante.curso = Curso();
                    // showDialogEstudante(context, listaCursos, estudante);
                  },
                  child: const Text("Cadastrar Estudante"),
                ),
                const SizedBox(height: 50),
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
                              stream: estudanteService.firestoreRef.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                //Verifica existência de dados
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      Map<String, dynamic> estudanteMap =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      Estudante estudanteItem =
                                          Estudante.fromMap(estudanteMap);
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
                                                  const Text("a"),
                                                  // Text("Nome: " +
                                                  //     estudanteItem.nome
                                                  //         .toString() +
                                                  //     "- E-mail: " +
                                                  //     estudanteItem.email
                                                  //         .toString()),
                                                  // Text("Curso: " +
                                                  //     estudanteItem.curso!.nome
                                                  //         .toString() +
                                                  //     " - Tipo Curso: " +
                                                  //     estudanteItem.curso!.tipo
                                                  //         .toString()),
                                                  // Text("Experiência Profissional: " +
                                                  //     estudanteItem
                                                  //         .experienciaProfissional
                                                  //         .toString()),
                                                  // Text("Previsão de Término do Curso: " +
                                                  //     estudanteItem
                                                  //         .previsaoTerminoCurso
                                                  //         .toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    iconSize: 25,
                                                    tooltip: "Editar",
                                                    onPressed: (() {
                                                      // showDialogEstudante(
                                                      //     context,
                                                      //     listaCursos,
                                                      //     estudanteItem);
                                                    }),
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    color: Colors.red,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  IconButton(
                                                    iconSize: 25,
                                                    tooltip: "Excluir",
                                                    onPressed: () async {
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Deseja realmente excluir o item selecionado?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                                child: const Text(
                                                                    'Cancelar'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                                child: const Text(
                                                                    'Excluir'),
                                                                onPressed:
                                                                    () async {
                                                                  // bool
                                                                  //     isDeleted =
                                                                  //     await estudanteService
                                                                  //         .deleteEstudante(
                                                                  //   estudanteItem
                                                                  //       .idEstudante
                                                                  //       .toString(),
                                                                  // );
                                                                  // if (isDeleted) {
                                                                  //   ScaffoldMessenger.of(
                                                                  //           context)
                                                                  //       .showSnackBar(
                                                                  //     SnackBar(
                                                                  //       content:
                                                                  //           const Text("Estudante excluído com sucesso!"),
                                                                  //       action:
                                                                  //           SnackBarAction(
                                                                  //         label:
                                                                  //             "Fechar",
                                                                  //         onPressed: () =>
                                                                  //             ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                                                                  //       ),
                                                                  //     ),
                                                                  //   );
                                                                  // }
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Future showDialogEstudante(
//     context, List<Curso> listaCursos, Estudante estudanteParam) {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Estudante estudante;
//   if (estudanteParam.idEstudante != null) {
//     estudante = estudanteParam;
//   } else {
//     estudante = Estudante();
//     Curso cursoEstudante = Curso();
//     estudante.curso = cursoEstudante;
//   }
//   return showDialog(
//     context: context,
//     builder: (context) {
//       List<DropdownMenuItem<String>> cursoItems = [];
//       for (int i = 0; i < listaCursos.length; i++) {
//         cursoItems.add(
//           DropdownMenuItem(
//             value: listaCursos.elementAt(i).idCurso,
//             child: Text(
//               listaCursos.elementAt(i).nome.toString(),
//             ),
//           ),
//         );
//       }
//       return AlertDialog(
//         title: estudante.idEstudante == null
//             ? const Text('Cadastro de Estudante')
//             : const Text('Atualização de Estudante'),
//         content: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 5, width: 500),
//                 TextFormField(
//                   //Input Nome Estudante
//                   onSaved: (value) => estudante.nome = value,
//                   initialValue: estudante.nome,
//                   keyboardType: TextInputType.text,
//                   style: const TextStyle(fontSize: 18.0),
//                   validator: (value) {
//                     if (value == null || value.isEmpty || value.length < 4) {
//                       return 'Por favor, entre com um nome.';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Nome",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Colors.blueGrey,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   //Input Email do Estudante
//                   onSaved: (value) => estudante.email = value,
//                   initialValue: estudante.email,
//                   keyboardType: TextInputType.emailAddress,
//                   style: const TextStyle(fontSize: 18.0),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Por favor, entre com um e-mail.';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "E-mail",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Colors.blueGrey,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 DropdownButtonFormField<String>(
//                   items: cursoItems,
//                   onSaved: (idCurso) {
//                     estudante.curso!.idCurso = idCurso;
//                   },
//                   onChanged: (idCurso) {
//                     estudante.curso!.idCurso = idCurso;
//                   },
//                   validator: (value) =>
//                       value == null ? 'Selecione um Curso' : null,
//                   hint: const Text("Escolha um Curso"),
//                   value: estudante.curso!.idCurso,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   //Input PrevisaoTerminoCurso do Estudante
//                   onSaved: (value) => estudante.previsaoTerminoCurso = value,
//                   initialValue: estudante.previsaoTerminoCurso,
//                   keyboardType: TextInputType.text,
//                   style: const TextStyle(fontSize: 18.0),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Por favor, entre com a previsão de término do Curso atual.';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Previsão Término de Curso",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Colors.blueGrey,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   //Input experienciaProfissional do Estudante
//                   onSaved: (value) => estudante.experienciaProfissional = value,
//                   initialValue: estudante.experienciaProfissional,
//                   keyboardType: TextInputType.text,
//                   style: const TextStyle(fontSize: 18.0),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Por favor, entre com a experiência profissional.';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Experiência Profissional",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Colors.blueGrey,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Voltar'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               //Chama serviço de salvar Estudante
//               if (_formKey.currentState!.validate()) {
//                 _formKey.currentState!.save();
//                 EstudanteService estudanteService = EstudanteService();
//                 if (estudante.idEstudante == null) {
//                   bool isAdded =
//                       await estudanteService.adicionarEstudante(estudante);
//                   if (isAdded) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Colors.green,
//                         content: const Text("Estudante Criado com sucesso!"),
//                         action: SnackBarAction(
//                           label: "Fechar",
//                           onPressed: () => ScaffoldMessenger.of(context)
//                               .hideCurrentSnackBar(),
//                         ),
//                       ),
//                     );
//                     _formKey.currentState!.reset();
//                     Navigator.pop(context);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Colors.red,
//                         content: const Text("Problemas ao gravar dados."),
//                         action: SnackBarAction(
//                           label: "Fechar",
//                           onPressed: () => ScaffoldMessenger.of(context)
//                               .hideCurrentSnackBar(),
//                         ),
//                       ),
//                     );
//                   }
//                 } else {
//                   bool isUpdated = await estudanteService.updateEstudante(
//                     estudante,
//                     estudante.idEstudante.toString(),
//                   );
//                   if (isUpdated) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Colors.green,
//                         content: const Text("Estudante Alterado com sucesso!"),
//                         action: SnackBarAction(
//                           label: "Fechar",
//                           onPressed: () => ScaffoldMessenger.of(context)
//                               .hideCurrentSnackBar(),
//                         ),
//                       ),
//                     );
//                     _formKey.currentState!.reset();
//                     Navigator.pop(context);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Colors.red,
//                         content: const Text("Problemas ao atualizar dados."),
//                         action: SnackBarAction(
//                           label: "Fechar",
//                           onPressed: () => ScaffoldMessenger.of(context)
//                               .hideCurrentSnackBar(),
//                         ),
//                       ),
//                     );
//                   }
//                 }
//               }
//             },
//             child: const Text('Salvar'),
//           ),
//         ],
//       );
//     },
//   );
// }
