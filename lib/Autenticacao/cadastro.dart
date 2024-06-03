import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/JsonModels/user.dart';
import 'package:getxtutorial6sqlitetodo/app/data/Database/database_helper.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/authentication/login.dart';



class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  final usuario = TextEditingController();
  final senha = TextEditingController();
  final confirmarSenha = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool seVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ListTile(
                    title: Text(
                      "Registre nova conta",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
                          return "Por favor, insira uma senha";
                        }
                        return null;
                      },
                      obscureText: !seVisivel,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Senha',
                        errorMaxLines: 3,
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
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    child: TextFormField(
                      controller: confirmarSenha,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, o campo de Confirma senha não pode ser vazio";
                        } else if (senha.text != confirmarSenha.text) {
                          return "As senhas não coincidem";
                        }
                        return null;
                      },
                      obscureText: !seVisivel,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Confirmar Senha',
                        errorMaxLines: 3,
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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {                          
                          var newUser = Usuarios(usrNome: usuario.text, usrSenha: senha.text);
                          await DatabaseNotes.instance.saveUser(newUser);
                          Get.snackbar('Sucesso', 'Usuário cadastrado com sucesso',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                          Future.delayed(const Duration(seconds: 2), () {
                            Get.to(const LoginScreen());
                          });
                        }
                      },
                      child: const Text('Cadastrar'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Já tem uma conta?'),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Text('LOGIN'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

