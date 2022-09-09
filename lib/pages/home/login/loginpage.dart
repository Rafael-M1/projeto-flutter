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
          border: Border.all(
            color: Color.fromARGB(255, 248, 248, 248),
          ),
        ),
        //color: Color.fromARGB(255, 173, 173, 173),
        width: 1200,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
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
                            onSaved: (value) => userApp.email = value,
                            initialValue: userApp.email,
                            keyboardType: TextInputType.text,
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
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  UsuarioServices usuarioServices =
                                      UsuarioServices();
                                  usuarioServices.signIn(
                                    userApp,
                                    onSuccess: () {
                                      debugPrint("Serviço logar sucesso");
                                    },
                                    onFail: (e) {
                                      Text('$e');
                                    },
                                  );
                                  debugPrint(
                                      "${userApp.email} - ${userApp.password}");
                                }
                              },
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size(200, 40)),
                              ),
                              child: const Text("Login"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(200, 40)),
                    ),
                    child: const Text("Cadastrar-se"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
