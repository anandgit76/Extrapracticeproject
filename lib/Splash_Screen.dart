import 'dart:async';

import 'package:extra_practice_project/2Screens/UploadUI.dart';
import 'package:extra_practice_project/API/API%20Code/API_of_get1.dart';
import 'package:extra_practice_project/Viktor_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UploadUI()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade400,
        child: const Center(
          child: Text("Flutter App",style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}
