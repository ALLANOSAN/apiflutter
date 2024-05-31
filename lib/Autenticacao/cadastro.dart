import 'package:apiflutter/Autenticacao/login.dart';
import 'package:apiflutter/JsonModels/user.dart';
import 'package:apiflutter/SQLite/sqlite.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Cadastro> {

  final usuario = TextEditingController();
  final senha = TextEditingController();
  final confirmarSenha = TextEditingController();
  
final formKey = GlobalKey<FormState>();

bool seVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SingleChildScrollView para ter uma rolagem na tela
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [          
                  //copiaremos o campo de texto anterior que projetamos para evitar consumo de tempo
              
              
              
                  const ListTile(
                    title: Text(
                      "Registre nova conta", 
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                  ),

                  //Como atribuímos nosso controlador ao textformfield

                  Container(
                            margin: const EdgeInsets.all(8),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              controller: usuario,
                              validator: (value){
                                if(value == null || value.isEmpty){
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
                      
                  //Senha
                  Container(
                            margin: const EdgeInsets.all(8),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              controller: senha,  
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Por favor, insira uma senha";
                                }
                                return null;
                              },    
                              obscureText: !seVisivel,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  border: InputBorder.none,
                                  hintText: 'Senha',
                                  errorMaxLines: 3, // Adicionado aqui para permitir mensagens de erro em várias linhas
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
                  //confirma Senha
                  //Now we check whether password matches or not
                  Container(
                            margin: const EdgeInsets.all(8),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple.withOpacity(.2)),
                            child: TextFormField(
                              controller: confirmarSenha,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Por favor, o campo de Confirma senha não pode ser vazio";
                                }else if(senha.text != confirmarSenha.text){
                                  return "As senhas não coincidem";
                                }
                                return null;
                              },  
                              obscureText: !seVisivel,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  border: InputBorder.none,
                                  hintText: 'Senha',
                                  errorMaxLines: 3, // Adicionado aqui para permitir mensagens de erro em várias linhas
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
                
               const SizedBox(height: 10,),
                // Botão de login
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width* .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple,
                    ),
                    child: TextButton(
                      onPressed: (){
                        //verificar se o formulário é válido
                        if(formKey.currentState!.validate()){
                          //se for válido, navegue para a próxima tela

                          final db = DatabaseHelper();
                          db.cadastro(Usuarios(
                            usrNome: usuario.text,
                             usrSenha: senha.text))
                             .whenComplete(() =>
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()
                             )));
                        }
                      },
                     child: const Text("Cadastrar" , style: TextStyle(color: Colors.white)
                     )),
                  ),
              
                  //botão de cadastrar
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    const Text("Já tem uma conta?"),
                    TextButton(onPressed: (){
                      //navegar para a tela de Login se você já tiver uma conta
                      Navigator.push(context, MaterialPageRoute(builder: (contex)=>const LoginScreen()));                      
                    }, 
                    child: const Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}