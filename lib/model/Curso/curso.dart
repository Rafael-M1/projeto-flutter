import 'package:cloud_firestore/cloud_firestore.dart';

class Curso {
  String? idCurso;
  String? nome;
  String? tipo;

  //Método construtor
  Curso({
    this.idCurso,
    this.nome,
    this.tipo,
  });

  Curso.fromDocument(DocumentSnapshot doc) {
    idCurso = doc.id;
    nome = doc.get('nome');
    tipo = doc.get('tipo');
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idCurso': idCurso,
      'nome': nome,
      'tipo': tipo,
    };
  }
}
