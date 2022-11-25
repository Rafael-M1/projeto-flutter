// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/OfertaEstagio/oferta_estagio.dart';
import 'package:aplicacao/model/OfertaEstagio/oferta_estagio_service.dart';
import 'package:aplicacao/model/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OfertaEstagioScreen extends StatefulWidget {
  OfertaEstagioScreen(
      {Key? key, required this.cursoParam, required this.usuarioLogadoParam})
      : super(key: key);
  Curso cursoParam;
  UserApp usuarioLogadoParam;

  @override
  State<OfertaEstagioScreen> createState() => _OfertaEstagioScreenState();
}

class _OfertaEstagioScreenState extends State<OfertaEstagioScreen> {
  @override
  Widget build(BuildContext context) {
    OfertaEstagioService ofertaEstagioService = OfertaEstagioService();
    return Center(
      child: Container(
        height: 800,
        width: 1200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Vagas de Estágio",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(height: 30),
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
                            //Busca Ofertas de Estágio que não estão preenchidos
                            stream: ofertaEstagioService.firestoreRef
                                .where("status", isEqualTo: "Não-preenchido")
                                .where("curso.nome",
                                    isEqualTo: widget.cursoParam.nome)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              //Verifica existência de dados

                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data!.size > 0) {
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                  ),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    Map<String, dynamic> ofertaEstagioMap =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    OfertaEstagio ofertaEstagioItem =
                                        OfertaEstagio.fromMap(ofertaEstagioMap);
                                    // print(ofertaEstagioItem.toString());
                                    bool estudantePertenceLista = false;
                                    ofertaEstagioItem.listaEstudantesCandidatos
                                        ?.forEach(
                                      (element) {
                                        if (element.id ==
                                            widget.usuarioLogadoParam.id) {
                                          estudantePertenceLista = true;
                                        }
                                      },
                                    );
                                    return Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(children: [
                                          const Text(
                                            "Oferta de Estágio",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(height: 20),
                                          Text("Empresa: " +
                                              ofertaEstagioItem.empresa!.nome
                                                  .toString()),
                                          const SizedBox(height: 10),
                                          Text("Local de Estágio: " +
                                              ofertaEstagioItem
                                                  .empresa!.endereco
                                                  .toString()),
                                          const SizedBox(height: 10),
                                          Text("Curso: " +
                                              ofertaEstagioItem.curso!.nome
                                                  .toString()),
                                          const SizedBox(height: 10),
                                          Text("Período do Estágio: " +
                                              ofertaEstagioItem.periodo
                                                  .toString()),
                                          const SizedBox(height: 10),
                                          Text("Remuneração: " +
                                              ofertaEstagioItem.remuneracao
                                                  .toString()),
                                          const SizedBox(height: 15),
                                          ElevatedButton(
                                            onPressed: (() {
                                              if (!estudantePertenceLista) {
                                                ofertaEstagioService
                                                    .adicionarEstudanteParaListaEstudantesCandidatos(
                                                  widget.usuarioLogadoParam,
                                                  ofertaEstagioItem,
                                                );
                                              }
                                            }),
                                            child: estudantePertenceLista
                                                ? const Text("Já me candidatei")
                                                : const Text("Candidatar-se"),
                                          ),
                                        ]),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.data?.size == 0) {
                                return const Center(
                                  child: Text(
                                      "Não há ofertas de estágio para o seu Curso."),
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
    );
  }
}
