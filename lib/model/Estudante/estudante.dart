import 'package:aplicacao/model/Curso/curso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Estudante {
  String? idEstudante;
  String? nome;
  String? email;
  String? idCurso;
  Curso? curso;
  String? previsaoTerminoCurso;
  String? experienciaProfissional;

  //Método construtor
  Estudante({
    this.idEstudante,
    this.nome,
    this.email,
    this.curso,
    this.previsaoTerminoCurso,
    this.experienciaProfissional,
  });

  Estudante.fromDocument(DocumentSnapshot doc) {
    idEstudante = doc.id;
    nome = doc.get('nome');
    email = doc.get('email');
    idCurso = doc.get('idCurso');
    previsaoTerminoCurso = doc.get('previsaoTerminoCurso');
    experienciaProfissional = doc.get('experienciaProfissional');
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idEstudante': idEstudante,
      'nome': nome,
      'email': email,
      'idCurso': curso?.idCurso,
      'previsaoTerminoCurso': previsaoTerminoCurso,
      'experienciaProfissional': experienciaProfissional,
    };
  }
}
