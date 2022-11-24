// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Empresa/empresa.dart';
import 'package:aplicacao/model/Empresa/empresa_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastroEmpresaScreen extends StatefulWidget {
  const CadastroEmpresaScreen({super.key});

  @override
  State<CadastroEmpresaScreen> createState() => _CadastroEmpresaScreenState();
}

class _CadastroEmpresaScreenState extends State<CadastroEmpresaScreen> {
  @override
  Widget build(BuildContext context) {
    EmpresaService empresaService = EmpresaService();
    final Empresa empresa = Empresa();
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
                    showDialogEmpresa(context, empresa);
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(200, 40)),
                  ),
                  child: const Text("Cadastrar Empresa"),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: StreamBuilder(
                    stream: empresaService.firestoreRef.snapshots(),
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
                                        Text(
                                            "Nome: " + docSnapshot.get('nome')),
                                        Text("Endereço: " +
                                            docSnapshot.get('endereco')),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          iconSize: 25,
                                          tooltip: "Editar",
                                          onPressed: (() {
                                            Empresa empresa = Empresa();
                                            empresa.idEmpresa = docSnapshot
                                                .get('idEmpresa')
                                                .toString();
                                            empresa.nome =
                                                docSnapshot.get('nome');
                                            empresa.endereco =
                                                docSnapshot.get('endereco');
                                            showDialogEmpresa(context, empresa);
                                          }),
                                          icon: const Icon(Icons.edit),
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
                                                            await empresaService
                                                                .deleteEmpresa(
                                                                    docSnapshot
                                                                        .id);
                                                        if (isDeleted) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: const Text(
                                                                  "Empresa excluída com sucesso!"),
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

Future showDialogEmpresa(context, Empresa empresa) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: empresa.idEmpresa == null
          ? const Text('Cadastro de Empresa')
          : const Text('Atualização de Empresa'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 5, width: 500),
              TextFormField(
                //Input Nome Empresa
                onSaved: (value) => empresa.nome = value,
                initialValue: empresa.nome,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 18.0),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'Por favor, entre com um nome.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Nome da Empresa",
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
              //Input Endereço da Oferta de Estágio
              TextFormField(
                onSaved: (value) => empresa.endereco = value,
                initialValue: empresa.endereco,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 18.0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, entre com um Endereço.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Endereço",
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
            //Chama serviço de salvar Empresa
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              EmpresaService empresaService = EmpresaService();
              if (empresa.idEmpresa == null) {
                bool isAdded = await empresaService.adicionarEmpresa(empresa);
                if (isAdded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: const Text("Empresa Criada com sucesso!"),
                      action: SnackBarAction(
                        label: "Fechar",
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
                  formKey.currentState!.reset();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text("Problemas ao gravar dados."),
                      action: SnackBarAction(
                        label: "Fechar",
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
                }
              } else {
                bool isUpdated = await empresaService.updateEmpresa(
                  empresa,
                  empresa.idEmpresa.toString(),
                );
                if (isUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: const Text("Empresa Alterada com sucesso!"),
                      action: SnackBarAction(
                        label: "Fechar",
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
                  formKey.currentState!.reset();
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
              }
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}
