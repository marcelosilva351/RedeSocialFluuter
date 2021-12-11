import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpcomplete/models/userModel.dart';


class TelaCriarPost extends StatefulWidget {
  String EmailUser;


  TelaCriarPost(this.EmailUser);

  @override
  _TelaCriarPostState createState() => _TelaCriarPostState();
}

class _TelaCriarPostState extends State<TelaCriarPost> {

  var tituloPostController = TextEditingController();
  var conteudoPostController = TextEditingController();
  var stringResult = "";

   userId() async{
    var userId = 0;
    var urlUser = Uri.parse("https://localhost:44336/v1/users/" + widget.EmailUser);
    var responseUser = await http.get(urlUser,
        headers:           { 'Content-type': 'application/json; charset=UTF-8'}
    );
    var jsonResponseUser = jsonDecode(responseUser.body);
    print("STATUSCRIARPOSTUSER" + responseUser.statusCode.toString());
    if(responseUser.statusCode == 200){
      userId = jsonResponseUser['id'];
    }
    print(userId.toString());

    return userId;

  }
 Future<bool> CriarPost() async{

     var UserId = await userId();

    var urlPost = Uri.parse("https://localhost:44336/v1/posts");
    var responsePost = await http.post(urlPost,
        headers:           { 'Content-type': 'application/json; charset=UTF-8'},
      body: json.encode({
        "titulo" : tituloPostController.text,
        "conteudo" : conteudoPostController.text,
        "userId" : UserId
      }));

    print("STATUSCODEPOSTCRIAR" + responsePost.statusCode.toString());
    if(responsePost.statusCode == 201){
      return true;
    }else{
      return false;
    }


  }



  @override
  Widget build(BuildContext context) {
          return
          Scaffold(
          body:
            Column(
            children: [
              Text("Criar tarefa"),
              Padding(padding: EdgeInsets.only(top: 20,bottom: 10),
              child: Column(children: [
                TextField(
                  controller: tituloPostController,
                  decoration: InputDecoration(label: Text("Titulo")),
                ),
                TextField(
                  controller: conteudoPostController,
                  decoration: InputDecoration(label: Text("Conteudo")),
                )
              ],
              ),
              ),
              ElevatedButton(onPressed: (){
                var criarPostReturn =  CriarPost().then((value) {

                  if(value == true){
                    setState(() {
                    });
                    Navigator.pop(context);

                  }
                  else{
                    setState(() {
                      stringResult = "Ocorreu um erro ao tentar criar post";
                    });
                  }
                }
                );

                }

              , child: Text("Postar")),
              Text(stringResult)
            ],
          )
          );


  }
}
