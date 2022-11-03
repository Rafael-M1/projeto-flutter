import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'estudante.dart';

class EstudanteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;
  //Estudante? estudante;

  EstudanteService() {
    firestoreRef = _firestore.collection('Estudantes');
  }

  Future<bool> adicionarEstudante(Estudante estudante) async {
    try {
      //print(estudante.toString());
      CursoService cursoService = CursoService();
      cursoService
          .getCurso(estudante.curso!.idCurso.toString())
          .then((cursoItem) => estudante.curso = cursoItem);

      await firestoreRef.add(estudante.toMap()).then((documentReference) {
        estudante.idEstudante = documentReference.id;
        _firestore
            .collection("Estudantes")
            .doc(documentReference.id)
            .set(estudante.toMap());
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

  Future<Estudante> getEstudante(String idEstudante) async {
    CursoService cursoService = CursoService();
    Estudante estudante = firestoreRef.doc(idEstudante) as Estudante;
    cursoService
        .getCurso(estudante.curso!.idCurso!)
        .then((curso) => estudante.curso = curso);
    return estudante;
  }

  Future<bool> updateEstudante(Estudante estudante, String idEstudante) async {
    try {
      await firestoreRef.doc(idEstudante).set(estudante.toMap());
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

  Future<bool> deleteEstudante(String idEstudante) async {
    try {
      await firestoreRef.doc(idEstudante).delete();
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
