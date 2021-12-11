import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpcomplete/TelaCriarPost.dart';
import 'package:httpcomplete/models/postModel.dart';



class TelaUserPosts extends StatefulWidget {
  String UserEmail;

  TelaUserPosts(this.UserEmail);

  @override
  _TelaFeedState createState() => _TelaFeedState();
}

class _TelaFeedState extends State<TelaUserPosts> {
  var stringResult = "";

  Future<List<postModel>> GetPosts() async{
    List<postModel> posts = [];
    var userEmail = widget.UserEmail;
    var url = Uri.parse("https://localhost:44336/v1/posts/PostsUser/$userEmail");
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

  ExcluirPost(int id) async{
    var response =  await http.delete(Uri.parse("https://localhost:44336/v1/posts/" + id.toString()),
        headers:           { 'Content-type': 'application/json; charset=UTF-8'}
    );

    print(response.statusCode.toString());



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return TelaCriarPost(widget.UserEmail);
          }));
        },child: Icon(Icons.add),),
        appBar: AppBar(title: Text("Meus Posts"),),
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
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text(postList.Titulo),
                                    actions: [
                                      ElevatedButton(onPressed: (){
                                        ExcluirPost(postList.Id);
                                        setState(() {

                                        });
                                        Navigator.pop(context);
                                        if(snapchot.connectionState == ConnectionState.waiting){
                                          return Center(child:CircularProgressIndicator.adaptive());

                                        }

                                      }, child: Text("Excluir Post")),
                                      ElevatedButton(onPressed: null, child: Text("Editar Post")),

                                    ],
                                  );
                                }
                              );
                            },
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


