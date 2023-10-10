import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<Users> createUsers(String name,String email, String phone) async{
  final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/users'),
    headers :<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
    'name': name,
    'email': email,
      'phone': phone,
    }),
  );
  if(response.statusCode == 201){
    return Users.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to create Users');
  }
}
class Users {
  final int id;
  final String name;
  final String email;
  final String phone;

  const Users({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Users.fromJson(Map<String,dynamic> json){
    return Users(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone']
    );
  }
}

class send_data_internet extends StatefulWidget {
  const send_data_internet({super.key});

  @override
  State<send_data_internet> createState() => _send_data_internetState();
}

class _send_data_internetState extends State<send_data_internet> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  Future<Users>? _futureUsers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              scale: 3,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Send Data To Internet^',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent, //<-- SEE HERE
      ),
      body: Container(
        alignment:  Alignment.topCenter,
        padding: const EdgeInsets.all(8.0),
        child: (_futureUsers == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }
  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: namecontroller,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: emailcontroller,
          decoration: const InputDecoration(hintText: 'Enter Email'),
        ),
        TextField(
          controller: phonecontroller,
          decoration: const InputDecoration(hintText: 'Enter Phone'),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: () {
          setState(() {
            _futureUsers = createUsers(namecontroller.text,emailcontroller.text,phonecontroller.text);
          });
        }, child: const Text('Create User')),
      ],
    );
  }
  FutureBuilder<Users> buildFutureBuilder(){
    return FutureBuilder<Users>(
      future:  _futureUsers,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            children: [
              Text(snapshot.data!.name,style: const TextStyle(fontSize: 20),),
              Text(snapshot.data!.email,style: const TextStyle(fontSize: 20),),
              Text(snapshot.data!.phone,style: const TextStyle(fontSize: 20),),
            ],
          );
        }else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }
        return const LinearProgressIndicator();
      },
    );
  }
}
