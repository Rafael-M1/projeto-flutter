import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'produto.dart';

class ProdutoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Produto? produto;
  late CollectionReference firestoreRef;

  ProdutoService() {
    firestoreRef = _firestore.collection('Produtos');
  }

  Future<bool> adicionarProduto(Produto produto) async {
    try {
      await _firestore.collection("Produtos").add(produto.toMap());
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }

  Future<Produto> getProduto(String idProduto) async {
    Produto produto =
        _firestore.collection("Produtos").doc(idProduto) as Produto;
    return produto;
  }

  Future<bool> updateProduto(Produto produto, String idProduto) async {
    try {
      await _firestore
          .collection("Produtos")
          .doc(idProduto)
          .set(produto.toMap());
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao atualizar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Alteração abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> deleteProduto(String idProduto) async {
    try {
      await _firestore.collection("Produtos").doc(idProduto).delete();
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao deletar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Deleção abortada');
      }
      return Future.value(false);
    }
  }
}
