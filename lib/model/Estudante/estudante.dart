import 'dart:html';

import 'package:aplicacao/model/Curso/curso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Estudante {
  String? idEstudante;
  String? nome;
  String? email;
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
    curso?.idCurso = doc.get('idCurso');
    previsaoTerminoCurso = doc.get('previsaoTerminoCurso');
    experienciaProfissional = doc.get('experienciaProfissional');
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idEstudante': idEstudante,
      'nome': nome,
      'email': email,
      'curso': {
        'idCurso': curso?.idCurso,
        'nome': curso?.nome,
        'tipo': curso?.tipo,
      },
      'previsaoTerminoCurso': previsaoTerminoCurso,
      'experienciaProfissional': experienciaProfissional,
    };
  }

  Estudante.fromMap(Map<String, dynamic> map) {
    Curso curso = Curso();
    this.curso = curso;
    idEstudante = map['idEstudante'];
    nome = map['nome'];
    email = map['email'];
    previsaoTerminoCurso = map['previsaoTerminoCurso'];
    experienciaProfissional = map['experienciaProfissional'];
    curso.idCurso = map['curso']['idCurso'];
    curso.nome = map['curso']['nome'];
    curso.tipo = map['curso']['tipo'];
  }

  @override
  String toString() {
    return idEstudante! +
        nome! +
        email! +
        previsaoTerminoCurso! +
        experienciaProfissional! +
        curso.toString();
  }
}
