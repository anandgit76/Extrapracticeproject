import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/First_model.dart';

class Firstprogram extends StatefulWidget {
  const Firstprogram({super.key});

  @override
  State<Firstprogram> createState() => _FirstapiState();
}

class _FirstapiState extends State<Firstprogram> {
  List<UserDetails> userList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title:const Center(
              child: Text("User Details"),
            ),
            leading: IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.arrow_circle_left_outlined),
            ),
            actions: [
              IconButton(onPressed: () {

              }, icon: Icon(Icons.search_sharp)),
            ],
          ),
          body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 210,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10,horizontal: 15
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getText(
                              index,"ID:",userList[index].id.toString()),
                          getText(
                              index,"Name:",userList[index].name.toString()),
                          getText(
                              index,"Email:",userList[index].email.toString()),
                          getText(
                              index,"Phone:",userList[index].phone.toString()),
                          getText(
                              index,"Website:",userList[index].website.toString()),
                          getText(
                              index,"Company:",userList[index].company.toString()),
                          getText(
                              index,"Address:",'${userList[index].address.suite.toString()} ${userList[index].address.street.toString() } ${userList[index].address.zipcode.toString()}'),
                        ],
                      ),
                    );
                  },
                );
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
  Text getText( int index, String fieldName, String content){
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: fieldName,
          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
      TextSpan(
          text: content,
          style: const TextStyle(fontSize: 16)),
    ]));
  }
  Future<List<UserDetails>> getData()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map<String,dynamic> index in data){
        userList.add(UserDetails.fromJson(index));
      }
      return userList;
    } else {
      return userList;

    }
  }
}
