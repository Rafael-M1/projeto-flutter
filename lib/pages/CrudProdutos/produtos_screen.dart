// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:aplicacao/model/Produto/produto.dart';
import 'package:aplicacao/model/Produto/produto_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  @override
  Widget build(BuildContext context) {
    ProdutoService produtoService = ProdutoService();
    return Scaffold(
      backgroundColor: ThemeData.dark().backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 15.0, top: 50.0),
              child: Column(
                children: [
                  funcaoCriarProduto(context),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: StreamBuilder(
                      stream: produtoService.firestoreRef.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                              " - Descrição: " +
                                              docSnapshot.get('descricao')),
                                          const SizedBox(height: 8),
                                          Text("Unidade: " +
                                              docSnapshot.get('unidade') +
                                              " - Preço: R\$ " +
                                              docSnapshot.get('preco')),
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
                                              bool isDeleted =
                                                  await produtoService
                                                      .deleteProduto(
                                                          docSnapshot.id);
                                              if (isDeleted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                        "Produto deletado com sucesso!"),
                                                    action: SnackBarAction(
                                                      label: "Fechar",
                                                      onPressed: () =>
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentSnackBar(),
                                                    ),
                                                  ),
                                                );
                                              }
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
      ),
    );
  }

  ElevatedButton funcaoCriarProduto(context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final Produto produto = Produto();
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cadastro de Produto'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 5, width: 500),
                    TextFormField(
                      //Input Nome Produto
                      onSaved: (value) => produto.nome = value,
                      initialValue: produto.nome,
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      //Input Descrição do Produto
                      onSaved: (value) => produto.descricao = value,
                      initialValue: produto.descricao,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 18.0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, entre com uma descrição do Produto.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Descrição",
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
                      //Input Unidade do Produto
                      onSaved: (value) => produto.unidade = value,
                      initialValue: produto.unidade,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 18.0),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().split('').length <= 1) {
                          return 'Por favor, entre com a Unidade do Produto.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Unidade",
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
                      //Input Preço do Produto
                      onSaved: (value) => produto.preco = value,
                      initialValue: produto.preco,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      style: const TextStyle(fontSize: 18.0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, entre com o preço do Produto.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Preço",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                  //Chama serviço de salvar Produto
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ProdutoService produtoService = ProdutoService();
                    bool isAdded =
                        await produtoService.adicionarProduto(produto);
                    if (isAdded && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: const Text("Produto Criado com sucesso!"),
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
      child: const Text("Cadastrar Produto"),
    );
  }
}
