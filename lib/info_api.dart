import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apiinfo extends StatefulWidget {
  const apiinfo({Key? key}) : super(key: key);

  @override
  _apiinfoState createState() => _apiinfoState();
}

class _apiinfoState extends State<apiinfo> {

  Future<List<dynamic>> getUserInfo() async{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    return jsonDecode(response.body);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info",style: TextStyle(fontSize: 25),),
      ),
      body: Center(
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (BuildContext context,AsyncSnapshot asyncSnapshot){
            if(asyncSnapshot.hasData){
              return ListView.builder(
                  itemCount: asyncSnapshot.data.length,
                  itemBuilder: (context,int position){
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green,
                          child: Text(asyncSnapshot.data[position]["id"].toString()),
                        ),
                        title: Text(asyncSnapshot.data[position]["title"].toString(),style: TextStyle(color:Colors.green,fontSize: 20 ),),
                        subtitle: Text(asyncSnapshot.data[position]["url"].toString()),

                      ),
                    );
                  }
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          },
        ),
      ),
    );
  }
}
