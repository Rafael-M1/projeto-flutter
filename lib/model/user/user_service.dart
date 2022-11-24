import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/model/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UsuarioServices {
  UserApp? user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference firestoreRef;

  UsuarioServices() {
    firestoreRef = _firestore.collection('Usuarios');
  }

  //Método para realizar a autenticação no firebase com email e senha
  Future<void> signIn(
    UserApp userApp, {
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: userApp.email!, password: userApp.password!))
          .user;
      userApp.id = user!.uid;
      //Função Callback
      onSuccess!();
    } on PlatformException catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  Future<void> signUp(
    UserApp userApp, {
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: userApp.email!,
        password: userApp.password!,
      ))
          .user;
      userApp.id = user!.uid;
      userApp.role = "n";
      addUsuario(userApp, user.uid);
      onSuccess!();
    } catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint("Chamando serviço de deslogar usuário");
  }

  addUsuario(UserApp user, String id) async {
    await _firestore.collection("Usuarios").doc(id).set(user.toMap());
  }

  Future<UserApp> getUsuarioLogado(String idUsuario) async {
    UserApp usuarioLogado = UserApp();
    await _firestore.collection("Usuarios").doc(idUsuario).get().then(
      (documentSnapshot) {
        usuarioLogado.id = documentSnapshot.get("id") as String;
        usuarioLogado.email = documentSnapshot.get("email") as String;
        usuarioLogado.nome = documentSnapshot.get("nome") as String;
        usuarioLogado.role = documentSnapshot.get("role") as String;
        Estudante estudanteDoc =
            Estudante.fromMap(documentSnapshot.get("estudante"));
        usuarioLogado.estudante = estudanteDoc;
      },
    );
    return usuarioLogado;
  }

  Future<bool> updateUsuario(
      UserApp usuarioCadastro, String idOfertaEstagio) async {
    try {
      await _firestore
          .collection("Usuarios")
          .doc(idOfertaEstagio)
          .set(usuarioCadastro.toMap());
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
}
