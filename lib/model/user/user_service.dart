import 'package:aplicacao/model/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UsuarioServices {
  UserApp? user;

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
              email: userApp.email!, password: userApp.password!))
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
    await _firestore.collection("Usuarios").doc(id).set(
          user.toMap(),
        );
  }
}
