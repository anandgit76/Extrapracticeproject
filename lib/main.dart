
import 'package:extra_practice_project/2Screens/SplashUI.dart';
import 'package:extra_practice_project/API/API%20Code/API_of_get1.dart';
import 'package:extra_practice_project/API/API%20Code/API_of_get2.dart';
import 'package:extra_practice_project/API/API%20Code/API_of_get3.dart';
import 'package:extra_practice_project/API/API%20Code/Send_to_internet.dart';
import 'package:extra_practice_project/API/API%20Code/Update_data.dart';
import 'package:extra_practice_project/API/API%20Code/delete_data.dart';
import 'package:extra_practice_project/API/API%20Code/fetch_data2.dart';
import 'package:extra_practice_project/Calculator/calculator_screen.dart';
import 'package:extra_practice_project/Snake_Game/snakesss.dart';
import 'package:extra_practice_project/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'API/API Code/Send_to_internet2.dart';
import 'API/API Code/fetch_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        title: const Text(
          'Flutter Home Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
