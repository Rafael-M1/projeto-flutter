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

  Curso.fromMap(Map<String, dynamic> map) {
    idCurso = map['idCurso'];
    nome = map['nome'];
    tipo = map['tipo'];
  }

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

  Map<String, dynamic> toJson() {
    return {
      "idCurso": idCurso,
      "nome": nome,
      "tipo": tipo,
    };
  }

  factory Curso.fromJson(dynamic json) {
    return Curso(
      idCurso: json['idCurso'],
      nome: json['nome'],
      tipo: json['tipo'],
    );
  }

  @override
  String toString() {
    return "Curso($idCurso - $nome - $tipo)";
  }
}
