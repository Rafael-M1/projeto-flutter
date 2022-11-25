import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Empresa/empresa.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/model/user/user.dart';
import 'dart:convert';

class OfertaEstagio {
  String? idOfertaEstagio; //
  UserApp? estudanteSelecionado; //
  List<UserApp>? listaEstudantesCandidatos;
  Empresa? empresa; //
  Curso? curso; //
  String? periodo;
  String? remuneracao;
  String? status; //Vaga preenchida ou não preenchida

  //Método construtor
  OfertaEstagio({
    this.idOfertaEstagio,
    this.estudanteSelecionado,
    this.listaEstudantesCandidatos,
    this.empresa,
    this.curso,
    this.periodo,
    this.remuneracao,
    this.status,
  });

  // OfertaEstagio.fromDocument(DocumentSnapshot doc) {
  //   var ofertaEstagio = doc.data();
  //   print(ofertaEstagio);
  //   idOfertaEstagio = doc.id;
  //   estudanteSelecionado?.id = doc.get('idEstudante');
  //   empresa?.idEmpresa = doc.get('idEmpresa');
  //   curso?.idCurso = doc.get('idCurso');
  //   periodo = doc.get('periodo');
  //   remuneracao = doc.get('remuneracao');
  //   status = doc.get('status');
  // }

  //Método para conversão para MAP, para permitir que possamos enviar
  //informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idOfertaEstagio': idOfertaEstagio,
      'periodo': periodo,
      'remuneracao': remuneracao,
      'status': status,
      'estudanteSelecionado': {
        'id': estudanteSelecionado?.id,
        'nome': estudanteSelecionado?.nome,
        'email': estudanteSelecionado?.email,
        'isEstagiando': estudanteSelecionado?.estudante?.isEstagiando,
        'previsaoTerminoCurso':
            estudanteSelecionado?.estudante?.previsaoTerminoCurso,
        'experienciaProfissional':
            estudanteSelecionado?.estudante?.experienciaProfissional,
        'curso': {
          'idCurso': estudanteSelecionado?.estudante?.curso?.idCurso,
          'nome': estudanteSelecionado?.estudante?.curso?.nome,
          'tipo': estudanteSelecionado?.estudante?.curso?.tipo,
        },
      },
      'empresa': {
        'idEmpresa': empresa?.idEmpresa,
        'nome': empresa?.nome,
        'endereco': empresa?.endereco,
      },
      'curso': {
        'idCurso': curso?.idCurso,
        'nome': curso?.nome,
        'tipo': curso?.tipo,
      },
      'listaEstudantesCandidatos': jsonEncode(listaEstudantesCandidatos),
    };
  }

  OfertaEstagio.fromMap(Map<String, dynamic> map) {
    //OfertaEstagio
    idOfertaEstagio = map['idOfertaEstagio'];
    periodo = map['periodo'];
    remuneracao = map['remuneracao'];
    status = map['status'];

    //EstudanteSelecionado
    UserApp estudanteSelecionado = UserApp();
    this.estudanteSelecionado = estudanteSelecionado;

    Estudante estudante1 = Estudante();
    this.estudanteSelecionado?.estudante = estudante1;

    Curso curso2 = Curso();
    this.estudanteSelecionado?.estudante?.curso = curso2;

    estudanteSelecionado.id = map['estudanteSelecionado']['id'];
    estudanteSelecionado.nome = map['estudanteSelecionado']['nome'];
    estudanteSelecionado.email = map['estudanteSelecionado']['email'];
    estudanteSelecionado.estudante?.previsaoTerminoCurso =
        map['estudanteSelecionado']['previsaoTerminoCurso'];
    estudanteSelecionado.estudante?.experienciaProfissional =
        map['estudanteSelecionado']['experienciaProfissional'];
    estudanteSelecionado.estudante?.curso!.idCurso =
        map['estudanteSelecionado']['curso']['idCurso'];
    estudanteSelecionado.estudante?.curso!.nome =
        map['estudanteSelecionado']['curso']['nome'];
    estudanteSelecionado.estudante?.curso!.tipo =
        map['estudanteSelecionado']['curso']['tipo'];

    //Empresa
    Empresa empresa = Empresa();
    this.empresa = empresa;

    empresa.idEmpresa = map['empresa']['idEmpresa'];
    empresa.nome = map['empresa']['nome'];
    empresa.endereco = map['empresa']['endereco'];

    //Curso
    Curso curso1 = Curso();
    curso = curso1;

    curso!.idCurso = map['curso']['idCurso'];
    curso!.nome = map['curso']['nome'];
    curso!.tipo = map['curso']['tipo'];

    if (jsonDecode(map['listaEstudantesCandidatos'].toString()).runtimeType !=
        Null) {
      var aux = jsonDecode(map['listaEstudantesCandidatos'].toString()) as List;
      List<UserApp> listaEstudantes =
          aux.map((listaItem) => UserApp.fromJson(listaItem)).toList();
      // print(listaEstudantes);
      listaEstudantesCandidatos = listaEstudantes;
    }
  }

  // @override
  // String toString() {
  //   return "OfertaEstagio(" +
  //       idOfertaEstagio! +
  //       " - " +
  //       periodo! +
  //       " - " +
  //       remuneracao! +
  //       " - " +
  //       status! +
  //       " - " +
  //       empresa.toString() +
  //       " - " +
  //       curso.toString() +
  //       ")";
  // }
}
