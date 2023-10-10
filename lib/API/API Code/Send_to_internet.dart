import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers :<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
  'title': title,
  }),
  );

  if (response.statusCode == 201){
    return Album.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to create album');
  }
}
class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String,dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class send_internet extends StatefulWidget {
  const send_internet({super.key});

  @override
  State<send_internet> createState() => _send_internetState();
}

class _send_internetState extends State<send_internet> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }
  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter Title'),
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: () {
          setState(() {
            _futureAlbum = createAlbum(_controller.text);
          });
        }, child: Text('Create Data')),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder(){
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Text(snapshot.data!.title,style: const TextStyle(fontSize: 20),);
        }else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}