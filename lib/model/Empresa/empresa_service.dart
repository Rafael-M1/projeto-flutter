import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'empresa.dart';

class EmpresaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;
  Empresa? empresa;

  EmpresaService() {
    firestoreRef = _firestore.collection('Empresas');
  }

  Future<bool> adicionarEmpresa(Empresa empresa) async {
    try {
      await firestoreRef.add(empresa.toMap()).then((documentReference) {
        empresa.idEmpresa = documentReference.id;
        firestoreRef.doc(documentReference.id).set(empresa.toMap());
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

  Future<Empresa> getEmpresa(String idEmpresa) async {
    Empresa empresa = Empresa();
    await firestoreRef.doc(idEmpresa).get().then(
      (documentSnapshot) {
        empresa.idEmpresa = documentSnapshot.get("idEmpresa") as String;
        empresa.nome = documentSnapshot.get("nome") as String;
        empresa.endereco = documentSnapshot.get("endereco") as String;
      },
    );
    return empresa;
  }

  Future<List<Empresa>> getEmpresaList() async {
    List<Empresa> listaEmpresas = [];
    await firestoreRef.snapshots().first.then((value) {
      for (var doc in value.docs) {
        Empresa empresa = Empresa.fromDocument(doc);
        listaEmpresas.add(empresa);
      }
    });
    return listaEmpresas;
  }

  Future<bool> updateEmpresa(Empresa empresa, String idEmpresa) async {
    try {
      await firestoreRef.doc(idEmpresa).set(empresa.toMap());
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

  Future<bool> deleteEmpresa(String idEmpresa) async {
    try {
      await firestoreRef.doc(idEmpresa).delete();
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
