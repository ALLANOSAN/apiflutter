import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/Autenticacao/cadastro.dart';
import 'package:getxtutorial6sqlitetodo/JsonModels/user.dart';
import 'package:getxtutorial6sqlitetodo/app/data/Database/database_helper.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/notes/note_list_page.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usuario = TextEditingController();
  final senha = TextEditingController();
  bool seVisivel = false;
  bool seLoginVerdadeiro = false;
  final db = DatabaseNotes.instance;
  final formKey = GlobalKey<FormState>();

  login() async {
    var response = await db.login(Usuarios(usrNome: usuario.text, usrSenha: senha.text));
    if (response == true) {
      if (!mounted) return;
      Get.to(() => const NoteListPage());
    } else {
      setState(() {
        seLoginVerdadeiro = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "images/login.png",
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    child: TextFormField(
                      controller: usuario,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, insira o nome de usuário";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: 'Usuário',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    child: TextFormField(
                      controller: senha,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, insira a senha";
                        }
                        return null;
                      },
                      obscureText: !seVisivel,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Senha',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              seVisivel = !seVisivel;
                            });
                          },
                          icon: Icon(seVisivel ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: const Text("LOGIN", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Não tem uma conta?"),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const Cadastro());
                        },
                        child: const Text("Cadastre-se"),
                      ),
                    ],
                  ),
                  seLoginVerdadeiro
                      ? Text(
                          "Usuário: ${usuario.text} ou Senha: ${senha.text} incorretos",
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
