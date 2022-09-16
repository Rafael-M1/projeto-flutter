import 'package:aplicacao/model/Produto/produto.dart';
import 'package:aplicacao/model/Produto/produto_service.dart';
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              produtoService.addProduto(
                Produto(
                  nome: 'Computador',
                  descricao: 'Desktop',
                  preco: '1500',
                  unidade: '1 un',
                ),
              );
            },
            child: const Text("Adicionar Produto Teste"),
          ),
          const SizedBox(
            height: 50,
          ),
          /*StreamBuilder(
            stream: produtoService.firestoreRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //Verifica existência de dados
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                    return Card(
                      child: Text(
                        docSnapshot.get('nome'),
                      ),
                    );
                  },
                );
              }
              return const Center();
            },
          ),*/
        ],
      ),
    );
  }
}
