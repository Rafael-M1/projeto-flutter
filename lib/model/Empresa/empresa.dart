import 'package:cloud_firestore/cloud_firestore.dart';

class Empresa {
  String? idEmpresa;
  String? nome;
  String? endereco;

  //Método construtor
  Empresa({
    this.idEmpresa,
    this.nome,
    this.endereco,
  });

  Empresa.fromMap(Map<String, dynamic> map) {
    idEmpresa = map['idEmpresa'];
    nome = map['nome'];
    endereco = map['endereco'];
  }

  Empresa.fromDocument(DocumentSnapshot doc) {
    idEmpresa = doc.id;
    nome = doc.get('nome');
    endereco = doc.get('endereco');
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idEmpresa': idEmpresa,
      'nome': nome,
      'endereco': endereco,
    };
  }

  @override
  String toString() {
    return "Empresa($idEmpresa - $nome - $endereco )";
  }
}
