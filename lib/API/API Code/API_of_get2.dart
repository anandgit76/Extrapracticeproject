import 'dart:convert';

import 'package:extra_practice_project/API/models/secondmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Secondprogram extends StatefulWidget {
  const Secondprogram({super.key});

  @override
  State<Secondprogram> createState() => _SecondprogramState();
}

class _SecondprogramState extends State<Secondprogram> {
  List<UserTest> userList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text("User Details"),
            ),
            leading: IconButton(
              onPressed: () {

              }, icon: Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(onPressed: () {

              }, icon: Icon(Icons.search_sharp))
            ],
          ),
          body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    height: 300,
                    padding:  const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                          index,"UserId : ", userList[index].userId.toString()),
                        getText(
                          index,"ID : ", userList[index].id.toString()),
                        getText(
                          index,"Title : ", userList[index].title.toString()),
                        getText(
                          index,"Body : ", userList[index].body.toString()),
                      ],
                    ),
                  );
                },);
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
    );
  }
  Text getText(int index, String fieldName,String content){
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: fieldName,
          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
      TextSpan(
          text: content,
          style: const TextStyle(fontSize: 16)),
    ]));
  }
  Future<List<UserTest>> getData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map<String,dynamic> index in data){
        userList.add(UserTest.fromJson(index));
      }
      return userList;
    }else{
      return userList;
    }
  }
}
