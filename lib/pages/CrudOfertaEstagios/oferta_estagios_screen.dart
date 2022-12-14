// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Empresa/empresa.dart';
import 'package:aplicacao/model/Empresa/empresa_service.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/model/OfertaEstagio/oferta_estagio.dart';
import 'package:aplicacao/model/OfertaEstagio/oferta_estagio_service.dart';
import 'package:aplicacao/model/user/user.dart';
import 'package:aplicacao/model/user/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastroOfertaEstagioScreen extends StatefulWidget {
  const CadastroOfertaEstagioScreen({super.key});

  @override
  State<CadastroOfertaEstagioScreen> createState() =>
      _CadastroOfertaEstagioScreenState();
}

class _CadastroOfertaEstagioScreenState
    extends State<CadastroOfertaEstagioScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CursoService cursoService = CursoService();
  EmpresaService empresaService = EmpresaService();
  OfertaEstagioService ofertaEstagioService = OfertaEstagioService();

  late List<Curso> listaCursos;
  late List<Empresa> listaEmpresas;
  List<Estudante> listaEstudantesCandidatos = [];
  Estudante estudanteSelecionado = Estudante();

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    listaCursos = await cursoService.getCursoList();
    listaEmpresas = await empresaService.getEmpresaList();
  }

  @override
  Widget build(BuildContext context) {
    String idEstudanteSelecionado = "";
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
                    showDialogOfertaEstagio(
                        context, listaCursos, listaEmpresas, OfertaEstagio());
                  },
                  child: const Text("Cadastrar Oferta de Est??gio"),
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
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: StreamBuilder(
                              stream:
                                  ofertaEstagioService.firestoreRef.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                //Verifica exist??ncia de dados
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> ofertaEstagioMap =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      // print(ofertaEstagioMap);
                                      OfertaEstagio ofertaEstagioItem =
                                          OfertaEstagio.fromMap(
                                              ofertaEstagioMap);
                                      //print(ofertaEstagioItem);
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
                                                  Text("C??digo Oferta: " +
                                                      ofertaEstagioItem
                                                          .idOfertaEstagio
                                                          .toString() +
                                                      " - Per??odo: " +
                                                      ofertaEstagioItem.periodo
                                                          .toString()),
                                                  Text("Remunera????o: R\$" +
                                                      ofertaEstagioItem
                                                          .remuneracao
                                                          .toString() +
                                                      " - Status: " +
                                                      ofertaEstagioItem.status
                                                          .toString()),
                                                  Text("Empresa: " +
                                                      ofertaEstagioItem
                                                          .empresa!.nome
                                                          .toString() +
                                                      " - Curso: " +
                                                      ofertaEstagioItem
                                                          .curso!.nome
                                                          .toString()),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    iconSize: 25,
                                                    tooltip: ofertaEstagioItem
                                                                .listaEstudantesCandidatos !=
                                                            null
                                                        ? "Escolher Estudante"
                                                        : "N??o h?? candidatos",
                                                    onPressed: (() {
                                                      if (ofertaEstagioItem
                                                              .listaEstudantesCandidatos !=
                                                          null) {
                                                        showDialogEscolherEstudante(
                                                            context,
                                                            ofertaEstagioItem);
                                                      }
                                                    }),
                                                    icon: const Icon(Icons
                                                        .ads_click_rounded),
                                                    color: ofertaEstagioItem
                                                                .listaEstudantesCandidatos !=
                                                            null
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  IconButton(
                                                    iconSize: 25,
                                                    tooltip: "Editar",
                                                    onPressed: (() {
                                                      showDialogOfertaEstagio(
                                                          context,
                                                          listaCursos,
                                                          listaEmpresas,
                                                          ofertaEstagioItem);
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
                                                      OfertaEstagioService
                                                          ofertaEstagioService =
                                                          OfertaEstagioService();
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                              'Deseja realmente excluir o item selecionado?',
                                                            ),
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
                                                                  bool
                                                                      isDeleted =
                                                                      await ofertaEstagioService
                                                                          .deleteOfertaEstagio(
                                                                    ofertaEstagioItem
                                                                        .idOfertaEstagio
                                                                        .toString(),
                                                                  );
                                                                  if (isDeleted) {
                                                                    ScaffoldMessenger
                                                                        .of(
                                                                      context,
                                                                    ).showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            const Text("Estudante exclu??do com sucesso!"),
                                                                        action:
                                                                            SnackBarAction(
                                                                          label:
                                                                              "Fechar",
                                                                          onPressed: () =>
                                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  Navigator.of(
                                                                          context)
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future showDialogOfertaEstagio(
  context,
  List<Curso> listaCursos,
  List<Empresa> listaEmpresas,
  OfertaEstagio ofertaEstagioCadastro,
) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (context) {
      OfertaEstagio ofertaEstagio = ofertaEstagioCadastro;
      if (ofertaEstagio.idOfertaEstagio == null) {
        ofertaEstagio.curso = Curso();
        ofertaEstagio.empresa = Empresa();
      }
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
      List<DropdownMenuItem<String>> empresaItems = [];
      for (int i = 0; i < listaEmpresas.length; i++) {
        empresaItems.add(
          DropdownMenuItem(
            value: listaEmpresas.elementAt(i).idEmpresa,
            child: Text(
              listaEmpresas.elementAt(i).nome.toString(),
            ),
          ),
        );
      }
      return AlertDialog(
        title: const Text('Cadastro de Oferta de Est??gio'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 5, width: 500),
                //Input Periodo OfertaEstagio
                TextFormField(
                  onSaved: (value) => ofertaEstagio.periodo = value,
                  initialValue: ofertaEstagio.periodo,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18.0),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Por favor, entre com um per??odo.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Per??odo do Est??gio",
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
                //Input Remunera????o da Oferta de Est??gio
                TextFormField(
                  onSaved: (value) => ofertaEstagio.remuneracao = value,
                  initialValue: ofertaEstagio.remuneracao,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, entre com uma remunera????o.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Remunera????o",
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
                //Dropdown Cursos
                DropdownButtonFormField<String>(
                  items: cursoItems,
                  onSaved: (idCurso) {
                    ofertaEstagio.curso!.idCurso = idCurso;
                  },
                  onChanged: (idCurso) {
                    ofertaEstagio.curso!.idCurso = idCurso;
                  },
                  validator: (value) =>
                      value == null ? 'Selecione um Curso' : null,
                  hint: const Text("Escolha um Curso"),
                  value: ofertaEstagio.curso!.idCurso,
                ),
                const SizedBox(height: 10),
                //Dropdown Empresas
                DropdownButtonFormField<String>(
                  items: empresaItems,
                  onSaved: (idEmpresa) {
                    ofertaEstagio.empresa!.idEmpresa = idEmpresa;
                  },
                  onChanged: (idEmpresa) {
                    ofertaEstagio.empresa!.idEmpresa = idEmpresa;
                  },
                  validator: (value) =>
                      value == null ? 'Selecione uma Empresa' : null,
                  hint: const Text("Escolha uma Empresa"),
                  value: ofertaEstagio.empresa!.idEmpresa,
                ),
                const SizedBox(height: 10),
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
              //Chama servi??o de salvar Estudante
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                OfertaEstagioService ofertaEstagioService =
                    OfertaEstagioService();
                if (ofertaEstagio.idOfertaEstagio == null) {
                  ofertaEstagio.status = "N??o-preenchido";
                  bool isAdded = await ofertaEstagioService
                      .adicionarOfertaEstagio(ofertaEstagio);
                  if (isAdded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content:
                            const Text("Oferta de Est??gio Criada com sucesso!"),
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
                } else {
                  //
                  bool isUpdated =
                      await ofertaEstagioService.updateOfertaEstagio(
                    ofertaEstagio,
                    ofertaEstagio.idOfertaEstagio.toString(),
                  );
                  if (isUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text(
                            "Oferta de Est??gio alterada com sucesso!"),
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
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}

Future showDialogEscolherEstudante(
  context,
  OfertaEstagio ofertaEstagioCadastro,
) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  print(ofertaEstagioCadastro.listaEstudantesCandidatos);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(''),
        content: SingleChildScrollView(
          child: Container(
            height: 1000,
            width: 500,
            child: Column(
              children: [
                // const SizedBox(height: 5, width: 500),
                const Text("Lista de Candidatos"),
                Center(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:
                        ofertaEstagioCadastro.listaEstudantesCandidatos!.length,
                    itemBuilder: (context, index) {
                      UserApp estudanteItem = ofertaEstagioCadastro
                          .listaEstudantesCandidatos!
                          .elementAt(index);
                      return Card(
                        color: Colors.black26,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Nome: " + estudanteItem.nome.toString()),
                                  Text("Experi??ncia Profissional: " +
                                      estudanteItem
                                          .estudante!.experienciaProfissional
                                          .toString()),
                                  Text("Previs??o de T??rmino do Curso: " +
                                      estudanteItem
                                          .estudante!.previsaoTerminoCurso
                                          .toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    iconSize: 25,
                                    tooltip: ofertaEstagioCadastro
                                                .estudanteSelecionado!.id ==
                                            estudanteItem.id
                                        ? "Estudante Selecionado"
                                        : "Selecionar Estudante",
                                    onPressed: (() {
                                      OfertaEstagioService
                                          ofertaEstagioService =
                                          OfertaEstagioService();
                                      ofertaEstagioCadastro
                                          .estudanteSelecionado = estudanteItem;
                                      ofertaEstagioCadastro.status =
                                          "Preenchido"; //idEstudanteSelecionado

                                      ofertaEstagioService.updateOfertaEstagio(
                                          ofertaEstagioCadastro,
                                          ofertaEstagioCadastro.idOfertaEstagio
                                              .toString());
                                      estudanteItem.estudante!.isEstagiando =
                                          "sim";
                                      UsuarioServices usuarioServices =
                                          UsuarioServices();
                                      usuarioServices.updateUsuario(
                                          estudanteItem,
                                          estudanteItem.id.toString());

                                      if (ofertaEstagioCadastro
                                              .listaEstudantesCandidatos !=
                                          null) {
                                        for (var element
                                            in ofertaEstagioCadastro
                                                .listaEstudantesCandidatos!
                                                .toList()) {
                                          if (element.id != estudanteItem.id) {
                                            element.estudante!.isEstagiando =
                                                "nao";
                                            usuarioServices.updateUsuario(
                                                element, element.id.toString());
                                          }
                                        }
                                      }
                                    }),
                                    icon: const Icon(Icons.edit),
                                    color: ofertaEstagioCadastro
                                                .estudanteSelecionado!.id ==
                                            estudanteItem.id
                                        ? Colors.yellow
                                        : Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
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
        ],
      );
    },
  );
}
