import 'package:cloud_firestore/cloud_firestore.dart';

import 'produto.dart';

class ProdutoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Produto? produto;
  late CollectionReference firestoreRef;

  ProdutoService() {
    firestoreRef = _firestore.collection('Produtos');
  }

  void addProduto(Produto produto) async {
    await _firestore.collection("Produtos").add(produto.toMap());
  }
}