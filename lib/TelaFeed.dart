import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpcomplete/models/postModel.dart';



class TelaFeed extends StatefulWidget {
  @override
  _TelaFeedState createState() => _TelaFeedState();
}

class _TelaFeedState extends State<TelaFeed> {
  var stringResult = "";
  
  Future<List<postModel>> GetPosts() async{
    List<postModel> posts = [];
    var url = Uri.parse("https://localhost:44336/v1/posts/PostsAll");
    var response = await http.get(url,
        headers:           { 'Content-type': 'application/json; charset=UTF-8'}
    );

    var jsonResponse = jsonDecode(response.body);
    print("statusFeed " +response.statusCode.toString());
    print(jsonResponse);
    if(response.statusCode == 200) {
      for (var post in jsonResponse) {
        var postAdd = postModel.fromJson(post);
        if (postAdd != null) {
          posts.add(postAdd);
        }
      }
      return posts;
    }else{
      setState(() {
        stringResult = "Houve um erro ao carregar os posts";
      });
    }


    
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed"),),
      body:
          Column(
            children: [
              Center(child: Text(stringResult),),
              Expanded(child:
              FutureBuilder<List<postModel>>(
                future:  GetPosts(),
                builder: (context, snapchot){
                  switch(snapchot.connectionState){
                    case ConnectionState.none:
                      setState(() {
                        stringResult = "Houve um erro ao carregar a lista";
                      });
                      break;
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator.adaptive());
                      break;
                    case ConnectionState.done:
                      return ListView.builder(
                          itemCount: snapchot.data.length,
                          itemBuilder:(context,index){
                            var postList = snapchot.data[index];

                            return ListTile(

                              leading: Text(postList.UserName + ":"),
                              title: Text("Titulo: " + postList.Titulo),
                              subtitle: Text(postList.Conteudo),
                            );
                          }

                      );
                  }
                },
              ),)

            ],
          )


    );
  }
}


