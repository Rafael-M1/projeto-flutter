import 'package:aplicacao/model/Curso/curso.dart';

class Estudante {
  // String? idEstudante;
  // String? nome;
  // String? email;
  String? isEstagiando;
  Curso? curso;
  String? previsaoTerminoCurso;
  String? experienciaProfissional;

  //Método construtor
  Estudante({
    // this.idEstudante,
    // this.nome,
    // this.email,
    this.isEstagiando,
    this.curso,
    this.previsaoTerminoCurso,
    this.experienciaProfissional,
  });

  //Método para conversão para MAP, para permitir que possamos
  //enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      // 'idEstudante': idEstudante,
      // 'nome': nome,
      // 'email': email,
      'isEstagiando': isEstagiando,
      'curso': {
        'idCurso': curso?.idCurso,
        'nome': curso?.nome,
        'tipo': curso?.tipo,
      },
      'previsaoTerminoCurso': previsaoTerminoCurso,
      'experienciaProfissional': experienciaProfissional,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "isEstagiando": isEstagiando,
      "previsaoTerminoCurso": previsaoTerminoCurso,
      "experienciaProfissional": experienciaProfissional,
      "curso": curso!.toJson(),
    };
  }

  Estudante.fromMap(Map<String, dynamic> map) {
    // idEstudante = map['idEstudante'];
    // nome = map['nome'];
    // email = map['email'];
    isEstagiando = map['isEstagiando'];
    previsaoTerminoCurso = map['previsaoTerminoCurso'];
    experienciaProfissional = map['experienciaProfissional'];

    Curso curso = Curso();
    this.curso = curso;
    curso.idCurso = map['curso']['idCurso'];
    curso.nome = map['curso']['nome'];
    curso.tipo = map['curso']['tipo'];
  }

  factory Estudante.fromJson(dynamic json) {
    return Estudante(
      isEstagiando: json['isEstagiando'],
      previsaoTerminoCurso: json['previsaoTerminoCurso'],
      experienciaProfissional: json['experienciaProfissional'],
      curso: Curso.fromJson(json['curso']),
    );
  }

  @override
  String toString() {
    return "Estudante(" +
        // idEstudante! +
        // " - " +
        // nome! +
        // " - " +
        // email! +
        // " - " +
        isEstagiando! +
        previsaoTerminoCurso! +
        " - " +
        experienciaProfissional! +
        " - " +
        curso.toString() +
        ") ";
  }
}
