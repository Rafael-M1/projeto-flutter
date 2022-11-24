import 'package:aplicacao/model/Estudante/estudante.dart';

class UserApp {
  String? id;
  String? email; //
  String? password; //
  String? nome; //
  String? role; //
  Estudante? estudante;

  //Método construtor
  UserApp({
    this.id,
    this.email,
    this.password,
    this.nome,
    this.role,
    this.estudante,
  });

  //Método para converter formato json em objetos
  UserApp.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    password = map['password'];
    role = map['role'];
    estudante = Estudante.fromMap(map['estudante']);
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'password': password,
      'role': role,
      'estudante': estudante!.toMap(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "email": email,
      "estudante": estudante!.toJson(),
    };
  }

  factory UserApp.fromJson(dynamic json) {
    return UserApp(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      estudante: Estudante.fromJson(json['estudante']),
    );
  }

  @override
  String toString() {
    return "($id - $nome - $role - $email - $password - $estudante)";
  }
}
