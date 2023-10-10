import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<DltUser> fetchDltUser() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/5'),
  );
  if(response.statusCode == 200){
    return DltUser.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load DltUser');
  }
}

Future<DltUser> deleteDltUser(String id) async{
  final http.Response response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/albums/5'),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',},
  );
  if(response.statusCode == 200){
    return DltUser.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to Delete Data');
  }
}

class DltUser {
  final int? id;
  final String? title;

  const DltUser({
    required this.id,
    required this.title,
});
  factory DltUser.fromJson(Map<String,dynamic>json){
    return DltUser(id: json['id'],
        title: json['title']);
  }
}

class DeleteData extends StatefulWidget {
  const DeleteData({super.key});

  @override
  State<DeleteData> createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  late Future<DltUser> _futureDltUer;

  @override
  void initState(){
    super.initState();
    _futureDltUer = fetchDltUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', scale: 3,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('Delete Data', style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent, //<-- SEE HERE
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<DltUser>(
          future: _futureDltUer,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data?.title??'Data Deleted Successfully'),
                    ElevatedButton(
                      onPressed: (() {
                      setState(() {
                        _futureDltUer = deleteDltUser(snapshot.data!.id.toString());
                      });
                    }),
                      child: const Text('Delete Data'),
                    )
                  ],
                );
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
            }
            return const LinearProgressIndicator();
          },
        )
      ),
    );
  }
}
