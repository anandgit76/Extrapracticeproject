import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<UserUpdt> fetchUserUpdt() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/5'),
  );
  if (response.statusCode == 200){
    return UserUpdt.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load Data');
  }
}

Future<UserUpdt> updateUserUpdt(String name,String email, String phone) async {
  final response = await http.put(Uri.parse('https://jsonplaceholder.typicode.com/users'),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body:  jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'phone': phone,
      }),
  );
  if(response.statusCode == 200){
    return UserUpdt.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to Update Data');
  }
}
class UserUpdt {
  final int id;
  final String name;
  final String email;
  final String phone;

  const UserUpdt({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserUpdt.fromJson(Map<String,dynamic> json){
    return UserUpdt(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone']
    );
  }
}

class UpdateData extends StatefulWidget {
  const UpdateData({super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  late Future<UserUpdt> _futureUserUpdt;

  // Clear the text fields' controllers
  void clearTextFields() {
    namecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
  }

  @override
  void initState() {
    super.initState();
    _futureUserUpdt = fetchUserUpdt();
  }
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
              width: 8,
            ),
            const Text(
              'Update Data',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent, //<-- SEE HERE
      ),
      body: Container(
        alignment:  Alignment.topCenter,
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<UserUpdt>(
          future: _futureUserUpdt,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.name,style: const TextStyle(fontSize: 20),),
                    TextField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                        hintText: 'Update Name',
                      ),
                    ),
                    Text(snapshot.data!.email,style: const TextStyle(fontSize: 20),),
                    TextField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                        hintText: 'Update Email',
                      ),
                    ),
                    Text(snapshot.data!.phone,style: const TextStyle(fontSize: 20),),
                    TextField(
                      controller: phonecontroller,
                      decoration: const InputDecoration(
                        hintText: 'Update Phone',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureUserUpdt = updateUserUpdt(namecontroller.text,emailcontroller.text,phonecontroller.text);
                        });
                        clearTextFields();
                      },
                      child: const Text('Update Data'),
                    ),
                  ],
                );
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
