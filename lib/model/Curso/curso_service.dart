import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'curso.dart';

class CursoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;
  Curso? curso;

  CursoService() {
    firestoreRef = _firestore.collection('Cursos');
  }

  Future<bool> adicionarCurso(Curso curso) async {
    try {
      _firestore
          .collection("Cursos")
          .add(curso.toMap())
          .then((documentReference) {
        curso.idCurso = documentReference.id;
        _firestore
            .collection("Cursos")
            .doc(documentReference.id)
            .set(curso.toMap());
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

  Future<Curso> getCurso(String idCurso) async {
    Curso curso = Curso();
    await _firestore.collection("Cursos").doc(idCurso).get().then(
      (documentSnapshot) {
        curso.idCurso = documentSnapshot.get("idCurso") as String;
        curso.nome = documentSnapshot.get("nome") as String;
        curso.tipo = documentSnapshot.get("tipo") as String;
      },
    );
    return curso;
  }

  Future<List<Curso>> getCursoList() async {
    List<Curso> listaCursos = [];
    await _firestore.collection("Cursos").snapshots().first.then((value) {
      for (var doc in value.docs) {
        Curso curso = Curso.fromDocument(doc);
        listaCursos.add(curso);
      }
    });
    return listaCursos;
  }

  Future<bool> updateCurso(Curso curso, String idCurso) async {
    try {
      await _firestore.collection("Cursos").doc(idCurso).set(curso.toMap());
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

  Future<bool> deleteCurso(String idCurso) async {
    try {
      await _firestore.collection("Cursos").doc(idCurso).delete();
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
