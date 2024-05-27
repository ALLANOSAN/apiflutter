import 'package:apiflutter/Autentica%C3%A7%C3%A3o/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SuperApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
        
      );
    }
}
