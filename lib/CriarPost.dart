
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class CriarPost extends StatefulWidget {
  @override
  _CriarPostState createState() => _CriarPostState();
}

class _CriarPostState extends State<CriarPost> {
  var Titulo = TextEditingController();
  var Conteudo = TextEditingController();
  var resultString = "";
  Postposts() async{


    if(Titulo.text != "" && Conteudo.text != "") {
      setState(() {
        resultString = "";
      });
      var uriParse = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      var bodyPost = json.encode({
        "userId" : 1,
        "id" : 120,
        "title" : Titulo.text,
        "body" : Conteudo.text
      });
      var response = await http.post(uriParse, headers: {
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: bodyPost);

      print("Status code : " + response.statusCode.toString());
      print("body : " + response.body);




    }





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Padding(padding: EdgeInsets.all(16), child:

            Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 10),
                child: Text('Criar postagem')),
                Container(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: Titulo,
                        decoration : InputDecoration(label: Text("Titulo"))
                      ),
                      TextField(
                          controller: Conteudo,
                          decoration : InputDecoration(label: Text("Conteudo"))
                      )
                    ],
                  )
                ),
                FlatButton(onPressed: (){
                  Postposts();
                  Navigator.pop(context);
                }, child: Text("Adicionar"))
              ],
            )

        )
    );
  }
}
