import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:httpcomplete/TelaFeed.dart';
import 'package:httpcomplete/TelaUserPosts.dart';
import 'package:httpcomplete/models/userModel.dart';

class TelaUser extends StatefulWidget {

  String emailUser;
  TelaUser(this.emailUser);

  @override
  _TelaUserState createState() => _TelaUserState();
}

class _TelaUserState extends State<TelaUser> {
  
  
  Future<userModel> GetUser() async{
    var emailUser = widget.emailUser;
    var url = Uri.parse("https://localhost:44336/v1/users/$emailUser");
    var response = await http.get(url,
    headers: { 'Content-type': 'application/json; charset=UTF-8'}
    );
    var jsonUser = jsonDecode(response.body);
    var UserFuture = userModel(jsonUser['usarname'], jsonUser['email']);
    print(UserFuture.Email);
    print(response.statusCode);
    return UserFuture;
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: EdgeInsets.only(top: 30,bottom: 150),
          child: Text("Meu perfil", style: TextStyle(color: Colors.blue, fontSize: 24), textAlign: TextAlign.center,
          ),
          ),
          Expanded(child:
          FutureBuilder<userModel>(
            future: GetUser(),
            builder: (context,snapchot){
              switch(snapchot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator.adaptive());
                  break;
                case ConnectionState.done:
                  return Column(
                    children: [
                      Container(
                        width: 320,
                        height: 150,

                        decoration: BoxDecoration(color: Colors.blue,border: Border.all(color: Colors.blue,width: 2),borderRadius: BorderRadius.circular(6)),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.assignment_ind, size: 60, color: Colors.white,),
                            Text("UserName: " + snapchot.data.Username,style: TextStyle(fontSize: 16, color: Colors.white),),
                            Text("Email: " + snapchot.data.Email,style: TextStyle(fontSize: 16,color: Colors.white),),
                          ],
                        )
                        ,
                      ),

                      Padding(padding: EdgeInsets.only(top: 40),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return TelaFeed();
                            }));
                          }, child: Text("Feed")),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return TelaUserPosts(snapchot.data.Email);
                            }));
                          }, child: Text("Meus Posts")),


                        ],)
                        ,)

                    ],
                  );
              }

            },
          ))
        ],
      ),
    );
  }
}
