
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpcomplete/TelaUser.dart';

class TelaLogin extends StatefulWidget {

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var stringResult = "";

  postLogar() async{
    if(emailController.text == "" || senhaController == ""){
      setState(() {
        stringResult = "Você não digitou todos os campos";
      });
    }else {
      setState(() {
        stringResult = "";
      });
      var body = json.encode({
        "email": emailController.text,
        "senha": senhaController.text
      });
      var url = Uri.parse("https://localhost:44336/v1/users/Logar");

      var response = await http.post(url,
          headers:
          { 'Content-type': 'application/json; charset=UTF-8'}
            ,
            body: body);

      print(response.statusCode);
      if(response.statusCode == 200){
        Navigator.push(context, MaterialPageRoute(builder: (context){
        return TelaUser(emailController.text);
        }));
      }
      else{

        setState(() {
          stringResult = "Ocorreu um erro ao tentar logar";
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
              Text("Logar", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300),),
              Container(
                  width: 150,
                  height: 110,
                  decoration: BoxDecoration(border: Border.all(color: Colors.blue,width: 2),borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(label: Text("Email", style: TextStyle(fontSize: 14),)),

                      ),
                      TextField(
                        controller: senhaController,
                        decoration: InputDecoration(label: Text("Senha", style: TextStyle(fontSize: 14),)),

                      ),
                    ],)
              ),
              Padding(padding: EdgeInsets.only(top: 15,bottom: 45), child:
              ElevatedButton(onPressed: (){
                postLogar();
              }, child: Text("Logar"))
              ),
              Text(stringResult),

            ],),),
      );
    }
  }
