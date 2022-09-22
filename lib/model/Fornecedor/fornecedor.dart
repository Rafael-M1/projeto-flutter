import 'package:cloud_firestore/cloud_firestore.dart';

class Fornecedor {
  String? id;
  String? nome;

  /*
  //Método construtor
  Produto({
    this.id,
    this.nome,
    this.descricao,
    this.unidade,
    this.preco,
  });

  Produto.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    nome = doc.get('nome');
    descricao = doc.get('descricao');
    unidade = doc.get('unidade') as String;
    preco = doc.get('preco') as String;
  }
  /*
  //Método para converter formato json em objetos
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      unidade: map['unidade'],
      preco: map['preco'],
    );
  }*/

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'unidade': unidade,
      'preco': preco,
    };
  */
}
