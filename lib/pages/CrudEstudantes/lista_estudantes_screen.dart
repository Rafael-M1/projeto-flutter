// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/model/Estudante/estudante_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaEstudanteScreen extends StatefulWidget {
  const ListaEstudanteScreen({super.key});

  @override
  State<ListaEstudanteScreen> createState() => _ListaEstudanteScreenState();
}

class _ListaEstudanteScreenState extends State<ListaEstudanteScreen> {
  @override
  Widget build(BuildContext context) {
    EstudanteService estudanteService = EstudanteService();
    return SingleChildScrollView(
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
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //Verifica existência de dados
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
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
                                      Text("Nome: " +
                                          estudanteItem.nome.toString() +
                                          "- E-mail: " +
                                          estudanteItem.email.toString()),
                                      Text("Curso: " +
                                          estudanteItem.curso!.nome.toString() +
                                          " - Tipo Curso: " +
                                          estudanteItem.curso!.tipo.toString()),
                                      Text("Experiência Profissional: " +
                                          estudanteItem.experienciaProfissional
                                              .toString() +
                                          " - Previsão de Término do Curso: " +
                                          estudanteItem.previsaoTerminoCurso
                                              .toString()),
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
                                                    style: TextButton.styleFrom(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge,
                                                    ),
                                                    child:
                                                        const Text('Cancelar'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge,
                                                    ),
                                                    child:
                                                        const Text('Excluir'),
                                                    onPressed: () async {
                                                      bool isDeleted =
                                                          await estudanteService
                                                              .deleteEstudante(
                                                        estudanteItem
                                                            .idEstudante
                                                            .toString(),
                                                      );
                                                      if (isDeleted) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: const Text(
                                                                "Estudante deletado com sucesso!"),
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
    );
  }
}
