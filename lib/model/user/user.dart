class UserApp {
  String? id;
  String? email;
  String? password;
  String? nome;
  String? role;

  UserApp({
    this.id,
    this.email,
    this.password,
    this.nome,
    this.role,
  });

  //Método para converter formato json em objetos
  factory UserApp.fromMap(Map<String, dynamic> map) {
    return UserApp(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
    );
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
