import 'package:aplicacao/pages/home/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        height: 400,
        width: 1200,
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
                    botaoCadastrarUsuario(context),
                  ],
                ),
              )
            ],
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
              initialValue: userApp.email,
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
              initialValue: userApp.password,
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
                  //UserApp usuarioAtalho =
                  //    UserApp(email: "rafael@gmail.com", password: "123456");
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

ElevatedButton botaoCadastrarUsuario(context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserApp userApp = UserApp();
  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cadastro de Usuário'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 5, width: 500),
                  TextFormField(
                    //Input Email
                    onSaved: (value) => userApp.email = value,
                    initialValue: userApp.email,
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
                    onSaved: (value) => userApp.password = value,
                    initialValue: userApp.password,
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
                  usuarioServices.signUp(
                    userApp,
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
