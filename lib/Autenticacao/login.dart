import 'package:apiflutter/Autenticacao/cadastro.dart';
import 'package:apiflutter/JsonModels/user.dart';
import 'package:flutter/material.dart';
import 'package:apiflutter/SQLite/sqlite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
// precisamos de dois controladores de edição de texto

  // Controlador TextEditing para controlar o texto quando entramos nele
  final usuario = TextEditingController();
  final senha = TextEditingController();

  // uma variável bool para mostrar e ocultar senha
  bool seVisivel = false;
  bool seLoginVerdadeiro = false;

  final db = DatabaseHelper();

  login() async {
    var response =
        await db.login(Usuarios(usrNome: usuario.text, usrSenha: senha.text));
    if (response == true) {
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Notes()));
    } else {
      setState(() {
        seLoginVerdadeiro = true;
      });
    }
  }

  //we have to creat global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //colocamos todo o nosso textfild em um formulário para ser controlado e não permitido como vazio
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Login

                  //Antes de mostrarmos a imagem, depois de copiarmos a imagem, precisamos definir a localização em pubspec.yaml
                  Image.asset(
                    "images/login.png",
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
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

                  // Senha
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
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
                                // aqui vamos criar um clique para mostrar e ocultar a senha um botão de alternância
                                setState(() {
                                  // botão de alternância
                                  seVisivel = !seVisivel;
                                });
                              },
                              icon: Icon(seVisivel
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Botão de login
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple,
                    ),
                    child: TextButton(
                        onPressed: () {
                          //verificar se o formulário é válido
                          if (formKey.currentState!.validate()) {
                            //se for válido, navegue para a próxima tela
                            login();
                          }
                        },
                        child: const Text("LOGIN",
                            style: TextStyle(color: Colors.white))),
                  ),

                  //botão de cadastrar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Não tem uma conta?"),
                      TextButton(
                          onPressed: () {
                            //navegar para a tela de cadastro
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => const Cadastro()));
                          },
                          child: const Text("Cadastre-se"))
                    ],
                  ),
                  seLoginVerdadeiro
                      ? Text(
                          "Usuário: ${usuario.text} ou Senha: ${senha.text} incorretos",
                          style: const TextStyle(color: Colors.red))
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
