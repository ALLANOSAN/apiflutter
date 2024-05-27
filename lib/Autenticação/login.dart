import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Login

                Image.asset("images/login.png"),
                Container(
                  margin: EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.3)),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: 'Usuário',
                    ),
                  ),
                ),

                // Senha
                Container(
                  margin: EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.3)),
                  child: TextFormField(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
