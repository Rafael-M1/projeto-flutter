import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Estudante/estudante_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
      await firestoreRef.add(ofertaEstagio.toMap());
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

  Future<OfertaEstagio> getOfertaEstagio(String idOfertaEstagio) async {
    CursoService cursoService = CursoService();
    EstudanteService estudanteService = EstudanteService();
    OfertaEstagio ofertaEstagio =
        firestoreRef.doc(idOfertaEstagio) as OfertaEstagio;
    cursoService
        .getCurso(ofertaEstagio.idCurso!)
        .then((curso) => ofertaEstagio.curso = curso);
    estudanteService.getEstudante(ofertaEstagio.idEstudante!).then(
      (estudante) {
        ofertaEstagio.estudante = estudante;
        cursoService
            .getCurso(estudante.idCurso!)
            .then((curso) => estudante.curso = curso);
      },
    );
    return ofertaEstagio;
  }

  Future<bool> updateOfertaEstagio(
      OfertaEstagio ofertaEstagio, String idOfertaEstagio) async {
    try {
      await firestoreRef.doc(idOfertaEstagio).set(ofertaEstagio.toMap());
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
}
