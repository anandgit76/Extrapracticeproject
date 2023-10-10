import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/5'));
  if (response.statusCode == 200){
    return User.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load the User');
  }
}

class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    website: json["website"],
  );
}

class fetch_data2 extends StatefulWidget {
  const fetch_data2({super.key});

  @override
  State<fetch_data2> createState() => _fetch_data2State();
}

class _fetch_data2State extends State<fetch_data2> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                'FlutterBeads',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.deepPurpleAccent, //<-- SEE HERE
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Text(snapshot.data!.name,style: const TextStyle(fontSize: 20),),
                      Text(snapshot.data!.username,style: const TextStyle(fontSize: 20),),
                      Text(snapshot.data!.email,style: const TextStyle(fontSize: 20),),
                      Text(snapshot.data!.phone,style: const TextStyle(fontSize: 20),),
                      Text(snapshot.data!.website,style: const TextStyle(fontSize: 20),),
                    ],
                  ),
                );
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }else{
                return const LinearProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}