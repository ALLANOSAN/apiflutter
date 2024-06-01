import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/db/notes_service.dart';
import 'package:getxtutorial6sqlitetodo/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => NotesService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX SQLite Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Use a splash screen
    );
  }
}
