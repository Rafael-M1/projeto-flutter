import 'package:aplicacao/pages/CrudFornecedores/fornecedores_screen.dart';
import 'package:aplicacao/pages/CrudProdutos/produtos_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAHXuhdfhI1G-HkR8_dra7S019zly3rU9c",
      authDomain: "projetobackend-9232a.firebaseapp.com",
      projectId: "projetobackend-9232a",
      storageBucket: "projetobackend-9232a.appspot.com",
      messagingSenderId: "870225988796",
      appId: "1:870225988796:web:75a32b816bd967740d94b9",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/produtos': ((context) => const ProdutosScreen()),
        '/fornecedores': ((context) => const FornecedoresScreen()),
      },
    );
  }
}
