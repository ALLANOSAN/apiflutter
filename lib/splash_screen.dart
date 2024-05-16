import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('caminho/para/sua/imagem.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}