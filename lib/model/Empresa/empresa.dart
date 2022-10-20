import 'package:cloud_firestore/cloud_firestore.dart';

class Empresa {
  String? idEmpresa;
  String? nome;

  //Método construtor
  Empresa({
    this.idEmpresa,
    this.nome,
  });

  Empresa.fromDocument(DocumentSnapshot doc) {
    idEmpresa = doc.id;
    nome = doc.get('nome');
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idEmpresa': idEmpresa,
      'nome': nome,
    };
  }
}
