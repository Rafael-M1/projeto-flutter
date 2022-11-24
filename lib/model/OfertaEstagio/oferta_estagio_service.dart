import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Empresa/empresa_service.dart';
import 'package:aplicacao/model/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'oferta_estagio.dart';

class OfertaEstagioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;
  OfertaEstagio? ofertaEstagio;

  OfertaEstagioService() {
    firestoreRef = _firestore.collection('OfertaEstagios');
  }

  Future<bool> adicionarOfertaEstagio(OfertaEstagio ofertaEstagio) async {
    try {
      CursoService cursoService = CursoService();
      cursoService.getCurso(ofertaEstagio.curso!.idCurso.toString()).then(
        (cursoItem) {
          ofertaEstagio.curso!.idCurso = cursoItem.idCurso;
          ofertaEstagio.curso!.nome = cursoItem.nome;
          ofertaEstagio.curso!.tipo = cursoItem.tipo;
        },
      );

      EmpresaService empresaService = EmpresaService();
      empresaService
          .getEmpresa(ofertaEstagio.empresa!.idEmpresa.toString())
          .then(
        (empresaItem) {
          ofertaEstagio.empresa!.idEmpresa = empresaItem.idEmpresa;
          ofertaEstagio.empresa!.nome = empresaItem.nome;
          ofertaEstagio.empresa!.endereco = empresaItem.endereco;
        },
      );

      await firestoreRef.add(ofertaEstagio.toMap()).then((documentReference) {
        ofertaEstagio.idOfertaEstagio = documentReference.id;
        firestoreRef.doc(documentReference.id).set(ofertaEstagio.toMap());
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }

  // Future<OfertaEstagio> getOfertaEstagio(String idOfertaEstagio) async {
  //   CursoService cursoService = CursoService();
  //   UsuarioServices usuarioService = UsuarioServices();
  //   EstudanteService estudanteService = EstudanteService();
  //   EmpresaService empresaService = EmpresaService();

  //   OfertaEstagio ofertaEstagio =
  //       firestoreRef.doc(idOfertaEstagio) as OfertaEstagio;
  //   cursoService
  //       .getCurso(ofertaEstagio.curso!.idCurso!)
  //       .then((curso) => ofertaEstagio.curso = curso);
  //   empresaService
  //       .getEmpresa(ofertaEstagio.empresa!.idEmpresa!)
  //       .then((empresa) => ofertaEstagio.empresa = empresa);
  //   estudanteService.getEstudante(ofertaEstagio.estudanteSelecionado!.id!).then(
  //     (estudante) {
  //       ofertaEstagio.estudanteSelecionado = estudante;
  //       cursoService
  //           .getCurso(estudante.curso!.idCurso!)
  //           .then((curso) => estudante.curso = curso);
  //     },
  //   );
  //   return ofertaEstagio;
  // }

  Future<List<OfertaEstagio>> getOfertaEstagioNaoPreenchidaList() async {
    List<OfertaEstagio> listaOfertasEstagio = [];

    await firestoreRef
        .where("status", isEqualTo: "Não-preenchido")
        .snapshots()
        .first
        .then((value) {
      for (var doc in value.docs) {
        // OfertaEstagio ofertaEstagioItem = OfertaEstagio.fromDocument(doc);
        // listaOfertasEstagio.add(ofertaEstagioItem);
        // print(doc);
      }
    });
    return listaOfertasEstagio;
  }

  Future<bool> updateOfertaEstagio(
      OfertaEstagio ofertaEstagio, String idOfertaEstagio) async {
    try {
      var aux = ofertaEstagio.toMap();
      await firestoreRef.doc(idOfertaEstagio).set(aux);
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao atualizar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Alteração abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> deleteOfertaEstagio(String idOfertaEstagio) async {
    try {
      await firestoreRef.doc(idOfertaEstagio).delete();
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao deletar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Deleção abortada');
      }
      return Future.value(false);
    }
  }

  void adicionarEstudanteParaListaEstudantesCandidatos(
      UserApp estudante, OfertaEstagio ofertaEstagio) async {
    try {
      List<UserApp> listaEstudantes = [];
      if (ofertaEstagio.listaEstudantesCandidatos != null) {
        listaEstudantes =
            ofertaEstagio.listaEstudantesCandidatos as List<UserApp>;
      }
      listaEstudantes.add(estudante);
      // print(ofertaEstagio.toString());
      // print(jsonDecode(ofertaEstagio.listaEstudantesCandidatos.toString()));
      ofertaEstagio.listaEstudantesCandidatos = listaEstudantes;
      // print(ofertaEstagio.toMap());
      // print(UserApp.fromMap(ofertaEstagio.toMap()));
      updateOfertaEstagio(
          ofertaEstagio, ofertaEstagio.idOfertaEstagio.toString());
      // return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao deletar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Deleção abortada');
      }
      // return Future.value(false);
    }
  }
}
