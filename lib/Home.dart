import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpcomplete/TelaLogar.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var stringResult = "";
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var confirmarSenhaController = TextEditingController();


  postUser() async{
    if(usernameController.text == "" || emailController.text == "" || senhaController.text == "" || confirmarSenhaController.text == ""){
      setState(() {
      stringResult = "Você não preencheu todos os campos";
      });
    }else{
      setState(() {
        stringResult = "";
      });

      var bodyPost = json.encode({
        "usarname" : usernameController.text,
        "email" : emailController.text,
        "senha" : senhaController.text,
        "reSenha" : confirmarSenhaController.text
      });
      print(bodyPost);
      var url = Uri.parse("https://localhost:44336/v1/users/Cadastrar");
      var response = await http.post(url,
      headers: { 'Content-type': 'application/json; charset=UTF-8',
      },
      body: bodyPost);

      if(response.statusCode == 201){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TelaLogin();
        }));
      }else{
        setState(() {
          stringResult = "Ocorreu um erro ao tentar cadastrar";
        });
      }
      
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rede social"),),
      body:
      Padding(padding: EdgeInsets.all(16),
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Padding(padding: EdgeInsets.only(top: 10, bottom: 45),
          child: Text("Rede Social", style: TextStyle(fontSize: 24,color: Colors.blue, fontWeight: FontWeight.w400),),),
          Text("Cadastrar", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300),),
          Container(
            width: 150,
            height: 218,
            decoration: BoxDecoration(border: Border.all(color: Colors.blue,width: 2),borderRadius: BorderRadius.circular(4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(label: Text("Username", style: TextStyle(fontSize: 14),)),

              ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(label: Text("Email", style: TextStyle(fontSize: 14),)),

                ),
                TextField(
                  controller: senhaController,
                  decoration: InputDecoration(label: Text("Senha", style: TextStyle(fontSize: 14),)),

                ),
                TextField(
                  controller: confirmarSenhaController,
                  decoration: InputDecoration(label: Text("Confirmar Senha", style: TextStyle(fontSize: 14),)),

                ),
            ],)
          ),
            Padding(padding: EdgeInsets.only(top: 15,bottom: 45), child:
            ElevatedButton(onPressed: (){
              postUser();
            }, child: Text("Cadastrar"))
            ),
            Text(stringResult),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return TelaLogin();
                }));

              },
              child: Text('Ja tem uma conta?    logar',style: TextStyle(color: Colors.blue, fontSize: 10),),
            )

          ],),),
    );
  }
}
