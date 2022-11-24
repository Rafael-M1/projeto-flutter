import 'package:aplicacao/model/Curso/curso.dart';
import 'package:aplicacao/model/Curso/curso_service.dart';
import 'package:aplicacao/model/Estudante/estudante.dart';
import 'package:aplicacao/pages/usuarioLogado/home_after_login_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/user/user.dart';
import '../../../model/user/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  UserApp userApp = UserApp();

  CursoService cursoService = CursoService();
  List<Widget> listaWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        height: 800,
        width: 1200,
        child: Center(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: formularioLoginUsuario(context, _formKey, userApp),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ainda não possui cadastro?",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      FutureBuilder(
                        future: cursoService.getCursoList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Curso> listaCursos =
                                snapshot.data as List<Curso>;
                            List<DropdownMenuItem<Curso>> cursoItems = [];
                            for (int i = 0; i < listaCursos.length; i++) {
                              cursoItems.add(
                                DropdownMenuItem(
                                  value: listaCursos.elementAt(i),
                                  child: Text(
                                    listaCursos.elementAt(i).nome.toString(),
                                  ),
                                ),
                              );
                            }
                            return Center(
                              child: botaoCadastrarUsuario(
                                  context, cursoItems, listaCursos),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Column formularioLoginUsuario(context, _formKey, userApp) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Login",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      const SizedBox(height: 20),
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'E-mail',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              //Input Email
              onSaved: (value) => userApp.email = value,
              //initialValue: userApp.email,
              initialValue: "rafael@gmail.com",
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 18.0),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains("@")) {
                  return 'Por favor, entre com um e-mail.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "E-mail",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.blueGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Senha',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              //Input Senha
              onSaved: (value) => userApp.password = value,
              //initialValue: userApp.password,
              initialValue: "123456",
              obscureText: true,
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 18.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, entre com uma senha.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Senha",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.blueGrey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // UserApp usuarioAtalho =
                  //     UserApp(email: "rafael@gmail.com", password: "123456");
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    UsuarioServices usuarioServices = UsuarioServices();
                    usuarioServices.signIn(
                      userApp,
                      //usuarioAtalho,
                      onSuccess: () {
                        debugPrint("Serviço logar sucesso");
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeAfterLoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      onFail: (e) {
                        Text('$e');
                      },
                    );
                    debugPrint("${userApp.email} - ${userApp.password}");
                  }
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(200, 40),
                  ),
                ),
                child: const Text("Entrar"),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

ElevatedButton botaoCadastrarUsuario(context,
    List<DropdownMenuItem<Curso>> cursoItems, List<Curso> listaCursos) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // print(cursoItems.toString());
  return ElevatedButton(
    onPressed: () {
      UserApp userAppCadastro = UserApp();
      Estudante estudanteCadastro = Estudante();
      Curso cursoCadastro = Curso();
      userAppCadastro.estudante = estudanteCadastro;
      userAppCadastro.estudante!.curso = cursoCadastro;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cadastro de Estudante'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 5, width: 500),
                  TextFormField(
                    //Input Nome do Estudante
                    onSaved: (value) => userAppCadastro.nome = value,
                    initialValue: userAppCadastro.nome,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, entre com um nome.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nome do Estudante",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    //Input Experiencia Profissional do Estudante
                    onSaved: (value) => userAppCadastro
                        .estudante!.experienciaProfissional = value,
                    initialValue: userAppCadastro.nome,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha sua experiência profissional.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Experiência profissional",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Dropdown Cursos
                  DropdownButtonFormField<Curso>(
                    items: cursoItems,
                    // items: listaCursos.,
                    onSaved: (curso) {
                      userAppCadastro.estudante!.curso = curso;
                    },
                    onChanged: (curso) {
                      userAppCadastro.estudante!.curso = curso;
                    },
                    validator: (value) =>
                        value == null ? 'Selecione um Curso' : null,
                    hint: const Text("Escolha um Curso"),
                    // value: userAppCadastro.estudante?.curso,cursoItems
                    value: cursoItems[0].value,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    //Input Previsão Termino de Curso do Estudante
                    onSaved: (value) =>
                        userAppCadastro.estudante!.previsaoTerminoCurso = value,
                    initialValue: userAppCadastro.nome,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, preencha a previsão de término de curso.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Previsão de Término de Curso",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    //Input Email
                    onSaved: (value) => userAppCadastro.email = value,
                    initialValue: userAppCadastro.email,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains("@")) {
                        return 'Por favor, entre com um e-mail.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    //Input Senha
                    onSaved: (value) => userAppCadastro.password = value,
                    initialValue: userAppCadastro.password,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, entre com uma senha.';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Senha",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
            ElevatedButton(
              onPressed: () {
                //Chama serviço de salvar usuário
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  UsuarioServices usuarioServices = UsuarioServices();
                  // print(userAppCadastro.toMap());
                  usuarioServices.signUp(
                    userAppCadastro,
                    onSuccess: () {
                      Navigator.of(context).pop();
                    },
                    onFail: (e) {
                      ScaffoldMessenger(
                        child: SnackBar(
                          content: Text(
                            'Falha ao registrar Usuário: $e',
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      );
    },
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size(200, 40)),
    ),
    child: const Text("Cadastrar-se"),
  );
}
