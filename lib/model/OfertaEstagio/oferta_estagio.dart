import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Empresa/empresa.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfertaEstagio {
  String? idOfertaEstagio;
  Estudante? estudante;
  Empresa? empresa;
  Curso? curso;
  String? periodo;
  String? remuneracao;
  String? endereco;
  String? status; //Vaga preenchida ou não preenchida

  //Método construtor
  OfertaEstagio({
    this.idOfertaEstagio,
    this.estudante,
    this.empresa,
    this.curso,
    this.periodo,
    this.remuneracao,
    this.endereco,
    this.status,
  });

  OfertaEstagio.fromDocument(DocumentSnapshot doc) {
    idOfertaEstagio = doc.id;
    estudante?.idEstudante = doc.get('idEstudante');
    empresa?.idEmpresa = doc.get('idEmpresa');
    curso?.idCurso = doc.get('idCurso');
    periodo = doc.get('periodo');
    remuneracao = doc.get('remuneracao');
    endereco = doc.get('endereco');
    status = doc.get('status');
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'idOfertaEstagio': idOfertaEstagio,
      'idEstudante': estudante?.idEstudante,
      'idEmpresa': empresa?.idEmpresa,
      'idCurso': curso?.idCurso,
      'periodo': periodo,
      'remuneracao': remuneracao,
      'endereco': endereco,
      'status': status,
    };
  }
}
